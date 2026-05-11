Pipe = Class {}

function Pipe:init(orientation, y)
    self.width = PIPE_WIDTH
    self.height = PIPE_HEIGHT
    self.x = VIRTUAL_WIDTH + 64
    self.y = y
    self.orientation = orientation
end

function Pipe:update(dt)
end

function Pipe:render()
    love.graphics.draw(
        gTextures['pipe'],
        self.x,
        self.orientation == 'top' and self.y + self.height or self.y,
        0,
        1,
        self.orientation == 'top' and -1 or 1
    )
end
