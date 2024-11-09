-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009, 2010, 2011, 2012 Nicolas Casalini
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org6

local Stats = require "engine.interface.ActorStats"
local Particles = require "engine.Particles"
local Entity = require "engine.Entity"
local Chat = require "engine.Chat"
local Map = require "engine.Map"
local Level = require "engine.Level"

TemporaryEffects.tempeffect_def.EFF_DAMAGE_SHIELD.on_timeout = function(self, eff)
	if self:hasEffect(self.EFF_SHIELD_REGEN) then
		for eff_id, p in pairs(target.tmp) do
			local e = target.tempeffect_def[eff_id]
			if e.name == "HP_SHIELD_REGEN" then
				eff.power = eff.power + e.power
			end
		end
	end
end

newEffect{
	name = "HP_SHIELD_REGEN", image = "talents/elemental_surge.png",
	desc = "Regeneration Sheild",
	long_desc = function(self, eff) return ("Your shield is slowly gaining power.") end,
	type = "magical",
	subtype = { arcane=true },
	status = "beneficial",
	parameters = { power=10 },
}

newEffect{
	name = "HP_SHIELD_FEEDBACK", image = "talents/elemental_surge.png",
	desc = "Emergency shield feedback",
	long_desc = function(self, eff) return ("Your emergency measures are interferring with your damage.") end,
	type = "magical",
	subtype = { arcane=true },
	status = "beneficial",
	parameters = { power=75 },
	activate = function(self, eff)
		eff.pid = self:addTemporaryValue("inc_damage", {all=(eff.power * -1)})
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("inc_damage", eff.pid)
	end,
}

newEffect{
	name = "HP_MARTIAL_CURRENT", image = "talents/elemental_surge.png",
	desc = "Martial Current",
	long_desc = function(self, eff) return ("Passively increased accuracy and defence.") end,
	type = "magical",
	subtype = { arcane=true },
	status = "beneficial",
	parameters = { power=10 },
	activate = function(self, eff)
		eff.defid = self:addTemporaryValue("combat_def", pow)
		eff.attid = self:addTemporaryValue("combat_atk", pow)
	end,
	deactivate = function(self, eff)
		self:removeTemporaryValue("combat_def", eff.defid)
		self:removeTemporaryValue("combat_def", eff.attid)
	end,
}

newEffect{
	name = "HP_MARTIAL_SURGE", image = "talents/elemental_surge.png",
	desc = "Martial Surge",
	long_desc = function(self, eff) return ("A surge of increased accuracy, defence and arcane damage on hit.") end,
	type = "magical",
	subtype = { arcane=true },
	status = "beneficial",
	parameters = { power=10 },
	activate = function(self, eff)
		self:effectTemporaryValue(eff, "combat_atk", eff.power)
		self:effectTemporaryValue(eff, "combat_def", eff.power)
	end,
	callbackOnMeleeAttack = function(self, eff, target, hitted, crit, weapon, damtype, mult, dam)
		local damage = eff.power
		damage = damage * mult
		if crit then
			damage = self:physicalCrit(dam, weapon, target, 0, 0, 1000)
		end
		DamageType:get(DamageType.ARCANE).projector(self, target.x, target.y, DamageType.ARCANE, damage)
	end,
	callbackOnArcheryAttack = function(self, eff, target, hitted, crit, weapon, ammo, damtype, mult, dam)
		local damage = eff.power
		damage = damage * mult
		if crit then
			damage = self:physicalCrit(damage, weapon, target, 0, 0, 1000)
		end
		DamageType:get(DamageType.ARCANE).projector(self, target.x, target.y, DamageType.ARCANE, damage)
	end,
}

newEffect{
	name = "RUNEMARKED", image = "talents/taint__telepathy.png",
	desc = _t"Rune-marked",
	long_desc = function(self, eff) return ("Target is marked by runic magic, causing the next attack to deal additional damage and consume the mark."):tformat(eff.save, eff.power) end,
	type = "magical",
	subtype = { arcane=true },
	status = "beneficial",
	parameters = { power=10, save=10 },
}