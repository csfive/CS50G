local Class = require('class')

local BaseState = Class({})

function BaseState:init() end

function BaseState:enter() end

function BaseState:exit() end

function BaseState:update(dt) end

function BaseState:render() end

return BaseState
