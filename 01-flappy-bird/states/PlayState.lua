local Class = require('class')
local BaseState = require('states.BaseState')
local config = require('config')
local assets = require('assets')
local Bird = require('Bird')
local PipePair = require('PipePair')

local PlayState = Class({ __includes = BaseState })

local function randomSpawnInterval()
    return config.PIPE_SPAWN_MIN + love.math.random() * (config.PIPE_SPAWN_MAX - config.PIPE_SPAWN_MIN)
end

function PlayState:init(stateMachine)
    self.stateMachine = stateMachine
    self.bird = Bird()
    self.pipePairs = {}
    self.spawnTimer = 0
    self.spawnInterval = randomSpawnInterval()
    self.score = 0
    self.lastY = -config.PIPE_HEIGHT + love.math.random(80) + 20
end

function PlayState:die()
    assets.sounds.explosion:play()
    assets.sounds.hurt:play()
    self.stateMachine:change('score', { score = self.score })
end

function PlayState:update(dt)
    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer >= self.spawnInterval then
        -- Assignment: randomize both the vertical gap and the spawn interval.
        local gapHeight = love.math.random(config.PIPE_GAP_MIN, config.PIPE_GAP_MAX)
        local y = math.max(
            -config.PIPE_HEIGHT + 10,
            math.min(
                self.lastY + love.math.random(-config.PIPE_Y_JITTER, config.PIPE_Y_JITTER),
                config.VIRTUAL_HEIGHT - gapHeight - config.PIPE_HEIGHT
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

        if not pair.scored and pair.x + config.PIPE_WIDTH < self.bird.x then
            self.score = self.score + 1
            pair.scored = true
            assets.sounds.score:play()
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

    if self.bird.y + self.bird.height > config.VIRTUAL_HEIGHT - config.GROUND_HEIGHT then
        self:die()
    end
end

function PlayState:render()
    for _, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()

    love.graphics.setFont(assets.fonts.flappy)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
end

return PlayState
