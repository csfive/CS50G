local push = require('push')
local Config = require('config')
local Assets = require('assets')
local Input = require('input')
local StateMachine = require('StateMachine')
local TitleScreenState = require('states.TitleScreenState')
local CountdownState = require('states.CountdownState')
local PlayState = require('states.PlayState')
local ScoreState = require('states.ScoreState')

local backgroundScroll = 0
local groundScroll = 0
local paused = false
local stateMachine

local function togglePause()
    paused = not paused

    if paused then
        Assets.sounds.pause:play()
        Assets.sounds.music:pause()
    else
        Assets.sounds.music:play()
    end
end

local function drawPauseOverlay()
    love.graphics.setColor(0, 0, 0, 0.45)
    love.graphics.rectangle('fill', 0, 0, Config.VIRTUAL_WIDTH, Config.VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1)
    local barWidth, barHeight, gap = 16, 64, 12
    local x = Config.VIRTUAL_WIDTH / 2 - barWidth - gap / 2
    local y = Config.VIRTUAL_HEIGHT / 2 - barHeight / 2 - 10
    love.graphics.rectangle('fill', x, y, barWidth, barHeight, 3, 3)
    love.graphics.rectangle('fill', x + barWidth + gap, y, barWidth, barHeight, 3, 3)

    love.graphics.setFont(Assets.fonts.flappy)
    love.graphics.printf('PAUSED', 0, y + barHeight + 12, Config.VIRTUAL_WIDTH, 'center')
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Fifty Bird')
    love.window.setMode(Config.WINDOW_WIDTH, Config.WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true,
    })
    push.setupScreen(Config.VIRTUAL_WIDTH, Config.VIRTUAL_HEIGHT, { upscale = 'normal' })

    Assets.load()

    Assets.sounds.music:setLooping(true)
    Assets.sounds.music:play()

    stateMachine = StateMachine({
        title = function()
            return TitleScreenState(stateMachine)
        end,
        countdown = function()
            return CountdownState(stateMachine)
        end,
        play = function()
            return PlayState(stateMachine)
        end,
        score = function()
            return ScoreState(stateMachine)
        end,
    })
    stateMachine:change('title')
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.keypressed(key)
    Input.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    elseif key == 'p' then
        -- Assignment: pause gameplay, music, and show the pause icon.
        togglePause()
    end
end

function love.mousepressed(x, y, button)
    Input.mousepressed(button)
end

function love.update(dt)
    dt = math.min(dt, 1 / 60)

    if paused then
        Input.clear()
        return
    end

    if stateMachine.currentName ~= 'score' then
        backgroundScroll = (backgroundScroll + Config.BACKGROUND_SCROLL_SPEED * dt) % Config.BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + Config.GROUND_SCROLL_SPEED * dt) % Config.VIRTUAL_WIDTH
    end

    stateMachine:update(dt)
    Input.clear()
end

function love.draw()
    push.start()

    love.graphics.draw(Assets.textures.background, -backgroundScroll, 0)
    stateMachine:render()
    love.graphics.draw(Assets.textures.ground, -groundScroll, Config.VIRTUAL_HEIGHT - Config.GROUND_HEIGHT)

    if paused then
        drawPauseOverlay()
    end

    push.finish()
end
