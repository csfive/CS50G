---@meta love2d

---Manages events, like keypresses.
---
---[Open in Browser](https://love2d.org/wiki/love.event)
---
---@class love.event
love.event = {}

---Arguments to love.event.push() and the like.
---
---Since 0.8.0, event names are no longer abbreviated.
---
---[Open in Browser](https://love2d.org/wiki/Event)
---
---@alias love.Event
---| "focus" # Window focus gained or lost
---| "joystickpressed" # Joystick pressed
---| "joystickreleased" # Joystick released
---| "keypressed" # Key pressed
---| "keyreleased" # Key released
---| "mousepressed" # Mouse pressed
---| "mousereleased" # Mouse released
---| "quit" # Quit
---| "resize" # Window size changed by the user
---| "visible" # Window is minimized or un-minimized by the user
---| "mousefocus" # Window mouse focus gained or lost
---| "threaderror" # A Lua error has occurred in a thread
---| "joystickadded" # Joystick connected
---| "joystickremoved" # Joystick disconnected
---| "joystickaxis" # Joystick axis motion
---| "joystickhat" # Joystick hat pressed
---| "gamepadpressed" # Joystick's virtual gamepad button pressed
---| "gamepadreleased" # Joystick's virtual gamepad button released
---| "gamepadaxis" # Joystick's virtual gamepad axis moved
---| "textinput" # User entered text
---| "mousemoved" # Mouse position changed
---| "lowmemory" # Running out of memory on mobile devices system
---| "textedited" # Candidate text for an IME changed
---| "wheelmoved" # Mouse wheel moved
---| "touchpressed" # Touch screen touched
---| "touchreleased" # Touch screen stop touching
---| "touchmoved" # Touch press moved inside touch screen
---| "directorydropped" # Directory is dragged and dropped onto the window
---| "filedropped" # File is dragged and dropped onto the window.
---| "jp" # Joystick pressed
---| "jr" # Joystick released
---| "kp" # Key pressed
---| "kr" # Key released
---| "mp" # Mouse pressed
---| "mr" # Mouse released
---| "q" # Quit
---| "f" # Window focus gained or lost

---Clears the event queue.
---
---[Open in Browser](https://love2d.org/wiki/love.event.clear)
---
function love.event.clear() end

---Returns an iterator for messages in the event queue.
---
---[Open in Browser](https://love2d.org/wiki/love.event.poll)
---
---@return function i Iterator function usable in a for loop.
function love.event.poll() end

---Pump events into the event queue.
---
---This is a low-level function, and is usually not called by the user, but by love.run.
---
---Note that this does need to be called for any OS to think you're still running,
---
---and if you want to handle OS-generated events at all (think callbacks).
---
---[Open in Browser](https://love2d.org/wiki/love.event.pump)
---
function love.event.pump() end

---Adds an event to the event queue.
---
---From 0.10.0 onwards, you may pass an arbitrary amount of arguments with this function, though the default callbacks don't ever use more than six.
---
---[Open in Browser](https://love2d.org/wiki/love.event.push)
---
---@param n love.Event The name of the event.
---@param a Variant First event argument. (defaults to `nil`).
---@param b Variant Second event argument. (defaults to `nil`).
---@param c Variant Third event argument. (defaults to `nil`).
---@param d Variant Fourth event argument. (defaults to `nil`).
---@param e Variant Fifth event argument. (defaults to `nil`).
---@param f Variant Sixth event argument. (defaults to `nil`).
function love.event.push(n, a, b, c, d, e, f, ...) end

---Adds the quit event to the queue.
---
---The quit event is a signal for the event handler to close LÖVE. It's possible to abort the exit process with the love.quit callback.
---
---[Open in Browser](https://love2d.org/wiki/love.event.quit)
---
---@param exitstatus number The program exit status to use when closing the application. (defaults to `0`).
---Restarts the game without relaunching the executable. This cleanly shuts down the main Lua state instance and creates a brand new one.
---@overload fun(restart: string|'restart'): nil
function love.event.quit(exitstatus) end

---Like love.event.poll(), but blocks until there is an event in the queue.
---
---[Open in Browser](https://love2d.org/wiki/love.event.wait)
---
---@return love.Event n The name of event.
---@return Variant a First event argument.
---@return Variant b Second event argument.
---@return Variant c Third event argument.
---@return Variant d Fourth event argument.
---@return Variant e Fifth event argument.
---@return Variant f Sixth event argument.
---@return Variant # Further event arguments may follow.
function love.event.wait() end

