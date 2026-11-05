local Class = require('class')
local config = require('config')
local Pipe = require('Pipe')

local PipePair = Class({})

function PipePair:init(y, gapHeight)
    self.x = config.VIRTUAL_WIDTH + 32
    self.y = y
    self.gapHeight = gapHeight
    self.scored = false
    self.remove = false

    self.upper = Pipe(self.x, y, 'top')
    self.lower = Pipe(self.x, y + config.PIPE_HEIGHT + gapHeight, 'bottom')
end

function PipePair:update(dt)
    if self.x > -config.PIPE_WIDTH then
        self.x = self.x - config.PIPE_SPEED * dt
        self.upper.x = self.x
        self.lower.x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    self.upper:render()
    self.lower:render()
end

return PipePair
