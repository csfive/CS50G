local Class = require('class')
local config = require('config')
local assets = require('assets')
local input = require('input')

local Bird = Class({})

function Bird:init()
    self.image = assets.textures.bird
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = config.VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = config.VIRTUAL_HEIGHT / 2 - self.height / 2
    self.dy = 0
end

function Bird:collides(pipe)
    local left, top = self.x + 2, self.y + 2
    local right, bottom = self.x + self.width - 2, self.y + self.height - 2

    return right >= pipe.x and left <= pipe.x + pipe.width and bottom >= pipe.y and top <= pipe.y + pipe.height
end

function Bird:update(dt)
    self.dy = self.dy + config.GRAVITY * dt

    if input.wasPressed('space') or input.mouseWasPressed(1) then
        self.dy = config.FLAP_VELOCITY
        assets.sounds.jump:play()
    end

    self.y = self.y + self.dy * dt
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

return Bird
