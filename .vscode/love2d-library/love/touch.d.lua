---@meta love2d

---Provides an interface to touch-screen presses.
---
---[Open in Browser](https://love2d.org/wiki/love.touch)
---
---@class love.touch
love.touch = {}

---Gets the current position of the specified touch-press, in pixels.
---
---[Open in Browser](https://love2d.org/wiki/love.touch.getPosition)
---
---The unofficial Android and iOS ports of LÖVE 0.9.2 reported touch-press positions as normalized values in the range of 1, whereas this API reports positions in pixels.
---@param id lightuserdata The identifier of the touch-press. Use love.touch.getTouches, love.touchpressed, or love.touchmoved to obtain touch id values.
---@return number x The position along the x-axis of the touch-press inside the window, in pixels.
---@return number y The position along the y-axis of the touch-press inside the window, in pixels.
function love.touch.getPosition(id) end

---Gets the current pressure of the specified touch-press.
---
---[Open in Browser](https://love2d.org/wiki/love.touch.getPressure)
---
---@param id lightuserdata The identifier of the touch-press. Use love.touch.getTouches, love.touchpressed, or love.touchmoved to obtain touch id values.
---@return number pressure The pressure of the touch-press. Most touch screens aren't pressure sensitive, in which case the pressure will be 1.
function love.touch.getPressure(id) end

---Gets a list of all active touch-presses.
---
---[Open in Browser](https://love2d.org/wiki/love.touch.getTouches)
---
---The id values are the same as those used as arguments to love.touchpressed, love.touchmoved, and love.touchreleased.
---
---The id value of a specific touch-press is only guaranteed to be unique for the duration of that touch-press. As soon as love.touchreleased is called using that id, it may be reused for a new touch-press via love.touchpressed.
---@return lightuserdata[] touches A list of active touch-press id values, which can be used with love.touch.getPosition.
function love.touch.getTouches() end

