local push = require('push')
local Paddle = require('Paddle')

local VIRTUAL_WIDTH = 432
local VIRTUAL_HEIGHT = 243
local PADDLE_WIDTH = 5
local PADDLE_HEIGHT = 20
local PADDLE_SPEED = 200
local PADDLE_INSET = 10
local PADDLE_TOP_MARGIN = 30
local PADDLE_BOTTOM_MARGIN = 10
local BALL_SIZE = 4

local FONT_SIZES = {
    small = 8,
    large = 16,
    score = 32,
}
local HUD_PADDING = 10

local PALETTE = {
    background = { 40 / 255, 45 / 255, 52 / 255 },
    text = { 1, 1, 1 },
    accent = { 0, 1, 0 },
}

local fonts = {}
local player1, player2

local function displayFPS()
    love.graphics.setFont(fonts.small)
    love.graphics.setColor(PALETTE.accent)
    love.graphics.print('FPS: ' .. love.timer.getFPS(), HUD_PADDING, HUD_PADDING)
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    fonts.small = love.graphics.newFont('font.ttf', FONT_SIZES.small)
    fonts.large = love.graphics.newFont('font.ttf', FONT_SIZES.large)
    fonts.score = love.graphics.newFont('font.ttf', FONT_SIZES.score)

    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    player1 = Paddle(PADDLE_INSET, PADDLE_TOP_MARGIN, PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle(
        VIRTUAL_WIDTH - PADDLE_WIDTH - PADDLE_INSET,
        VIRTUAL_HEIGHT - PADDLE_HEIGHT - PADDLE_BOTTOM_MARGIN,
        PADDLE_WIDTH,
        PADDLE_HEIGHT
    )
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    player1:update(dt, VIRTUAL_HEIGHT)
    player2:update(dt, VIRTUAL_HEIGHT)
end

function love.draw()
    push.start()
    love.graphics.clear(PALETTE.background)

    love.graphics.setColor(PALETTE.text)
    player1:render()
    player2:render()

    displayFPS()

    push.finish()
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
