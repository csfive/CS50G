Paddle = Class {}

function Paddle:init(skin)
    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 32
    self.dx = 0
    self.width = 64
    self.height = 16
    self.skin = skin or 1
    self.size = 2
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(
        gTextures['main'],
        gFrames['paddles'][self.size + 4 * (self.skin - 1)],
        self.x, self.y
    )
end

function Paddle:resize(newSize)
    self.size = math.max(1, math.min(4, newSize))
    local widths = { [1] = 32, [2] = 64, [3] = 96, [4] = 128 }
    self.width = widths[self.size]
    self.x = math.min(self.x, VIRTUAL_WIDTH - self.width)
end
