Board = Class {}

function Board:init(x, y, level)
    self.x = x
    self.y = y
    self.level = level or 1
    self.tiles = {}

    self:initializeTiles()
end

function Board:render()
    for y = 1, #self.tiles do
        for x = 1, #self.tiles[1] do
            self.tiles[y][x]:render(self.x, self.y)
        end
    end
end

function Board:initializeTiles()
    local validBoard = false

    while not validBoard do
        self.tiles = {}

        for tileY = 1, 8 do
            table.insert(self.tiles, {})
            for tileX = 1, 8 do
                table.insert(self.tiles[tileY], self:createTile(tileX, tileY))
            end
        end

        validBoard = not self:calculateMatches() and self:hasPossibleMatches()
    end

    self.matches = nil
end

function Board:createTile(x, y)
    local varietyLimit = math.min(6, self.level)
    local shiny = math.random(20) == 1

    return Tile(x, y, math.random(8), math.random(varietyLimit), shiny)
end

function Board:addMatch(matches, tiles, direction)
    local match = {}
    local seen = {}
    local shiny = false

    local function addTile(tile)
        if tile and not seen[tile] then
            table.insert(match, tile)
            seen[tile] = true
        end
    end

    for k, tile in pairs(tiles) do
        addTile(tile)
        shiny = shiny or tile.shiny
    end

    if shiny then
        if direction == 'horizontal' then
            local row = tiles[1].gridY

            for x = 1, 8 do
                addTile(self.tiles[row][x])
            end
        else
            local column = tiles[1].gridX

            for y = 1, 8 do
                addTile(self.tiles[y][column])
            end
        end
    end

    table.insert(matches, match)
end

function Board:calculateMatches()
    local matches = {}

    for y = 1, 8 do
        local colorToMatch = self.tiles[y][1].color
        local match = { self.tiles[y][1] }

        for x = 2, 8 do
            if self.tiles[y][x].color == colorToMatch then
                table.insert(match, self.tiles[y][x])
            else
                if #match >= 3 then
                    self:addMatch(matches, match, 'horizontal')
                end

                colorToMatch = self.tiles[y][x].color
                match = { self.tiles[y][x] }
            end
        end

        if #match >= 3 then
            self:addMatch(matches, match, 'horizontal')
        end
    end

    for x = 1, 8 do
        local colorToMatch = self.tiles[1][x].color
        local match = { self.tiles[1][x] }

        for y = 2, 8 do
            if self.tiles[y][x].color == colorToMatch then
                table.insert(match, self.tiles[y][x])
            else
                if #match >= 3 then
                    self:addMatch(matches, match, 'vertical')
                end

                colorToMatch = self.tiles[y][x].color
                match = { self.tiles[y][x] }
            end
        end

        if #match >= 3 then
            self:addMatch(matches, match, 'vertical')
        end
    end

    self.matches = matches
    return #self.matches > 0 and self.matches or false
end

function Board:removeMatches()
    for k, match in pairs(self.matches) do
        for k, tile in pairs(match) do
            self.tiles[tile.gridY][tile.gridX] = nil
        end
    end
    self.matches = nil
end

function Board:swapTiles(tile1, tile2)
    local tile1X = tile1.gridX
    local tile1Y = tile1.gridY
    local tile2X = tile2.gridX
    local tile2Y = tile2.gridY

    self.tiles[tile1Y][tile1X] = tile2
    self.tiles[tile2Y][tile2X] = tile1

    tile1.gridX = tile2X
    tile1.gridY = tile2Y
    tile2.gridX = tile1X
    tile2.gridY = tile1Y
end

function Board:hasPossibleMatches()
    for y = 1, 8 do
        for x = 1, 8 do
            local tile = self.tiles[y][x]

            if x < 8 then
                local rightTile = self.tiles[y][x + 1]

                self:swapTiles(tile, rightTile)
                if self:calculateMatches() then
                    self:swapTiles(tile, rightTile)
                    self.matches = nil
                    return true
                end
                self:swapTiles(tile, rightTile)
            end

            if y < 8 then
                local bottomTile = self.tiles[y + 1][x]

                self:swapTiles(tile, bottomTile)
                if self:calculateMatches() then
                    self:swapTiles(tile, bottomTile)
                    self.matches = nil
                    return true
                end
                self:swapTiles(tile, bottomTile)
            end
        end
    end

    self.matches = nil
    return false
end

function Board:getFallingTiles()
    local tweens = {}

    for x = 1, 8 do
        local space = false
        local spaceY = 0
        local y = 8

        while y >= 1 do
            local tile = self.tiles[y][x]
            if space then
                if tile then
                    self.tiles[spaceY][x] = tile
                    tile.gridY = spaceY
                    self.tiles[y][x] = nil
                    tweens[tile] = {
                        y = (tile.gridY - 1) * 32
                    }
                    space = false
                    y = spaceY
                    spaceY = 0
                end
            elseif tile == nil then
                space = true
                if spaceY == 0 then
                    spaceY = y
                end
            end

            y = y - 1
        end
    end

    for x = 1, 8 do
        for y = 8, 1, -1 do
            local tile = self.tiles[y][x]
            if not tile then
                local tile = self:createTile(x, y)
                tile.y = -32
                self.tiles[y][x] = tile
                tweens[tile] = {
                    y = (tile.gridY - 1) * 32
                }
            end
        end
    end

    return tweens
end
