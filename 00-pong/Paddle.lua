local Class = require('class')

local Paddle = Class({})

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt, worldHeight)
    self.y = self.y + self.dy * dt
    self.y = math.max(0, math.min(worldHeight - self.height, self.y))
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

return Paddle
