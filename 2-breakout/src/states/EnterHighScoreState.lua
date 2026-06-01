EnterHighScoreState = Class { __includes = BaseState }

function EnterHighScoreState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
    self.scoreIndex = params.scoreIndex

    self.chars = { 65, 65, 65 }
    self.highlightedChar = 1
end

function EnterHighScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = string.char(self.chars[1], self.chars[2], self.chars[3])
        for i = 10, self.scoreIndex, -1 do
            self.highScores[i + 1] = {
                name = self.highScores[i].name,
                score = self.highScores[i].score
            }
        end
        self.highScores[self.scoreIndex].name = name
        self.highScores[self.scoreIndex].score = self.score

        local scoresStr = ''
        for i = 1, 10 do
            scoresStr = scoresStr .. self.highScores[i].name .. '\n'
            scoresStr = scoresStr .. tostring(self.highScores[i].score) .. '\n'
        end
        love.filesystem.write('breakout.lst', scoresStr)
        gStateMachine:change('high-scores', {
            highScores = self.highScores
        })
    end

    if love.keyboard.wasPressed('left') and self.highlightedChar > 1 then
        self.highlightedChar = self.highlightedChar - 1
        gSounds['select']:play()
    elseif love.keyboard.wasPressed('right') and self.highlightedChar < 3 then
        self.highlightedChar = self.highlightedChar + 1
        gSounds['select']:play()
    end

    if love.keyboard.wasPressed('up') then
        self.chars[self.highlightedChar] = self.chars[self.highlightedChar] + 1
        if self.chars[self.highlightedChar] > 90 then
            self.chars[self.highlightedChar] = 65
        end
    elseif love.keyboard.wasPressed('down') then
        self.chars[self.highlightedChar] = self.chars[self.highlightedChar] - 1
        if self.chars[self.highlightedChar] < 65 then
            self.chars[self.highlightedChar] = 90
        end
    end
end

function EnterHighScoreState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Your score: ' .. tostring(self.score), 0, 30, VIRTUAL_WIDTH, 'center')

    local font = gFonts['large']
    love.graphics.setFont(font)

    local letters = {
        string.char(self.chars[1]),
        string.char(self.chars[2]),
        string.char(self.chars[3])
    }
    local spacing = 8
    local totalWidth = spacing * 2
    for i = 1, 3 do
        totalWidth = totalWidth + font:getWidth(letters[i])
    end

    local x = VIRTUAL_WIDTH / 2 - totalWidth / 2
    local y = VIRTUAL_HEIGHT / 2

    for i = 1, 3 do
        if self.highlightedChar == i then
            love.graphics.setColor(103 / 255, 1, 1, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        love.graphics.print(letters[i], x, y)
        x = x + font:getWidth(letters[i]) + spacing
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter to confirm!', 0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')
end
