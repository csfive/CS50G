push = require 'push'
Class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 432, 243
PADDLE_WIDTH, PADDLE_HEIGHT = 5, 20
PADDLE_SPEED = 200
BALL_SIZE = 4
WINNING_SCORE = 3

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle("Pong")
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        resizable = true,
        fullscreen = false
    })
    push.setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, { upscale = 'normal' })

    player1 = Paddle(10, 30, PADDLE_WIDTH, PADDLE_HEIGHT)
    player2 = Paddle(VIRTUAL_WIDTH - 10 - PADDLE_WIDTH, VIRTUAL_HEIGHT - 50, PADDLE_WIDTH, PADDLE_HEIGHT)
    ball = Ball(VIRTUAL_WIDTH / 2 - BALL_SIZE / 2, VIRTUAL_HEIGHT / 2 - BALL_SIZE / 2, BALL_SIZE, BALL_SIZE)

    player1Score = 0
    player2Score = 0

    -- 当前发球的玩家，得分了就由另一个玩家发球
    servingPlayer = 1

    -- 获胜玩家，在游戏结束时设置为 1 或 2
    winningPlayer = 0

    -- 游戏状态可能是以下之一：
    -- 1. 'start'（游戏开始，第一次发球前）
    -- 2. 'serve'（等待按键发球）
    -- 3. 'play'（球在对局中，和挡板来回碰撞）
    -- 4. 'done'（游戏结束，出现胜者，等待重开）
    gameState = 'start'
end

function love.resize(w, h)
    push.resize(w, h)
end

function love.update(dt)
    if gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + PADDLE_WIDTH

            -- 保持垂直方向不变，但随机速度大小
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - BALL_SIZE

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end

        if ball.y >= VIRTUAL_HEIGHT - BALL_SIZE then
            ball.y = VIRTUAL_HEIGHT - BALL_SIZE
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end

        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1
            sounds['score']:play()

            if player2Score == WINNING_SCORE then
                winningPlayer = 2
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1
            sounds['score']:play()

            if player1Score == WINNING_SCORE then
                winningPlayer = 1
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end
    end

    -- 不管处于什么状态，挡板都可以移动
    -- player 1
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2
    -- if love.keyboard.isDown('up') then
    --     player2.dy = -PADDLE_SPEED
    -- elseif love.keyboard.isDown('down') then
    --     player2.dy = PADDLE_SPEED
    -- else
    --     player2.dy = 0
    -- end

    -- AI player 2
    local paddleCenter = player2.y + player2.height / 2
    local ballCenter = ball.y + ball.height / 2
    local deadZone = 5

    if gameState == 'play' then
        if ball.dx > 0 then
            -- 飞来的时候，中心点去追球的中心点，死区避免抖动
            if ballCenter < paddleCenter - deadZone then
                player2.dy = -PADDLE_SPEED
            elseif ballCenter > paddleCenter + deadZone then
                player2.dy = PADDLE_SPEED
            else
                player2.dy = 0
            end
        else
            -- 飞走的时候回中间位置待机，不会一直追球
            local homeY = VIRTUAL_HEIGHT / 2 - player2.height / 2
            if paddleCenter < homeY - deadZone then
                player2.dy = PADDLE_SPEED
            elseif paddleCenter > homeY + deadZone then
                player2.dy = -PADDLE_SPEED
            else
                player2.dy = 0
            end
        end
    end

    player1:update(dt)
    player2:update(dt)

    if gameState == 'play' then
        ball:update(dt)
    end
end

function love.draw()
    push.start()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 1)

    if gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'done' then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    end

    player1:render()
    player2:render()
    ball:render()

    displayScore()
    displayFPS()
    push.finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'

            -- 发球速度不需要每帧重算
            ball.dy = math.random(-50, 50)
            if servingPlayer == 1 then
                ball.dx = math.random(140, 200)
            else
                ball.dx = -math.random(140, 200)
            end
        elseif gameState == 'done' then
            gameState = 'serve'

            -- 重置状态
            ball:reset()
            player1Score = 0
            player2Score = 0
            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(1, 1, 1, 1)
end
