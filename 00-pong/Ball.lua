local Class = require('class')

local Ball = Class({})

function Ball:init(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.dx = 0
    self.dy = 0
end

function Ball:reset(x, y)
    self.x = x
    self.y = y
    self.dx = 0
    self.dy = 0
end

function Ball:collides(paddle)
    if self.x >= paddle.x + paddle.width or paddle.x >= self.x + self.size then
        return false
    end

    if self.y >= paddle.y + paddle.height or paddle.y >= self.y + self.size then
        return false
    end

    return true
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

return Ball
