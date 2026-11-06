local Class = require('class')
local BaseState = require('states.BaseState')
local config = require('config')
local assets = require('assets')
local input = require('input')

local TitleScreenState = Class({ __includes = BaseState })

function TitleScreenState:update(dt)
    if input.confirmPressed() then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(assets.fonts.flappy)
    love.graphics.printf('Fifty Bird', 0, 64, config.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(assets.fonts.medium)
    love.graphics.printf('Press Enter to start', 0, 110, config.VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(assets.fonts.small)
    love.graphics.printf('Space / click to flap - P to pause', 0, 140, config.VIRTUAL_WIDTH, 'center')
end

return TitleScreenState
