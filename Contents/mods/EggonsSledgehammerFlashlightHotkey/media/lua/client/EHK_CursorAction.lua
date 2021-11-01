require "TimedActions/ISBaseTimedAction"

local CursorAction = ISBaseTimedAction:derive("CursorAction")

function CursorAction:isValid()
    return true
end

function CursorAction:waitToStart()
    return false
end

function CursorAction:perform()
    EHK.sledgeCursorInit(self.character, self.item)
    -- Remove Timed Action from stack
    ISBaseTimedAction.perform(self)
end

function CursorAction:new(character, item, maxTime)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    self.__call = self
    o.stopOnWalk = true
    o.stopOnRun = true
    o.character = character
    o.maxTime = maxTime or 0
    o.item = item
    return o
end

EHK.SledgeCursorAction = CursorAction
