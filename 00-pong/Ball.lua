local Class = require('class')

local Ball = Class({})

function Ball:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

return Ball
