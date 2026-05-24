push = require 'libs.push'
Class = require 'libs.class'

require 'StateMachine'
require 'states.BaseState'
require 'states.CountdownState'
require 'states.PlayState'
require 'states.ScoreState'
require 'states.TitleScreenState'

require 'Bird'
require 'Pipe'
require 'PipePair'

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 512, 288

local BACKGROUND_SCROLL_SPEED, GROUND_SCROLL_SPEED = 30, 60
local BACKGROUND_LOOPING_POINT = 413
local backgroundScroll, groundScroll = 0, 0

scrolling = true

local function createMedalImage(r, g, b)
    local size = 32
    local data = love.image.newImageData(size, size)
    local cx, cy, radius = (size - 1) / 2, (size - 1) / 2, 14

    for y = 0, size - 1 do
        for x = 0, size - 1 do
            local dx, dy = x - cx, y - cy
            if dx * dx + dy * dy <= radius * radius then
                data:setPixel(x, y, r, g, b, 1)
            else
                data:setPixel(x, y, 0, 0, 0, 0)
            end
        end
    end

    return love.graphics.newImage(data)
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Bird')
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('fonts/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('fonts/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('fonts/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    gTextures = {
        ['background'] = love.graphics.newImage('images/background.png'),
        ['ground'] = love.graphics.newImage('images/ground.png'),
        ['bird'] = love.graphics.newImage('images/bird.png'),
        ['pipe'] = love.graphics.newImage('images/pipe.png'),
        ['bronze'] = createMedalImage(0.8, 0.5, 0.2),
        ['silver'] = createMedalImage(0.75, 0.75, 0.8),
        ['gold'] = createMedalImage(1, 0.84, 0)
    }

    gSounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
        ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static')
    }

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = true,
        resizable = true
    })

    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)
    if scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
    end

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push.start()

    love.graphics.draw(gTextures['background'], -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(gTextures['ground'], -groundScroll, VIRTUAL_HEIGHT - 16)

    push.finish()
end
