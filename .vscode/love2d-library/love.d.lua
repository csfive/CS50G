---@meta love2d

-- version: 11.5
---
---[Open in Browser](https://love2d.org/wiki/love)
---
---@class love
love = {}

--region love.Data

---The superclass of all data.
---
---[Open in Browser](https://love2d.org/wiki/Data)
---
---@class love.Data : love.Object
Data = {}

---Creates a new copy of the Data object.
---
---[Open in Browser](https://love2d.org/wiki/Data:clone)
---
---@param self love.Data
---@return love.Data clone The new copy.
function Data:clone() end

---Gets an FFI pointer to the Data.
---
---This function should be preferred instead of Data:getPointer because the latter uses light userdata which can't store more all possible memory addresses on some new ARM64 architectures, when LuaJIT is used.
---
---[Open in Browser](https://love2d.org/wiki/Data:getFFIPointer)
---
---@param self love.Data
---@return cdata pointer A raw void* pointer to the Data, or nil if FFI is unavailable.
function Data:getFFIPointer() end

---Gets a pointer to the Data. Can be used with libraries such as LuaJIT's FFI.
---
---[Open in Browser](https://love2d.org/wiki/Data:getPointer)
---
---@param self love.Data
---@return lightuserdata pointer A raw pointer to the Data.
function Data:getPointer() end

---Gets the Data's size in bytes.
---
---[Open in Browser](https://love2d.org/wiki/Data:getSize)
---
---@param self love.Data
---@return number size The size of the Data in bytes.
function Data:getSize() end

---Gets the full Data as a string.
---
---[Open in Browser](https://love2d.org/wiki/Data:getString)
---
---@param self love.Data
---@return string data The raw data.
function Data:getString() end

--endregion love.Data

--region love.Object

---The superclass of all LÖVE types.
---
---[Open in Browser](https://love2d.org/wiki/Object)
---
---@class love.Object
Object = {}

---Destroys the object's Lua reference. The object will be completely deleted if it's not referenced by any other LÖVE object or thread.
---
---This method can be used to immediately clean up resources without waiting for Lua's garbage collector.
---
---[Open in Browser](https://love2d.org/wiki/Object:release)
---
---@param self love.Object
---@return boolean success True if the object was released by this call, false if it had been previously released.
function Object:release() end

---Gets the type of the object as a string.
---
---[Open in Browser](https://love2d.org/wiki/Object:type)
---
---@param self love.Object
---@return string type The type as a string.
function Object:type() end

---Checks whether an object is of a certain type. If the object has the type with the specified name in its hierarchy, this function will return true.
---
---[Open in Browser](https://love2d.org/wiki/Object:typeOf)
---
---@param self love.Object
---@param name string The name of the type to check for.
---@return boolean b True if the object is of the specified type, false otherwise.
function Object:typeOf(name) end

--endregion love.Object

---Gets the current running version of LÖVE.
---
---[Open in Browser](https://love2d.org/wiki/love.getVersion)
---
---For LÖVE versions below 0.9.1, the following variables can be used instead (and still work in 0.9.2 and newer):
---
---love._version_major
---
---love._version_minor
---
---love._version_revision
---@return number major The major version of LÖVE, i.e. 0 for version 0.9.1.
---@return number minor The minor version of LÖVE, i.e. 9 for version 0.9.1.
---@return number revision The revision version of LÖVE, i.e. 1 for version 0.9.1.
---@return string codename The codename of the current version, i.e. 'Baby Inspector' for version 0.9.1.
function love.getVersion() end

---Gets whether LÖVE displays warnings when using deprecated functionality. It is disabled by default in fused mode, and enabled by default otherwise.
---
---When deprecation output is enabled, the first use of a formally deprecated LÖVE API will show a message at the bottom of the screen for a short time, and print the message to the console.
---
---[Open in Browser](https://love2d.org/wiki/love.hasDeprecationOutput)
---
---@return boolean enabled Whether deprecation output is enabled.
function love.hasDeprecationOutput() end

---Gets whether the given version is compatible with the current running version of LÖVE.
---
---[Open in Browser](https://love2d.org/wiki/love.isVersionCompatible)
---
---@param major number The major version to check (for example 11 for 11.3 or 0 for 0.10.2).
---@param minor number The minor version to check (for example 3 for 11.3 or 10 for 0.10.2).
---@param revision number The revision of version to check (for example 0 for 11.3 or 2 for 0.10.2).
---@return boolean compatible Whether the given version is compatible with the current running version of LÖVE.
---@overload fun(version: string): boolean
function love.isVersionCompatible(major, minor, revision) end

---Sets whether LÖVE displays warnings when using deprecated functionality. It is disabled by default in fused mode, and enabled by default otherwise.
---
---When deprecation output is enabled, the first use of a formally deprecated LÖVE API will show a message at the bottom of the screen for a short time, and print the message to the console.
---
---[Open in Browser](https://love2d.org/wiki/love.setDeprecationOutput)
---
---@param enable boolean Whether to enable or disable deprecation output.
function love.setDeprecationOutput(enable) end

---Options for `love.conf`.
---@class love.conf.t
---@field identity string This flag determines the name of the save directory for your game. Note that you can only specify the name, not the location where it will be created: (defaults to `nil`).
---@field appendidentity? boolean This flag determines if game directory should be searched first then save directory (true) or otherwise (false) (defaults to `false`).
---@field version? string t.version should be a string, representing the version of LÖVE for which your game was made. It should be formatted as "X.Y.Z" where X is the major release number, Y the minor, and Z the patch level. It allows LÖVE to display a warning if it isn't compatible. Its default is the version of LÖVE running. (defaults to `"11.5"`).
---@field console? boolean Determines whether a console should be opened alongside the game window (Windows only) or not. Note: On OSX you can get console output by running LÖVE through the terminal. (defaults to `false`).
---@field accelerometerjoystick? boolean Sets whether the device accelerometer on iOS and Android should be exposed as a 3-axis Joystick. Disabling the accelerometer when it's not used may reduce CPU usage. (defaults to `true`).
---@field externalstorage? boolean Sets whether files are saved in external storage (true) or internal storage (false) on Android. (defaults to `false`).
---@field gammacorrect? boolean Determines whether gamma-correct rendering is enabled, when the system supports it. (defaults to `false`).
---@field audio love.conf.t.audio Audio options.
---@field window love.conf.t.window It is possible to defer window creation until love.window.setMode is first called in your code. To do so, set t.window = nil in love.conf (or t.screen = nil in older versions.) If this is done, LÖVE may crash if any function from love.graphics is called before the first love.window.setMode in your code.
---@field modules love.conf.t.modules Module options.

---Options for `love.conf`.
---@class love.conf.t.audio
---@field mic boolean Request microphone permission from the user. When user allows it, love.audio.getRecordingDevices will lists recording devices available. Otherwise, love.audio.getRecordingDevices returns empty table and a message is shown to inform user when called. (defaults to `false`).
---@field mixwithsystem? boolean Sets whether background audio / music from other apps should play while LÖVE is open. See love.system.hasBackgroundMusic for more details. (defaults to `true`).

---Options for `love.conf`.
---@class love.conf.t.window
---@field title string Sets the title of the window the game is in. Alternatively love.window.setTitle can be used to change the window title outside of the config file. (defaults to `"Untitled"`).
---@field icon? string A filepath to an image to use as the window's icon. Not all operating systems support very large icon images. The icon can also be changed with love.window.setIcon. (defaults to `nil`).
---@field width? number Sets the window's dimensions. If these flags are set to 0 LÖVE automatically uses the user's desktop dimensions. (defaults to `800`).
---@field height? number Sets the window's dimensions. If these flags are set to 0 LÖVE automatically uses the user's desktop dimensions. (defaults to `600`).
---@field borderless? boolean Removes all border visuals from the window. Note that the effects may wary between operating systems. (defaults to `false`).
---@field resizable? boolean If set to true this allows the user to resize the game's window. (defaults to `false`).
---@field minwidth? number Sets the minimum width and height for the game's window if it can be resized by the user. If you set lower values to window.width and window.height LÖVE will always favor the minimum dimensions set via window.minwidth and window.minheight. (defaults to `1`).
---@field minheight? number Sets the minimum width and height for the game's window if it can be resized by the user. If you set lower values to window.width and window.height LÖVE will always favor the minimum dimensions set via window.minwidth and window.minheight. (defaults to `1`).
---@field fullscreen? boolean Whether to run the game in fullscreen (true) or windowed (false) mode. The fullscreen can also be toggled via love.window.setFullscreen or love.window.setMode. (defaults to `false`).
---@field fullscreentype? string Specifies the type of fullscreen mode to use (normal or desktop). Generally the desktop is recommended, as it is less restrictive than normal mode on some operating systems. (defaults to `"desktop"`).
---@field usedpiscale? boolean Sets whetever to enable or disable automatic DPI scaling. (defaults to `true`).
---@field vsync? number Enables or deactivates vertical synchronization. Vsync tries to keep the game at a steady framerate and can prevent issues like screen tearing. It is recommended to keep vsync activated if you don't know about the possible implications of turning it off. Before LÖVE 11.0, this value was boolean (true or false). Since LÖVE 11.0, this value is number (1 to enable vsync, 0 to disable vsync, -1 to use adaptive vsync when supported). (defaults to `true`).
---@field depth? number The number of bits per sample in the depth buffer (16/24/32, default nil) (defaults to `nil`).
---@field stencil? number Then number of bits per sample in the depth buffer (generally 8, default nil) (defaults to `nil`).
---@field msaa? number The number of samples to use with multi-sampled antialiasing. (defaults to `0`).
---@field display? number The index of the display to show the window in, if multiple monitors are available. (defaults to `1`).
---@field highdpi? boolean See love.window.getPixelScale, love.window.toPixels, and love.window.fromPixels. It is recommended to keep this option disabled if you can't test your game on a Mac or iOS system with a Retina display, because code will need tweaking to make sure things look correct. (defaults to `false`).
---@field x? number Determines the position of the window on the user's screen. Alternatively love.window.setPosition can be used to change the position on the fly. (defaults to `nil`).
---@field y? number Determines the position of the window on the user's screen. Alternatively love.window.setPosition can be used to change the position on the fly. (defaults to `nil`).

---Options for `love.conf`.
---@class love.conf.t.modules
---@field audio boolean Enable the audio module. (defaults to `true`).
---@field event? boolean Enable the event module. (defaults to `true`).
---@field graphics? boolean Enable the graphics module. (defaults to `true`).
---@field image? boolean Enable the image module. (defaults to `true`).
---@field joystick? boolean Enable the joystick module. (defaults to `true`).
---@field keyboard? boolean Enable the keyboard module. (defaults to `true`).
---@field math? boolean Enable the math module. (defaults to `true`).
---@field mouse? boolean Enable the mouse module. (defaults to `true`).
---@field physics? boolean Enable the physics module. (defaults to `true`).
---@field sound? boolean Enable the sound module. (defaults to `true`).
---@field system? boolean Enable the system module. (defaults to `true`).
---@field timer? boolean Enable the timer module. (defaults to `true`).
---@field touch? boolean Enable the touch module. (defaults to `true`).
---@field video? boolean Enable the video module. (defaults to `true`).
---@field window? boolean Enable the window module. (defaults to `true`).
---@field thread? boolean Enable the thread module. (defaults to `true`).

---If a file called conf.lua is present in your game folder (or .love file), it is run before the LÖVE modules are loaded. You can use this file to overwrite the love.conf function, which is later called by the LÖVE 'boot' script. Using the love.conf function, you can set some configuration options, and change things like the default size of the window, which modules are loaded, and other stuff.
---
---[Open in Browser](https://love2d.org/wiki/love.conf)
---
---@param t { identity: string, appendidentity: boolean, version: string, console: boolean, accelerometerjoystick: boolean, externalstorage: boolean, gammacorrect: boolean, audio: { mic: boolean, mixwithsystem: boolean }, window: { title: string, icon: string, width: number, height: number, borderless: boolean, resizable: boolean, minwidth: number, minheight: number, fullscreen: boolean, fullscreentype: string, usedpiscale: boolean, vsync: number, depth: number, stencil: number, msaa: number, display: number, highdpi: boolean, x: number, y: number }, modules: { audio: boolean, event: boolean, graphics: boolean, image: boolean, joystick: boolean, keyboard: boolean, math: boolean, mouse: boolean, physics: boolean, sound: boolean, system: boolean, timer: boolean, touch: boolean, video: boolean, window: boolean, thread: boolean } } The love.conf function takes one argument: a table filled with all the default values which you can overwrite to your liking. If you want to change the default window size, for instance, do:
---
---function love.conf(t)
---    t.window.width = 1024
---    t.window.height = 768
---end
---
---If you don't need the physics module or joystick module, do the following.
---
---function love.conf(t)
---    t.modules.joystick = false
---    t.modules.physics = false
---end
---
---Setting unused modules to false is encouraged when you release your game. It reduces startup time slightly (especially if the joystick module is disabled) and reduces memory usage (slightly).
---
---Note that you can't disable love.filesystem; it's mandatory. The same goes for the love module itself. love.graphics needs love.window to be enabled.
function love.conf(t) end

---Callback function triggered when a directory is dragged and dropped onto the window.
---
---[Open in Browser](https://love2d.org/wiki/love.directorydropped)
---
---Paths passed into this callback are able to be used with love.filesystem.mount, which is the only way to get read access via love.filesystem to the dropped directory. love.filesystem.mount does not generally accept other full platform-dependent directory paths that haven't been dragged and dropped onto the window.
---@param path string The full platform-dependent path to the directory. It can be used as an argument to love.filesystem.mount, in order to gain read access to the directory with love.filesystem.
function love.directorydropped(path) end

---Called when the device display orientation changed, for example, user rotated their phone 180 degrees.
---
---[Open in Browser](https://love2d.org/wiki/love.displayrotated)
---
---@param index number The index of the display that changed orientation.
---@param orientation love.DisplayOrientation The new orientation.
function love.displayrotated(index, orientation) end

---Callback function used to draw on the screen every frame.
---
---[Open in Browser](https://love2d.org/wiki/love.draw)
---
function love.draw() end

---The error handler, used to display error messages.
---
---[Open in Browser](https://love2d.org/wiki/love.errorhandler)
---
---@param msg string The error message.
---@return function mainLoop Function which handles one frame, including events and rendering, when called. If this is nil then LÖVE exits immediately.
function love.errorhandler(msg) end

---Callback function triggered when a file is dragged and dropped onto the window.
---
---[Open in Browser](https://love2d.org/wiki/love.filedropped)
---
---@param file love.DroppedFile The unopened File object representing the file that was dropped.
function love.filedropped(file) end

---Callback function triggered when window receives or loses focus.
---
---[Open in Browser](https://love2d.org/wiki/love.focus)
---
---@param focus boolean True if the window gains focus, false if it loses focus. 
function love.focus(focus) end

---Called when a Joystick's virtual gamepad axis is moved.
---
---[Open in Browser](https://love2d.org/wiki/love.gamepadaxis)
---
---@param joystick love.Joystick The joystick object.
---@param axis love.GamepadAxis The virtual gamepad axis.
---@param value number The new axis value.
function love.gamepadaxis(joystick, axis, value) end

---Called when a Joystick's virtual gamepad button is pressed.
---
---[Open in Browser](https://love2d.org/wiki/love.gamepadpressed)
---
---@param joystick love.Joystick The joystick object.
---@param button love.GamepadButton The virtual gamepad button.
function love.gamepadpressed(joystick, button) end

---Called when a Joystick's virtual gamepad button is released.
---
---[Open in Browser](https://love2d.org/wiki/love.gamepadreleased)
---
---@param joystick love.Joystick The joystick object.
---@param button love.GamepadButton The virtual gamepad button.
function love.gamepadreleased(joystick, button) end

---Called when a Joystick is connected.
---
---[Open in Browser](https://love2d.org/wiki/love.joystickadded)
---
---This callback is also triggered after love.load for every Joystick which was already connected when the game started up.
---@param joystick love.Joystick The newly connected Joystick object.
function love.joystickadded(joystick) end

---Called when a joystick axis moves.
---
---[Open in Browser](https://love2d.org/wiki/love.joystickaxis)
---
---@param joystick love.Joystick The joystick object.
---@param axis number The axis number.
---@param value number The new axis value.
function love.joystickaxis(joystick, axis, value) end

---Called when a joystick hat direction changes.
---
---[Open in Browser](https://love2d.org/wiki/love.joystickhat)
---
---@param joystick love.Joystick The joystick object.
---@param hat number The hat number.
---@param direction love.JoystickHat The new hat direction.
function love.joystickhat(joystick, hat, direction) end

---Called when a joystick button is pressed.
---
---[Open in Browser](https://love2d.org/wiki/love.joystickpressed)
---
---@param joystick love.Joystick The joystick object.
---@param button number The button number.
function love.joystickpressed(joystick, button) end

---Called when a joystick button is released.
---
---[Open in Browser](https://love2d.org/wiki/love.joystickreleased)
---
---@param joystick love.Joystick The joystick object.
---@param button number The button number.
function love.joystickreleased(joystick, button) end

---Called when a Joystick is disconnected.
---
---[Open in Browser](https://love2d.org/wiki/love.joystickremoved)
---
---@param joystick love.Joystick The now-disconnected Joystick object.
function love.joystickremoved(joystick) end

---Callback function triggered when a key is pressed.
---
---[Open in Browser](https://love2d.org/wiki/love.keypressed)
---
---Scancodes are keyboard layout-independent, so the scancode 'w' will be generated if the key in the same place as the 'w' key on an American keyboard is pressed, no matter what the key is labelled or what the user's operating system settings are.
---
---Key repeat needs to be enabled with love.keyboard.setKeyRepeat for repeat keypress events to be received. This does not affect love.textinput.
---@param key love.KeyConstant Character of the pressed key.
---@param scancode love.Scancode The scancode representing the pressed key.
---@param isrepeat boolean Whether this keypress event is a repeat. The delay between key repeats depends on the user's system settings.
---Key repeat needs to be enabled with love.keyboard.setKeyRepeat for repeat keypress events to be received.
---@overload fun(key: love.KeyConstant, isrepeat: boolean): nil
function love.keypressed(key, scancode, isrepeat) end

---Callback function triggered when a keyboard key is released.
---
---[Open in Browser](https://love2d.org/wiki/love.keyreleased)
---
---Scancodes are keyboard layout-independent, so the scancode 'w' will be used if the key in the same place as the 'w' key on an American keyboard is pressed, no matter what the key is labelled or what the user's operating system settings are.
---@param key love.KeyConstant Character of the released key.
---@param scancode love.Scancode The scancode representing the released key.
function love.keyreleased(key, scancode) end

---This function is called exactly once at the beginning of the game.
---
---[Open in Browser](https://love2d.org/wiki/love.load)
---
---In LÖVE 11.0, the passed arguments excludes the game name and the fused command-line flag (if exist) when runs from non-fused LÖVE executable. Previous version pass the argument as-is without any filtering.
---@param arg table Command-line arguments given to the game.
---@param unfilteredArg table Unfiltered command-line arguments given to the executable (see #Notes).
function love.load(arg, unfilteredArg) end

---Callback function triggered when the system is running out of memory on mobile devices.
---
---Mobile operating systems may forcefully kill the game if it uses too much memory, so any non-critical resource should be removed if possible (by setting all variables referencing the resources to '''nil'''), when this event is triggered. Sounds and images in particular tend to use the most memory.
---
---[Open in Browser](https://love2d.org/wiki/love.lowmemory)
---
function love.lowmemory() end

---Callback function triggered when window receives or loses mouse focus.
---
---[Open in Browser](https://love2d.org/wiki/love.mousefocus)
---
---@param focus boolean Whether the window has mouse focus or not.
function love.mousefocus(focus) end

---Callback function triggered when the mouse is moved.
---
---[Open in Browser](https://love2d.org/wiki/love.mousemoved)
---
---If Relative Mode is enabled for the mouse, the '''dx''' and '''dy''' arguments of this callback will update but '''x''' and '''y''' are not guaranteed to.
---@param x number The mouse position on the x-axis.
---@param y number The mouse position on the y-axis.
---@param dx number The amount moved along the x-axis since the last time love.mousemoved was called.
---@param dy number The amount moved along the y-axis since the last time love.mousemoved was called.
---@param istouch boolean True if the mouse button press originated from a touchscreen touch-press.
function love.mousemoved(x, y, dx, dy, istouch) end

---Callback function triggered when a mouse button is pressed.
---
---[Open in Browser](https://love2d.org/wiki/love.mousepressed)
---
---Use love.wheelmoved to detect mouse wheel motion. It will not register as a button press in version 0.10.0 and newer.
---@param x number Mouse x position, in pixels.
---@param y number Mouse y position, in pixels.
---@param button number The button index that was pressed. 1 is the primary mouse button, 2 is the secondary mouse button and 3 is the middle button. Further buttons are mouse dependent.
---@param istouch boolean True if the mouse button press originated from a touchscreen touch-press.
---@param presses number The number of presses in a short time frame and small area, used to simulate double, triple clicks
function love.mousepressed(x, y, button, istouch, presses) end

---Callback function triggered when a mouse button is released.
---
---[Open in Browser](https://love2d.org/wiki/love.mousereleased)
---
---@param x number Mouse x position, in pixels.
---@param y number Mouse y position, in pixels.
---@param button number The button index that was released. 1 is the primary mouse button, 2 is the secondary mouse button and 3 is the middle button. Further buttons are mouse dependent.
---@param istouch boolean True if the mouse button release originated from a touchscreen touch-release.
---@param presses number The number of presses in a short time frame and small area, used to simulate double, triple clicks
function love.mousereleased(x, y, button, istouch, presses) end

---Callback function triggered when the game is closed.
---
---[Open in Browser](https://love2d.org/wiki/love.quit)
---
---@return boolean r Abort quitting. If true, do not close the game.
function love.quit() end

---Called when the window is resized, for example if the user resizes the window, or if love.window.setMode is called with an unsupported width or height in fullscreen and the window chooses the closest appropriate size.
---
---[Open in Browser](https://love2d.org/wiki/love.resize)
---
---Calls to love.window.setMode will '''only''' trigger this event if the width or height of the window after the call doesn't match the requested width and height. This can happen if a fullscreen mode is requested which doesn't match any supported mode, or if the fullscreen type is 'desktop' and the requested width or height don't match the desktop resolution.
---
---Since 11.0, this function returns width and height in DPI-scaled units rather than pixels.
---@param w number The new width.
---@param h number The new height.
function love.resize(w, h) end

---The main function, containing the main loop. A sensible default is used when left out.
---
---[Open in Browser](https://love2d.org/wiki/love.run)
---
---@return function mainLoop Function which handlers one frame, including events and rendering when called.
function love.run() end

---Called when the candidate text for an IME (Input Method Editor) has changed.
---
---The candidate text is not the final text that the user will eventually choose. Use love.textinput for that.
---
---[Open in Browser](https://love2d.org/wiki/love.textedited)
---
---@param text string The UTF-8 encoded unicode candidate text.
---@param start number The start cursor of the selected candidate text.
---@param length number The length of the selected candidate text. May be 0.
function love.textedited(text, start, length) end

---Called when text has been entered by the user. For example if shift-2 is pressed on an American keyboard layout, the text '@' will be generated.
---
---[Open in Browser](https://love2d.org/wiki/love.textinput)
---
---Although Lua strings can store UTF-8 encoded unicode text just fine, many functions in Lua's string library will not treat the text as you might expect. For example, #text (and string.len(text)) will give the number of ''bytes'' in the string, rather than the number of unicode characters. The Lua wiki and a presentation by one of Lua's creators give more in-depth explanations, with some tips.
---
---The utf8 library can be used to operate on UTF-8 encoded unicode text (such as the text argument given in this function.)
---
---On Android and iOS, textinput is disabled by default; call love.keyboard.setTextInput to enable it.
---@param text string The UTF-8 encoded unicode text.
function love.textinput(text) end

---Callback function triggered when a Thread encounters an error.
---
---[Open in Browser](https://love2d.org/wiki/love.threaderror)
---
---@param thread love.Thread The thread which produced the error.
---@param errorstr string The error message.
function love.threaderror(thread, errorstr) end

---Callback function triggered when a touch press moves inside the touch screen.
---
---[Open in Browser](https://love2d.org/wiki/love.touchmoved)
---
---The identifier is only guaranteed to be unique for the specific touch press until love.touchreleased is called with that identifier, at which point it may be reused for new touch presses.
---
---The unofficial Android and iOS ports of LÖVE 0.9.2 reported touch positions as normalized values in the range of 1, whereas this API reports positions in pixels.
---@param id lightuserdata The identifier for the touch press.
---@param x number The x-axis position of the touch inside the window, in pixels.
---@param y number The y-axis position of the touch inside the window, in pixels.
---@param dx number The x-axis movement of the touch inside the window, in pixels.
---@param dy number The y-axis movement of the touch inside the window, in pixels.
---@param pressure number The amount of pressure being applied. Most touch screens aren't pressure sensitive, in which case the pressure will be 1.
function love.touchmoved(id, x, y, dx, dy, pressure) end

---Callback function triggered when the touch screen is touched.
---
---[Open in Browser](https://love2d.org/wiki/love.touchpressed)
---
---The identifier is only guaranteed to be unique for the specific touch press until love.touchreleased is called with that identifier, at which point it may be reused for new touch presses.
---
---The unofficial Android and iOS ports of LÖVE 0.9.2 reported touch positions as normalized values in the range of 1, whereas this API reports positions in pixels.
---@param id lightuserdata The identifier for the touch press.
---@param x number The x-axis position of the touch press inside the window, in pixels.
---@param y number The y-axis position of the touch press inside the window, in pixels.
---@param dx number The x-axis movement of the touch press inside the window, in pixels. This should always be zero.
---@param dy number The y-axis movement of the touch press inside the window, in pixels. This should always be zero.
---@param pressure number The amount of pressure being applied. Most touch screens aren't pressure sensitive, in which case the pressure will be 1.
function love.touchpressed(id, x, y, dx, dy, pressure) end

---Callback function triggered when the touch screen stops being touched.
---
---[Open in Browser](https://love2d.org/wiki/love.touchreleased)
---
---The identifier is only guaranteed to be unique for the specific touch press until love.touchreleased is called with that identifier, at which point it may be reused for new touch presses.
---
---The unofficial Android and iOS ports of LÖVE 0.9.2 reported touch positions as normalized values in the range of 1, whereas this API reports positions in pixels.
---@param id lightuserdata The identifier for the touch press.
---@param x number The x-axis position of the touch inside the window, in pixels.
---@param y number The y-axis position of the touch inside the window, in pixels.
---@param dx number The x-axis movement of the touch inside the window, in pixels.
---@param dy number The y-axis movement of the touch inside the window, in pixels.
---@param pressure number The amount of pressure being applied. Most touch screens aren't pressure sensitive, in which case the pressure will be 1.
function love.touchreleased(id, x, y, dx, dy, pressure) end

---Callback function used to update the state of the game every frame.
---
---[Open in Browser](https://love2d.org/wiki/love.update)
---
---@param dt number Time since the last update in seconds.
function love.update(dt) end

---Callback function triggered when window is minimized/hidden or unminimized by the user.
---
---[Open in Browser](https://love2d.org/wiki/love.visible)
---
---@param visible boolean True if the window is visible, false if it isn't.
function love.visible(visible) end

---Callback function triggered when the mouse wheel is moved.
---
---[Open in Browser](https://love2d.org/wiki/love.wheelmoved)
---
---@param x number Amount of horizontal mouse wheel movement. Positive values indicate movement to the right.
---@param y number Amount of vertical mouse wheel movement. Positive values indicate upward movement.
function love.wheelmoved(x, y) end

---@alias cdata any
---@alias RenderTargetSetup any
---@alias Variant any

return love
