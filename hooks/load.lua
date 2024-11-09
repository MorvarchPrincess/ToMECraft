local class = require"engine.class"
local ActorTalents = require "engine.interface.ActorTalents"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local Birther = require "engine.Birther"
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local chat = require "engine.Chat"
local PartyLore = require "mod.class.interface.PartyLore"

class:bindHook("ToME:load", function(self, data)
    local PartyCrafting = require "mod.class.interface.PartyCrafting"

    ActorTalents:loadDefinition("/data-morvarchstinkers/talents/talents.lua")

    PartyCrafting:loadDefinition("/data-morvarchstinkers/crafting.lua")

	ActorTalents:loadDefinition("/data-morvarchstinkers/talents/techniques/techniques.lua")
    ActorTalents:loadDefinition("/data-morvarchstinkers/talents/spells/spells.lua")
end)

class:bindHook("Entity:loadList", function(self, data)
    if data.file == "/data/general/objects/objects.lua" then
        self:loadList("/data-morvarchstinkers/general/objects/crafting/crafting.lua", data.no_default, data.res, data.mod, data.loaded)
    end
end)