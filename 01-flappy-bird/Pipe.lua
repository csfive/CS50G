local Class = require('class')
local config = require('config')
local assets = require('assets')

local Pipe = Class({})

function Pipe:init(x, y, orientation)
    self.x = x
    self.y = y
    self.width = config.PIPE_WIDTH
    self.height = config.PIPE_HEIGHT
    self.orientation = orientation
end

function Pipe:render()
    local drawY = self.orientation == 'top' and self.y + self.height or self.y
    local scaleY = self.orientation == 'top' and -1 or 1
    love.graphics.draw(assets.textures.pipe, self.x, drawY, 0, 1, scaleY)
end

return Pipe
