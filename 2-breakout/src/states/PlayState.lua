PlayState = Class { __includes = BaseState }

function PlayState:enter(params)
    self.level = params.level
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.recoverPoints = params.recoverPoints
    self.growPoints = params.growPoints

    self.ball = params.ball
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    self.balls = { self.ball }
    self.powerups = {}
    self.hasKey = false
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    self.paddle:update(dt)

    for i, ball in pairs(self.balls) do
        ball:update(dt)

        -- ball-paddle collision
        if ball:collides(self.paddle) then
            ball.y = self.paddle.y - ball.height
            ball.dy = -ball.dy

            local isPaddleMovingLeft = self.paddle.dx < 0
            local isPaddleMovingRight = self.paddle.dx > 0
            local paddleCenter = self.paddle.x + self.paddle.width / 2
            local startingBounceDX = 50
            local bounceAngleMultiplier = 8

            if ball.x < paddleCenter and isPaddleMovingLeft then
                local ballOffset = paddleCenter - ball.x
                ball.dx = -startingBounceDX - bounceAngleMultiplier * ballOffset
            elseif ball.x > paddleCenter and isPaddleMovingRight then
                local ballOffset = ball.x - paddleCenter
                ball.dx = startingBounceDX + bounceAngleMultiplier * ballOffset
            end

            gSounds['paddle-hit']:play()
        end

        -- ball-brick collision (only one brick per ball per frame)
        for k, brick in pairs(self.bricks) do
            if brick.inPlay and ball:collides(brick) then
                if brick.locked then
                    if self.hasKey then
                        brick:unlock()
                        self.hasKey = false
                        self.score = self.score + 1000
                    end
                else
                    self.score = self.score + (brick.tier * 200 + brick.color * 25)
                    brick:hit()
                end

                if self.score > self.recoverPoints then
                    self.health = math.min(3, self.health + 1)
                    self.recoverPoints = math.min(100000, self.recoverPoints * 2)
                    gSounds['recover']:play()
                end

                if self.score > self.growPoints then
                    self.paddle:resize(self.paddle.size + 1)
                    self.growPoints = math.min(100000, self.growPoints * 2)
                    gSounds['recover']:play()
                end

                -- spawn powerup when a non-locked brick is destroyed
                if not brick.inPlay and not brick.locked then
                    if math.random(1, 10) == 1 then
                        local hasLocked = false
                        for _, b in pairs(self.bricks) do
                            if b.locked and b.inPlay then
                                hasLocked = true
                                break
                            end
                        end

                        local powerupType
                        if hasLocked and not self.hasKey then
                            powerupType = math.random(1, 2) == 1 and POWERUP_KEY or POWERUP_BALLS
                        else
                            powerupType = POWERUP_BALLS
                        end

                        table.insert(self.powerups, Powerup(
                            brick.x + brick.width / 2 - 8,
                            brick.y,
                            powerupType
                        ))
                    end
                end

                if self:checkVictory() then
                    gSounds['victory']:play()
                    gStateMachine:change('victory', {
                        level = self.level,
                        paddle = self.paddle,
                        ball = self.ball,
                        health = self.health,
                        score = self.score,
                        highScores = self.highScores,
                    recoverPoints = self.recoverPoints,
                    growPoints = self.growPoints
                    })
                    return
                end

                local BALL_RADIUS = 4
                local BRICK_W, BRICK_H = brick.width, brick.height
                local cxB, cyB = brick.x + BRICK_W / 2, brick.y + BRICK_H / 2
                local cxb, cyb = ball.x + BALL_RADIUS, ball.y + BALL_RADIUS
                local ox = cxB - cxb
                local oy = cyB - cyb
                local px = BRICK_W / 2 + BALL_RADIUS - math.abs(ox)
                local py = BRICK_H / 2 + BALL_RADIUS - math.abs(oy)

                if px < py then
                    ball.dx = -ball.dx
                    ball.x = ball.x + (ox > 0 and -px or px)
                else
                    ball.dy = -ball.dy
                    ball.y = ball.y + (oy > 0 and -py or py)
                end

                if math.abs(ball.dy) < 150 then
                    ball.dy = ball.dy * 1.02
                end

                break
            end
        end
    end

    for i = #self.balls, 1, -1 do
        if self.balls[i].y >= VIRTUAL_HEIGHT then
            table.remove(self.balls, i)
        end
    end

    if #self.balls == 0 then
        self.health = self.health - 1
        gSounds['hurt']:play()

        self.paddle:resize(self.paddle.size - 1)

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                level = self.level,
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                recoverPoints = self.recoverPoints,
                growPoints = self.growPoints
            })
        end
        return
    end

    -- keep primary ball
    if #self.balls > 0 then
        self.ball = self.balls[1]
    end

    for i, powerup in pairs(self.powerups) do
        powerup:update(dt)

        if powerup.inPlay and powerup:collides(self.paddle) then
            powerup.inPlay = false

            if powerup.powerupType == POWERUP_BALLS then
                for j = 1, 2 do
                    local newBall = Ball(math.random(7))
                    newBall.x = self.paddle.x + (self.paddle.width / 2) - (self.ball.width / 2)
                    newBall.y = self.paddle.y - self.ball.height
                    newBall.dx = math.random(-200, 200)
                    newBall.dy = math.random(-50, -60)
                    table.insert(self.balls, newBall)
                end
                gSounds['confirm']:play()
            elseif powerup.powerupType == POWERUP_KEY then
                self.hasKey = true
                gSounds['confirm']:play()
            end
        end
    end

    for i = #self.powerups, 1, -1 do
        if not self.powerups[i].inPlay then
            table.remove(self.powerups, i)
        end
    end

    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    for k, powerup in pairs(self.powerups) do
        powerup:render()
    end

    self.paddle:render()

    for k, ball in pairs(self.balls) do
        ball:render()
    end

    renderScore(self.score)
    renderHealth(self.health)

    if self.hasKey then
        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.print('KEY', 5, VIRTUAL_HEIGHT - 12)
        love.graphics.setColor(1, 1, 1, 1)
    end

    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end
    end
    return true
end
