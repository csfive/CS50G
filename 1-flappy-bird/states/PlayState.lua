PlayState = Class { __includes = BaseState }

PIPE_SPEED = 60
PIPE_WIDTH, PIPE_HEIGHT = 70, 288
BIRD_WIDTH, BIRD_HEIGHT = 38, 24

local function drawPauseIcon()
    local barWidth, barHeight, gap = 14, 48, 12
    local totalWidth = barWidth * 2 + gap
    local x = VIRTUAL_WIDTH / 2 - totalWidth / 2
    local y = VIRTUAL_HEIGHT / 2 - barHeight / 2

    love.graphics.setColor(1, 1, 1, 0.95)
    love.graphics.rectangle('fill', x, y, barWidth, barHeight)
    love.graphics.rectangle('fill', x + barWidth + gap, y, barWidth, barHeight)
    love.graphics.setColor(1, 1, 1, 1)
end

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.spawnTimer = 0
    self.spawnInterval = math.random(2, 3)
    self.score = 0
    self.paused = false
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then
        self.paused = not self.paused
        gSounds['pause']:play()

        if self.paused then
            scrolling = false
            gSounds['music']:pause()
        else
            scrolling = true
            gSounds['music']:play()
        end
    end

    if self.paused then
        return
    end

    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer > self.spawnInterval then
        local y = math.max(
            -PIPE_HEIGHT + 10,
            math.min(
                self.lastY + math.random(-20, 20),
                VIRTUAL_HEIGHT - GAP_MAX - PIPE_HEIGHT
            )
        )
        table.insert(self.pipePairs, PipePair(y))
        self.lastY = y
        self.spawnTimer = 0
        self.spawnInterval = math.random(2, 3)
    end

    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                gSounds['score']:play()
            end
        end
        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gSounds['explosion']:play()
                gSounds['hurt']:play()

                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end
    end

    self.bird:update(dt)

    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gSounds['explosion']:play()
        gSounds['hurt']:play()

        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()

    if self.paused then
        drawPauseIcon()
    end
end

function PlayState:enter()
    scrolling = true
    self.paused = false
end

function PlayState:exit()
    scrolling = false
end
