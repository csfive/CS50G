local Class = require('class')
local BaseState = require('states.BaseState')
local config = require('config')
local assets = require('assets')

local COUNTDOWN_TIME = 0.75

local CountdownState = Class({ __includes = BaseState })

function CountdownState:init(stateMachine)
    self.stateMachine = stateMachine
    self.count = 3
    self.timer = 0
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer >= COUNTDOWN_TIME then
        self.timer = self.timer - COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            self.stateMachine:change('play')
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(assets.fonts.huge)
    love.graphics.printf(tostring(self.count), 0, 110, config.VIRTUAL_WIDTH, 'center')
end

return CountdownState
