local Class = require('class')
local Config = require('config')
local Assets = require('assets')
local Input = require('input')

local Bird = Class({})

function Bird:init()
    self.image = Assets.textures.bird
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = Config.VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = Config.VIRTUAL_HEIGHT / 2 - self.height / 2
    self.dy = 0
end

function Bird:collides(pipe)
    local left, top = self.x + 2, self.y + 2
    local right, bottom = self.x + self.width - 2, self.y + self.height - 2

    return right >= pipe.x and left <= pipe.x + pipe.width and bottom >= pipe.y and top <= pipe.y + pipe.height
end

function Bird:update(dt)
    self.dy = self.dy + Config.GRAVITY * dt

    if Input.wasPressed('space') or Input.mouseWasPressed(1) then
        self.dy = Config.FLAP_VELOCITY
        Assets.sounds.jump:play()
    end

    self.y = self.y + self.dy * dt
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

return Bird
