// blocksrey

'use strict'

let cos = Math.cos
let sin = Math.sin
let exp = Math.exp
let sqrt = Math.sqrt

let spring_new = (p, v) => { return {p: p, v: v} }

let spring_step = (spring, b, k, d, t) => {
	let p = spring.p
	let v = spring.v

	let h = sqrt(1 - d*d)
	t *= h*k // not really correct but whatever
	let s = sin(t)
	let c = h*cos(t) // not really c, more like hc
	let y = h*exp(d*t/h) // more like hy i guess

	// assuming k > 0 && d < 1
	spring.p = b + (k*(p - b)*(c + d*s) + v*s)/(k*y)
	spring.v = (k*(b - p)*s + v*(c - d*s))/y
}