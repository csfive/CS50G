Paddle = Class {}

function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)
    local newY = self.y + self.dy * dt
    if self.dy < 0 then
        self.y = math.max(0, newY)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, newY)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
