--spring module
--made by octonions and blocksrocks1234

--localized
local cos = math.cos
local sin = math.sin

--constants
local E = 2.718281828459

local function solved(p, b, v, k, d, t)
	if k > 0 then
		if d < 1 then
			local h = (1 - d*d)^(1/2)
			local si = sin(h*k*t)
			local co = h*cos(h*k*t)
			local ex = h*E^(d*k*t)
			return b + (k*(p - b)*(co + d*si) + v*si)/(k*ex), (k*(b - p)*si + v*(co - d*si))/ex
		else
			local ex = E^(k*t)
			return b + ((p - b)*(1 + k*t) + v*t)/ex, (v - (k*(p - b) + v)*k*t)/ex
		end
	else
		return p + t*v, v
	end
end

local function new(prop)
	local self    = {}
	
	--variables
	self.tick     = prop.tick     or tick()
	self.position = prop.position or 0
	self.velocity = prop.velocity or 0
	
	--constants
	self.target   = prop.target   or 0
	self.constant = prop.constant or 0
	self.dampness = prop.dampness or 0
	
	return self
end

local function update(self, tick1)
	--variables
	local tick0     = self.tick
	local position0 = self.position
	local velocity0 = self.velocity
	
	--constants
	local target    = self.target
	local constant  = self.constant
	local dampness  = self.dampness
	
	--calculation
	local tickd = tick1 - tick0
	
	--dewit
	local position1, velocity1 = solved(
		position0,
		target,
		velocity0,
		constant,
		dampness,
		tickd
	)
	
	--output
	self.tick     = tick1
	self.position = position1
	self.velocity = velocity1
end

return {
	solved = solved;
	new    = new;
	update = update;
}