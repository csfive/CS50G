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

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['begin-game'] = function() return BeginGameState() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('start')

    backgroundX = 0
    love.keyboard.keysPressed = {}
    love.mouseButtonsPressed = {}
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

function love.mousepressed(x, y, button)
    local gameX, gameY = push.toGame(x, y)

    if gameX and gameY then
        love.mouseButtonsPressed[button] = { x = gameX, y = gameY }
    end
end

function love.mouse.wasPressed(button)
    return love.mouseButtonsPressed[button]
end

function love.update(dt)
    backgroundX = backgroundX - BACKGROUND_SCROLL_SPEED * dt
    if backgroundX <= -1024 + VIRTUAL_WIDTH - 4 + 51 then
        backgroundX = 0
    end

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouseButtonsPressed = {}
end

function love.draw()
    push.start()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['background'], backgroundX, 0)

    gStateMachine:render()
    push.finish()
end
