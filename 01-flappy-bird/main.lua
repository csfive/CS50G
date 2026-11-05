local push = require('push')
local config = require('config')
local assets = require('assets')
local input = require('input')
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
        assets.sounds.pause:play()
        assets.sounds.music:pause()
    else
        assets.sounds.music:play()
    end
end

local function drawPauseOverlay()
    love.graphics.setColor(0, 0, 0, 0.45)
    love.graphics.rectangle('fill', 0, 0, config.VIRTUAL_WIDTH, config.VIRTUAL_HEIGHT)

    love.graphics.setColor(1, 1, 1)
    local barWidth, barHeight, gap = 16, 64, 12
    local x = config.VIRTUAL_WIDTH / 2 - barWidth - gap / 2
    local y = config.VIRTUAL_HEIGHT / 2 - barHeight / 2 - 10
    love.graphics.rectangle('fill', x, y, barWidth, barHeight, 3, 3)
    love.graphics.rectangle('fill', x + barWidth + gap, y, barWidth, barHeight, 3, 3)

    love.graphics.setFont(assets.fonts.flappy)
    love.graphics.printf('PAUSED', 0, y + barHeight + 12, config.VIRTUAL_WIDTH, 'center')
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Fifty Bird')
    love.window.setMode(config.WINDOW_WIDTH, config.WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true,
    })
    push.setupScreen(config.VIRTUAL_WIDTH, config.VIRTUAL_HEIGHT, { upscale = 'normal' })

    assets.load()

    assets.sounds.music:setLooping(true)
    assets.sounds.music:play()

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
    input.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    elseif key == 'p' then
        -- Assignment: pause gameplay, music, and show the pause icon.
        togglePause()
    end
end

function love.mousepressed(x, y, button)
    input.mousepressed(button)
end

function love.update(dt)
    dt = math.min(dt, 1 / 60)

    if paused then
        input.clear()
        return
    end

    if stateMachine.currentName ~= 'score' then
        backgroundScroll = (backgroundScroll + config.BACKGROUND_SCROLL_SPEED * dt) % config.BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + config.GROUND_SCROLL_SPEED * dt) % config.VIRTUAL_WIDTH
    end

    stateMachine:update(dt)
    input.clear()
end

function love.draw()
    push.start()

    love.graphics.draw(assets.textures.background, -backgroundScroll, 0)
    stateMachine:render()
    love.graphics.draw(assets.textures.ground, -groundScroll, config.VIRTUAL_HEIGHT - config.GROUND_HEIGHT)

    if paused then
        drawPauseOverlay()
    end

    push.finish()
end
