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

    self.canInput = true
    self.highlightedTile = nil
    self.boardHighlightX = 0
    self.boardHighlightY = 0
    self.rectHighlighted = false
    self.isAnimating = false

    Timer.every(0.5, function()
        self.rectHighlighted = not self.rectHighlighted
    end)
end

function PlayState:enter(params)
    self.level = params.level
    self.board = params.board or Board(VIRTUAL_WIDTH - 272, 16, self.level)
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

    if self.canInput then
        if love.keyboard.wasPressed('up') then
            self.boardHighlightY = math.max(0, self.boardHighlightY - 1)
            gSounds['select']:play()
        elseif love.keyboard.wasPressed('down') then
            self.boardHighlightY = math.min(7, self.boardHighlightY + 1)
            gSounds['select']:play()
        elseif love.keyboard.wasPressed('left') then
            self.boardHighlightX = math.max(0, self.boardHighlightX - 1)
            gSounds['select']:play()
        elseif love.keyboard.wasPressed('right') then
            self.boardHighlightX = math.min(7, self.boardHighlightX + 1)
            gSounds['select']:play()
        end

        if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
            self:chooseTile(self.boardHighlightX + 1, self.boardHighlightY + 1)
        end

        local mousePressed = love.mouse.wasPressed(1)
        if mousePressed then
            self:chooseTile(self:screenToGrid(mousePressed.x, mousePressed.y))
        end
    end

    Timer.update(dt)
end

function PlayState:screenToGrid(x, y)
    local gridX = math.floor((x - self.board.x) / 32) + 1
    local gridY = math.floor((y - self.board.y) / 32) + 1

    if gridX < 1 or gridX > 8 or gridY < 1 or gridY > 8 then
        return nil
    end

    return gridX, gridY
end

function PlayState:chooseTile(gridX, gridY)
    if not gridX or not gridY then
        return
    end

    local tile = self.board.tiles[gridY][gridX]
    self.boardHighlightX = gridX - 1
    self.boardHighlightY = gridY - 1

    if not self.highlightedTile then
        self.highlightedTile = tile
        return
    end

    if self.highlightedTile == tile then
        self.highlightedTile = nil
        return
    end

    if math.abs(self.highlightedTile.gridX - gridX) + math.abs(self.highlightedTile.gridY - gridY) > 1 then
        gSounds['error']:play()
        self.highlightedTile = tile
        return
    end

    self:attemptSwap(self.highlightedTile, tile)
end

function PlayState:attemptSwap(tile1, tile2)
    self.canInput = false
    self.isAnimating = true
    self.highlightedTile = nil

    local tile1StartX, tile1StartY = tile1.x, tile1.y
    local tile2StartX, tile2StartY = tile2.x, tile2.y

    self.board:swapTiles(tile1, tile2)

    Timer.tween(0.1, {
        [tile1] = { x = tile2StartX, y = tile2StartY },
        [tile2] = { x = tile1StartX, y = tile1StartY }
    }):finish(function()
        local matches = self.board:calculateMatches()

        if matches then
            self:resolveMatches(matches)
        else
            self.board:swapTiles(tile1, tile2)

            Timer.tween(0.1, {
                [tile1] = { x = tile1StartX, y = tile1StartY },
                [tile2] = { x = tile2StartX, y = tile2StartY }
            }):finish(function()
                self.isAnimating = false
                self.canInput = true

                if not self.board:hasPossibleMatches() then
                    self.board:initializeTiles()
                end
            end)
        end
    end)
end

function PlayState:resolveMatches(matches)
    gSounds['match']:stop()
    gSounds['match']:play()

    local scoredTiles = {}

    for _, match in pairs(matches) do
        for _, tile in pairs(match) do
            if not scoredTiles[tile] then
                scoredTiles[tile] = true
                self.score = self.score + (50 + (tile.variety - 1) * 25)
                self.timer = self.timer + 1
            end
        end
    end

    self.board:removeMatches()

    local tilesToFall = self.board:getFallingTiles()
    Timer.tween(0.25, tilesToFall):finish(function()
        local newMatches = self.board:calculateMatches()

        if newMatches then
            self:resolveMatches(newMatches)
        else
            self.isAnimating = false
            self.canInput = true

            if not self.board:hasPossibleMatches() then
                self.board:initializeTiles()
            end
        end
    end)
end

function PlayState:calculateMatches()
    self.highlightedTile = nil
    local matches = self.board:calculateMatches()

    if matches then
        self:resolveMatches(matches)
    else
        self.isAnimating = false
        self.canInput = true

        if not self.board:hasPossibleMatches() then
            self.board:initializeTiles()
        end
    end
end

function PlayState:render()
    self.board:render()

    if self.highlightedTile then
        love.graphics.setBlendMode('add')
        love.graphics.setColor(1, 1, 1, 96 / 255)
        love.graphics.rectangle(
            'fill',
            (self.highlightedTile.gridX - 1) * 32 + (VIRTUAL_WIDTH - 272),
            (self.highlightedTile.gridY - 1) * 32 + 16,
            32, 32, 4
        )
        love.graphics.setBlendMode('alpha')
    end

    if self.rectHighlighted then
        love.graphics.setColor(217 / 255, 87 / 255, 99 / 255, 1)
    else
        love.graphics.setColor(172 / 255, 50 / 255, 50 / 255, 1)
    end

    love.graphics.setLineWidth(4)
    love.graphics.rectangle(
        'line',
        self.boardHighlightX * 32 + (VIRTUAL_WIDTH - 272),
        self.boardHighlightY * 32 + 16,
        32, 32, 4
    )
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
