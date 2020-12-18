--Spring Module
--Made by Octonions and BlocksRocks

--Localized functions (speed)
local cos = math.cos
local sin = math.sin

--Constants
local E = 2.718281828459

--Solved spring function that returns position and velocity given initial conditions and time
local function springSolved(p, b, v, k, d, t)
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

local Spring = {}
Spring.__index = Spring

--Create a new spring object
function Spring.new(prop)
	local self = setmetatable({}, Spring)
	
	--Variables
	self.time     = prop.time     or tick()
	self.position = prop.position or 0
	self.velocity = prop.velocity or 0

	--Constants
	self.target   = prop.target   or 0
	self.constant = prop.constant or 0
	self.dampness = prop.dampness or 0
	
	return self
end

--Update the spring given a time input
function Spring:Update(time1)
	--Variables
	local time0     = self.time
	local position0 = self.position
	local velocity0 = self.velocity

	--Constants
	local target    = self.target
	local constant  = self.constant
	local dampness  = self.dampness

	--Calculation
	local timed = time1 - time0

	--Dewit
	local position1, velocity1 = springSolved(
		position0,
		target,
		velocity0,
		constant,
		dampness,
		timed
	)

	--Output
	self.time     = time1
	self.position = position1
	self.velocity = velocity1
end

return Spring
