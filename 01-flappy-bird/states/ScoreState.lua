local Class = require('class')
local BaseState = require('states.BaseState')
local config = require('config')
local assets = require('assets')
local input = require('input')

local MEDALS = {
    { threshold = config.MEDAL_THRESHOLDS.gold, texture = 'medalGold', name = 'Gold' },
    { threshold = config.MEDAL_THRESHOLDS.silver, texture = 'medalSilver', name = 'Silver' },
    { threshold = config.MEDAL_THRESHOLDS.bronze, texture = 'medalBronze', name = 'Bronze' },
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
    if input.confirmPressed() then
        self.stateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(assets.fonts.flappy)
    love.graphics.printf('Oof! You lost!', 0, 48, config.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(assets.fonts.medium)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 86, config.VIRTUAL_WIDTH, 'center')

    if self.medal then
        local image = assets.textures[self.medal.texture]
        love.graphics.draw(image, config.VIRTUAL_WIDTH / 2 - image:getWidth() / 2, 112)
        love.graphics.printf(self.medal.name .. ' medal', 0, 152, config.VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('No medal', 0, 128, config.VIRTUAL_WIDTH, 'center')
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 190, config.VIRTUAL_WIDTH, 'center')
end

return ScoreState
