PlayState = Class { __includes = BaseState }

function PlayState:init()
    self.score = 0
    self.timer = 60

    Timer.every(1, function()
        self.timer = self.timer - 1
        if self.timer <= 5 then
            gSounds['clock']:play()
        end
    end)
end

function PlayState:enter(params)
    self.level = params.level
    self.board = params.board or Board(VIRTUAL_WIDTH - 272, 16)
    self.score = params.score or 0
    self.scoreGoal = self.level * 1.25 * 1000
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if self.timer <= 0 then
        Timer.clear()
        gSounds['game-over']:play()
        gStateMachine:change('game-over', {
            score = self.score
        })
    end

    if self.score >= self.scoreGoal then
        Timer.clear()
        gSounds['next-level']:play()
        gStateMachine:change('begin-game', {
            level = self.level + 1,
            score = self.score
        })
    end

    Timer.update(dt)
end

function PlayState:render()
    self.board:render()
    self:renderText()
end

function PlayState:renderText()
    love.graphics.setColor(56 / 255, 56 / 255, 56 / 255, 234 / 255)
    love.graphics.rectangle('fill', 16, 16, 186, 116, 4)
    love.graphics.setColor(99 / 255, 155 / 255, 1, 1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Level: ' .. tostring(self.level), 20, 24, 182, 'center')
    love.graphics.printf('Score: ' .. tostring(self.score), 20, 52, 182, 'center')
    love.graphics.printf('Goal : ' .. tostring(self.scoreGoal), 20, 80, 182, 'center')
    love.graphics.printf('Timer: ' .. tostring(self.timer), 20, 108, 182, 'center')
end
