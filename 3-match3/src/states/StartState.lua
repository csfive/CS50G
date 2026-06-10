StartState = Class { __includes = BaseState }

local positions = {}

function StartState:init()
    for i = 1, 64 do
        table.insert(positions, gFrames['tiles'][math.random(18)][math.random(6)])
    end

    self.colors = {
        [1] = { 217 / 255, 87 / 255, 99 / 255, 1 },
        [2] = { 95 / 255, 205 / 255, 228 / 255, 1 },
        [3] = { 251 / 255, 242 / 255, 54 / 255, 1 },
        [4] = { 118 / 255, 66 / 255, 138 / 255, 1 },
        [5] = { 153 / 255, 229 / 255, 80 / 255, 1 },
        [6] = { 223 / 255, 113 / 255, 38 / 255, 1 }
    }

    self.letterTable = {
        { 'M', -108 },
        { 'A', -64 },
        { 'T', -28 },
        { 'C', 2 },
        { 'H', 40 },
        { '3', 112 }
    }

    self.colorTimer = Timer.every(0.075, function()
        self.colors[0] = self.colors[6]
        for i = 6, 1, -1 do
            self.colors[i] = self.colors[i - 1]
        end
    end)
end

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    Timer.update(dt)
end

function StartState:render()
    for y = 1, 8 do
        for x = 1, 8 do
            -- render shadow first
            love.graphics.setColor(0, 0, 0, 1)
            love.graphics.draw(
                gTextures['main'],
                positions[(y - 1) * x + x],
                (x - 1) * 32 + 128 + 3,
                (y - 1) * 32 + 16 + 3
            )

            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(
                gTextures['main'],
                positions[(y - 1) * x + x],
                (x - 1) * 32 + 128,
                (y - 1) * 32 + 16
            )
        end
    end

    love.graphics.setColor(0, 0, 0, 128 / 255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    self:drawMatch3Text(-60)
end

function StartState:drawMatch3Text(y)
    love.graphics.setColor(1, 1, 1, 128 / 255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 76, VIRTUAL_HEIGHT / 2 + y - 11, 150, 58, 6)

    love.graphics.setFont(gFonts['large'])
    self:drawTextShadow('MATCH 3', VIRTUAL_HEIGHT / 2 + y)
    for i = 1, 6 do
        love.graphics.setColor(self.colors[i])
        love.graphics.printf(
            self.letterTable[i][1], 0,
            VIRTUAL_HEIGHT / 2 + y,
            VIRTUAL_WIDTH + self.letterTable[i][2],
            'center'
        )
    end

    love.graphics.setColor(1, 1, 1, 1)
end

function StartState:drawTextShadow(text, y)
    love.graphics.setColor(34 / 255, 32 / 255, 52 / 255, 1)
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end
