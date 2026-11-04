local push = require('push')
local Paddle = require('Paddle')
local Ball = require('Ball')

local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720
local VIRTUAL_WIDTH = 432
local VIRTUAL_HEIGHT = 243
local PADDLE_WIDTH = 5
local PADDLE_HEIGHT = 20
local PADDLE_SPEED = 200
local PADDLE_INSET = 10
local PADDLE_START_Y = (VIRTUAL_HEIGHT - PADDLE_HEIGHT) / 2
local BALL_SIZE = 4
local BALL_MAX_SPEED = 480
local AI_TRACKING_GAIN = 20
local WINNING_SCORE = 10

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
local sounds = {}
local player1, player2
local ball

local gameState = 'start'
local player1Score = 0
local player2Score = 0
local servingPlayer = 1
local winningPlayer

local function handlePaddleInput(paddle, upKey, downKey)
    if love.keyboard.isDown(upKey) then
        paddle.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown(downKey) then
        paddle.dy = PADDLE_SPEED
    else
        paddle.dy = 0
    end
end

-- Assignment AI: steer toward an incoming ball, recenter otherwise.
local function updateAIPaddle()
    if gameState == 'start' or gameState == 'done' then
        player2.dy = 0
        return
    end

    local targetY = VIRTUAL_HEIGHT / 2
    if ball.dx > 0 then
        targetY = ball.y + ball.size / 2
    end

    local offset = targetY - (player2.y + player2.height / 2)
    player2.dy = math.max(-PADDLE_SPEED, math.min(PADDLE_SPEED, offset * AI_TRACKING_GAIN))
end

local function resetBall()
    ball:reset(VIRTUAL_WIDTH / 2 - BALL_SIZE / 2, VIRTUAL_HEIGHT / 2 - BALL_SIZE / 2)
end

local function beginServe()
    resetBall()
    ball.dy = math.random(-50, 50)
    if servingPlayer == 1 then
        ball.dx = math.random(140, 200)
    else
        ball.dx = -math.random(140, 200)
    end
    gameState = 'serve'
end

local function reflectBall(correctedX)
    ball.dx = math.max(-BALL_MAX_SPEED, math.min(BALL_MAX_SPEED, -ball.dx * 1.03))
    ball.x = correctedX

    if ball.dy < 0 then
        ball.dy = -math.random(10, 150)
    else
        ball.dy = math.random(10, 150)
    end

    sounds.paddle_hit:play()
end

local function awardPoint(scoringPlayer)
    if scoringPlayer == 1 then
        player1Score = player1Score + 1
    else
        player2Score = player2Score + 1
    end

    sounds.score:play()

    if player1Score >= WINNING_SCORE or player2Score >= WINNING_SCORE then
        winningPlayer = scoringPlayer
        resetBall()
        gameState = 'done'
    else
        servingPlayer = scoringPlayer == 1 and 2 or 1
        beginServe()
    end
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        fullscreen = false,
        vsync = true,
    })
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    fonts.small = love.graphics.newFont('font.ttf', FONT_SIZES.small)
    fonts.large = love.graphics.newFont('font.ttf', FONT_SIZES.large)
    fonts.score = love.graphics.newFont('font.ttf', FONT_SIZES.score)

    sounds.paddle_hit = love.audio.newSource('sounds/paddle_hit.wav', 'static')
    sounds.wall_hit = love.audio.newSource('sounds/wall_hit.wav', 'static')
    sounds.score = love.audio.newSource('sounds/score.wav', 'static')

    player1 = Paddle(PADDLE_INSET, PADDLE_START_Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle(VIRTUAL_WIDTH - PADDLE_WIDTH - PADDLE_INSET, PADDLE_START_Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    ball = Ball(VIRTUAL_WIDTH / 2 - BALL_SIZE / 2, VIRTUAL_HEIGHT / 2 - BALL_SIZE / 2, BALL_SIZE)
end

function love.update(dt)
    dt = math.min(dt, 1 / 60)

    handlePaddleInput(player1, 'w', 's')
    updateAIPaddle()

    player1:update(dt, VIRTUAL_HEIGHT)
    player2:update(dt, VIRTUAL_HEIGHT)

    if gameState ~= 'play' then
        return
    end

    ball:update(dt)

    if ball:collides(player1) then
        reflectBall(player1.x + player1.width)
    elseif ball:collides(player2) then
        reflectBall(player2.x - ball.size)
    end

    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
        sounds.wall_hit:play()
    elseif ball.y >= VIRTUAL_HEIGHT - ball.size then
        ball.y = VIRTUAL_HEIGHT - ball.size
        ball.dy = -ball.dy
        sounds.wall_hit:play()
    end

    if ball.x < 0 then
        awardPoint(2)
    elseif ball.x > VIRTUAL_WIDTH then
        awardPoint(1)
    end
end

local function displayScore()
    local scoreY = VIRTUAL_HEIGHT / 3
    local scoreBoxWidth = 100
    love.graphics.setFont(fonts.score)
    love.graphics.setColor(PALETTE.text)
    love.graphics.printf(tostring(player1Score), VIRTUAL_WIDTH / 2 - scoreBoxWidth, scoreY, scoreBoxWidth, 'center')
    love.graphics.printf(tostring(player2Score), VIRTUAL_WIDTH / 2, scoreY, scoreBoxWidth, 'center')
end

local function displayFPS()
    love.graphics.setFont(fonts.small)
    love.graphics.setColor(PALETTE.accent)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), HUD_PADDING, HUD_PADDING)
end

function love.draw()
    push.start()
    love.graphics.clear(PALETTE.background)

    love.graphics.setColor(PALETTE.text)
    if gameState == 'start' then
        love.graphics.setFont(fonts.small)
        love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('W/S to move - AI plays right', 0, 30, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(fonts.small)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        love.graphics.setFont(fonts.large)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(fonts.small)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    end

    displayScore()
    player1:render()
    player2:render()
    ball:render()

    displayFPS()

    push.finish()
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'return' then
        if gameState == 'start' then
            beginServe()
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            servingPlayer = winningPlayer == 1 and 2 or 1
            winningPlayer = nil
            player1Score = 0
            player2Score = 0
            player1.y, player1.dy = PADDLE_START_Y, 0
            player2.y, player2.dy = PADDLE_START_Y, 0
            beginServe()
        end
    end
end
