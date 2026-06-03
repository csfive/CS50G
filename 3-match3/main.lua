require 'src.Dependencies'

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 512, 288
BACKGROUND_SCROLL_SPEED = 80

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Match 3')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    backgroundX = 0
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    backgroundX = backgroundX - BACKGROUND_SCROLL_SPEED * dt
    if backgroundX <= -1024 + VIRTUAL_WIDTH - 4 + 51 then
        backgroundX = 0
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push.start()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['background'], backgroundX, 0)
    push.finish()
end
