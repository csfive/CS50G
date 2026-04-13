Ball = Class {}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)

end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
