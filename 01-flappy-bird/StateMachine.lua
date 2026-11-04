local Class = require('class')

local StateMachine = Class({})

function StateMachine:init(states)
    self.empty = {
        enter = function() end,
        exit = function() end,
        update = function() end,
        render = function() end,
    }
    self.states = states or {}
    self.current = self.empty
    self.currentName = nil
end

function StateMachine:change(stateName, enterParams)
    assert(self.states[stateName], 'unknown state: ' .. tostring(stateName))
    self.current:exit()
    self.current = self.states[stateName]()
    self.currentName = stateName
    self.current:enter(enterParams)
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:render()
    self.current:render()
end

return StateMachine
