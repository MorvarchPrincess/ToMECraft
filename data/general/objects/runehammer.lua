-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2019 Nicolas Casalini
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
-- darkgod@te4.org

local Talents = require "engine.interface.ActorTalents"

newEntity{
	define_as = "BASE_RUNEHAMMER",
	slot = "MAINHAND",
	slot_forbid = "OFFHAND",
	type = "weapon", subtype="runehammer",
	power_source = {arcane=true},
	add_name = " (#COMBAT#)",
	display = "/", color=colors.SLATE, image = resolvers.image_material("steamsaw", "metal"),
	moddable_tile = resolvers.orcs_moddable_tile("steamsaw"),
	encumber = 3,
	rarity = 3,
	metallic = true,
	fixed_randart_damage_type = true,
	combat = { talented = "mace", accuracy_effect="staff", damtype=DamageType.ARCANE, damrange = 1.5, physspeed = 1, sound = {"actions/melee", pitch=0.6, vol=1.2}, sound_miss = {"actions/melee", pitch=0.6, vol=1.2} },
	desc = _t[[Runehammers are ]],
	callbackOnTalentPost = function(self, t, ab)
		if ab.is_spell and ab.mode == "activated" and !ab.is_melee then
			self.setEffect(self.EFF_RUNEMARKED, 1)
		end
	end,
	egos = "/data/general/objects/egos/weapon.lua", egos_chance = { prefix=resolvers.mbonus(40, 5), suffix=resolvers.mbonus(40, 5) },
}

class:bindHook(
	"Combat:attackTargetWith:attackerBonuses",
	function(self, hd)
		-- check for buff
		local rune = self:hasEffect(self.EFF_RUNEMARKED)
		if not rune then return hd end

		-- check unarmed
		if hd.weapon == self.combat then return hd end

		-- power up
		hd.mult = hd.mult * (1.5)
		game:onTickEnd(function()
			if self:hasEffect(self.EFF_RUNEMARKED) then
					self:removeEffect(self.EFF_RUNEMARKED)
			end
		end)
		return hd
	end)

newEntity{ base = "BASE_RUNEHAMMER", define_as = "RUNEHAMMER_BASE1",
	name = "iron runehammer", short_name = "iron",
	level_range = {1, 10},
	require = { stat = { mag=11 }, },
	cost = 5,
	material_level = 1,
	combat = {
		dam = resolvers.rngavg(15,21),
		apr = 1,
		physcrit = 0.5,
		dammod = {mag=0.8,wil=0.4},
	},
}

newEntity{ base = "BASE_RUNEHAMMER", define_as = "RUNEHAMMER_BASE2",
	name = "steel steamsaw", short_name = "steel",
	level_range = {10, 20},
	require = { stat = { mag=16 }, },
	cost = 10,
	material_level = 2,
	combat = {
		dam = resolvers.rngavg(24,32),
		apr = 2,
		physcrit = 1,
		dammod = {mag=0.8,wil=0.4},
	},
}

newEntity{ base = "BASE_RUNEHAMMER", define_as = "RUNEHAMMER_BASE3",
	name = "dwarven-steel steamsaw", short_name = "d.steel",
	level_range = {20, 30},
	require = { stat = { mag=24 }, },
	cost = 15,
	material_level = 3,
	combat = {
		dam = resolvers.rngavg(38,45),
		apr = 2,
		physcrit = 1.5,
		dammod = {mag=0.8,wil=0.4},
	},
}

newEntity{ base = "BASE_RUNEHAMMER", define_as = "RUNEHAMMER_BASE4",
	name = "stralite steamsaw", short_name = "stralite",
	level_range = {30, 40},
	require = { stat = { mag=35 }, },
	cost = 25,
	material_level = 4,
	combat = {
		dam = resolvers.rngavg(50,59),
		apr = 3,
		physcrit = 2.5,
		dammod = {mag=0.8,wil=0.4},
	},
}

newEntity{ base = "BASE_RUNEHAMMER", define_as = "RUNEHAMMER_BASE5",
	name = "voratun steamsaw", short_name = "voratun",
	level_range = {40, 50},
	require = { stat = { mag=48 }, },
	cost = 35,
	material_level = 5,
	combat = {
		dam = resolvers.rngavg(62, 72),
		apr = 4,
		physcrit = 3,
		dammod = {mag=0.8,wil=0.4},
	},
}
