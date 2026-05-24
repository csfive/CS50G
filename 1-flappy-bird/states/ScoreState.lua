ScoreState = Class { __includes = BaseState }

local MEDAL_THRESHOLDS = {
    { score = 10, texture = 'gold' },
    { score = 5,  texture = 'silver' },
    { score = 2,  texture = 'bronze' }
}

function ScoreState:enter(params)
    self.score = params.score
    self.medal = nil

    for _, medal in ipairs(MEDAL_THRESHOLDS) do
        if self.score >= medal.score then
            self.medal = gTextures[medal.texture]
            break
        end
    end
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.medal then
        love.graphics.draw(
            self.medal,
            VIRTUAL_WIDTH / 2 - self.medal:getWidth() / 2,
            130
        )
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
end
