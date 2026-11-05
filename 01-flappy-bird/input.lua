local input = {
    keys = {},
    mouseButtons = {},
}

function input.keypressed(key)
    input.keys[key] = true
end

function input.mousepressed(button)
    input.mouseButtons[button] = true
end

function input.wasPressed(key)
    return input.keys[key] == true
end

function input.mouseWasPressed(button)
    return input.mouseButtons[button] == true
end

function input.confirmPressed()
    return input.wasPressed('return') or input.wasPressed('kpenter')
end

function input.clear()
    input.keys = {}
    input.mouseButtons = {}
end

return input
