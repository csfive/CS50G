Tile = Class {}

function Tile:init(x, y, color, variety, shiny)
    self.gridX = x
    self.gridY = y
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32
    self.color = color
    self.variety = variety
    self.shiny = shiny or false
end

function Tile:render(x, y)
    love.graphics.setColor(34 / 255, 32 / 255, 52 / 255, 255 / 255)
    love.graphics.draw(
        gTextures['main'],
        gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2
    )

    love.graphics.setColor(255 / 255, 255 / 255, 255 / 255, 255 / 255)
    love.graphics.draw(
        gTextures['main'],
        gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y
    )

    if self.shiny then
        love.graphics.setBlendMode('add')
        love.graphics.setColor(1, 1, 1, 180 / 255)
        love.graphics.rectangle('line', self.x + x + 4, self.y + y + 4, 24, 24, 4)
        love.graphics.polygon(
            'fill',
            self.x + x + 16, self.y + y + 6,
            self.x + x + 19, self.y + y + 13,
            self.x + x + 26, self.y + y + 16,
            self.x + x + 19, self.y + y + 19,
            self.x + x + 16, self.y + y + 26,
            self.x + x + 13, self.y + y + 19,
            self.x + x + 6, self.y + y + 16,
            self.x + x + 13, self.y + y + 13
        )
        love.graphics.setBlendMode('alpha')
    end
end
