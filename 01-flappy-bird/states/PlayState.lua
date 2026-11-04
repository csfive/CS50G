local Class = require('class')
local BaseState = require('states.BaseState')
local Config = require('config')
local Assets = require('assets')
local Bird = require('Bird')
local PipePair = require('PipePair')

local PlayState = Class({ __includes = BaseState })

local function randomSpawnInterval()
    return Config.PIPE_SPAWN_MIN + love.math.random() * (Config.PIPE_SPAWN_MAX - Config.PIPE_SPAWN_MIN)
end

function PlayState:init(stateMachine)
    self.stateMachine = stateMachine
    self.bird = Bird()
    self.pipePairs = {}
    self.spawnTimer = 0
    self.spawnInterval = randomSpawnInterval()
    self.score = 0
    self.lastY = -Config.PIPE_HEIGHT + love.math.random(80) + 20
end

function PlayState:die()
    Assets.sounds.explosion:play()
    Assets.sounds.hurt:play()
    self.stateMachine:change('score', { score = self.score })
end

function PlayState:update(dt)
    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer >= self.spawnInterval then
        -- Assignment: randomize both the vertical gap and the spawn interval.
        local gapHeight = love.math.random(Config.PIPE_GAP_MIN, Config.PIPE_GAP_MAX)
        local y = math.max(
            -Config.PIPE_HEIGHT + 10,
            math.min(
                self.lastY + love.math.random(-Config.PIPE_Y_JITTER, Config.PIPE_Y_JITTER),
                Config.VIRTUAL_HEIGHT - gapHeight - Config.PIPE_HEIGHT
            )
        )
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y, gapHeight))

        self.spawnInterval = randomSpawnInterval()
        self.spawnTimer = 0
    end

    self.bird:update(dt)

    for _, pair in pairs(self.pipePairs) do
        pair:update(dt)

        if not pair.scored and pair.x + Config.PIPE_WIDTH < self.bird.x then
            self.score = self.score + 1
            pair.scored = true
            Assets.sounds.score:play()
        end
    end

    for i = #self.pipePairs, 1, -1 do
        if self.pipePairs[i].remove then
            table.remove(self.pipePairs, i)
        end
    end

    for _, pair in pairs(self.pipePairs) do
        if self.bird:collides(pair.upper) or self.bird:collides(pair.lower) then
            self:die()
            return
        end
    end

    if self.bird.y + self.bird.height > Config.VIRTUAL_HEIGHT - Config.GROUND_HEIGHT then
        self:die()
    end
end

function PlayState:render()
    for _, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()

    love.graphics.setFont(Assets.fonts.flappy)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end

return PlayState
