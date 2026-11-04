local Input = {
    keys = {},
    mouseButtons = {},
}

function Input.keypressed(key)
    Input.keys[key] = true
end

function Input.mousepressed(button)
    Input.mouseButtons[button] = true
end

function Input.wasPressed(key)
    return Input.keys[key] == true
end

function Input.mouseWasPressed(button)
    return Input.mouseButtons[button] == true
end

function Input.confirmPressed()
    return Input.wasPressed('return') or Input.wasPressed('kpenter')
end

function Input.clear()
    Input.keys = {}
    Input.mouseButtons = {}
end

return Input
