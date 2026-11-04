local Class = require('class')
local BaseState = require('states.BaseState')
local Config = require('config')
local Assets = require('assets')
local Input = require('input')

local MEDALS = {
    { threshold = Config.MEDAL_THRESHOLDS.gold, texture = 'medalGold', name = 'Gold' },
    { threshold = Config.MEDAL_THRESHOLDS.silver, texture = 'medalSilver', name = 'Silver' },
    { threshold = Config.MEDAL_THRESHOLDS.bronze, texture = 'medalBronze', name = 'Bronze' },
}

local ScoreState = Class({ __includes = BaseState })

function ScoreState:init(stateMachine)
    self.stateMachine = stateMachine
    self.score = 0
    self.medal = nil
end

function ScoreState:enter(params)
    self.score = params and params.score or 0
    self.medal = nil

    -- Assignment: award a medal based on the score for this run.
    for _, medal in ipairs(MEDALS) do
        if self.score >= medal.threshold then
            self.medal = medal
            break
        end
    end
end

function ScoreState:update(dt)
    if Input.confirmPressed() then
        self.stateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(Assets.fonts.flappy)
    love.graphics.printf('Oof! You lost!', 0, 48, Config.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(Assets.fonts.medium)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 86, Config.VIRTUAL_WIDTH, 'center')

    if self.medal then
        local image = Assets.textures[self.medal.texture]
        love.graphics.draw(image, Config.VIRTUAL_WIDTH / 2 - image:getWidth() / 2, 112)
        love.graphics.printf(self.medal.name .. ' medal', 0, 152, Config.VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('No medal', 0, 128, Config.VIRTUAL_WIDTH, 'center')
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 190, Config.VIRTUAL_WIDTH, 'center')
end

return ScoreState
