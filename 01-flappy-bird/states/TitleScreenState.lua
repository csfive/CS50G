local Class = require('class')
local BaseState = require('states.BaseState')
local Config = require('config')
local Assets = require('assets')
local Input = require('input')

local TitleScreenState = Class({ __includes = BaseState })

function TitleScreenState:init(stateMachine)
    self.stateMachine = stateMachine
end

function TitleScreenState:update(dt)
    if Input.confirmPressed() then
        self.stateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(Assets.fonts.flappy)
    love.graphics.printf('Fifty Bird', 0, 64, Config.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(Assets.fonts.medium)
    love.graphics.printf('Press Enter to start', 0, 110, Config.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(Assets.fonts.small)
    love.graphics.printf('Space / click to flap - P to pause', 0, 140, Config.VIRTUAL_WIDTH, 'center')
end

return TitleScreenState
