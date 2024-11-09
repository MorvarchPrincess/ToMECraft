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
local DamageType = require "engine.DamageType"


newRecipe{ id = "LIGHTNING_CASTER",
	name = _t"Lightning Caster", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"Channeling the elements through runes is one of the most ancient uses of runescribing on Eyal. With this rune scribed on a set of gloves or gauntlets, the wearer can project a beam of electricity to shock their foes.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_ETCHING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "SCRYING_GOGGLES",
	name = _t"Scrying Goggles", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"Setting a group of runic lenses in a frame build to be added to a helmet allows creating these scrying goggles, which allow the user to project their site temporarily to a remote location. As a side effect, the goggles also help you see really well.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_ETCHING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "THAUMATURGICAL_REINFORCEMENT",
	name = _t"Thaumaturgical Reinforcement", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"Plates armor with runes of resistance, improving lasting power against various magical damage types.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_ETCHING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "EMERGENCY_SOLE",
	name = _t"Emergency Sole", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"A rune of limited teleporation built into the sole of the boot, activated with a word and a stomp to hopefully whisk the user away to safety.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_ETCHING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "RUNIC_GENERATION_LOOP",
	name = _t"Runic Generation Loop", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"By lining a belt with multiple basic runes of manasurge, the wearer can benefit from a limited amount of mana regen, though without the instant burst of mana manasurge runes can usually provide.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_ETCHING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "GLYPHED_EDGE",
	name = _t"Glyped Edge", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"Covering the edge of your weapon with glyphs allows for inflicting arcane energies upon your enemies with every blow.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_ETCHING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "CHARGED_WEAVE",
	name = _t"Charged Weave", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"Weaving conductive symbols into your robe allows it to build charge, then release it in a burst of electrifying power. As a side effect, this makes you more resistant to incoming lightning damage in return.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_ETCHING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "RUNIC_LIFEBINDING",
	name = _t"Runic Lifebinding", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"By linking the caster's mana and vitality, the caster can amplify the rate at which they regenerate health proportional to their mana regeneration.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_TATTOOING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "AMPLIFYING_SHIELD_RUNE",
	name = _t"Amplifying Shield Rune", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"A shielding rune that slowly grows in power if it isn't broken.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_TATTOOING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "MARTIAL_SURGE_RUNE",
	name = _t"Martial Surge Rune", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"A rune that boosts martial power passively and can be activated for a surge of increased effectiveness.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_TATTOOING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "EMERGENCY_BARRIER_RUNE",
	name = _t"Martial Surge Rune", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"A rune that provides a huge shield for a moderate length of time, but causes the caster's damage to be significantly reduced.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_TATTOOING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}

newRecipe { id = "RUNEHAMMER",
	name = _t"Runehammer", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"A giant hammer forged of runic metal, a runehammer can channel the casters will in martial might and is especially effective when weaving strike and spell.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_COMPOUNDING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
	fake_slot = "WEAPON",
	special = {
		{desc=_t"a two handed sword/axe/mace (not unique, without a special damage type)", cond=function(tdef, party, actor)
			local found = false
			actor:inventoryApply(actor:getInven(actor.INVEN_INVEN), function(inven, item, o) if tdef.object_filter(o) then found = true end end)
			return found
		end},
	},
	object_filter = function(o)
		if o.type == "weapon" and (o.subtype == "battleaxe" or o.subtype == "greatmaul" or o.subtype == "greatsword") and
		   not o.quest and not o.special and (not o.unique or o.randart) and o.combat and (not o.combat.damtype or o.combat.damtype == DamageType.PHYSICAL) then
			return true
		end
	end,
	create = function(tdef, party, actor, ml, silent, onend)
		actor:showEquipInven(_t"Convert which weapon?", tdef.object_filter, function(o, inven, item)
			if not o then return end
			local saw = game.zone:makeEntity(game.level, "object", {define_as="RUNEHAMMER_BASE"..ml, ignore_material_restriction=true, base_list="mod.class.Object:/data-orcs/general/objects/runehammer.lua", ego_chance=-1000}, nil, true)
			if not saw then return end
			local basename = saw.name

			actor:removeObject(inven, item, true)

			if o.ego_list then game.zone:setEntityEgoList(saw, o.ego_list) end
			saw:resolve()
			saw:resolve(nil, true)
			saw:identify(true)

			if o.randart or o.rare then
				saw.randart = o.randart
				saw.rare = o.rare
				if o.namescheme and o.unided_namescheme then
					saw.unided_name = o.unided_namescheme:tformat(saw.unided_name or basename)
					saw.name = o.namescheme:tformat(_t(basename))
					if o.randart then saw.unique = o.namescheme:format(basename) end
				end
				saw.no_unique_lore = true
			end

			actor:addObject(inven, saw)
			game.zone:addEntity(game.level, o, "object")
			actor:sortInven()
			game.log("Converted %s into %s", o:getName{do_color=true}, saw:getName{do_color=true})

			onend(true)
			return true
		end)
	end,
}

newRecipe { id = "EMERGENCY_BARRIER_RUNE",
	name = _t"Martial Surge Rune", icon = "shockbolt/object/tinkers_winterchill_edge_t5.png",
	desc = _t"A rune that provides a huge shield for a moderate length of time, but causes the caster's damage to be significantly reduced.",
	base_ml = 1, max_ml = 5,
	random_schematic = {level=20, rarity=50, cost=150},
	talents = {
		T_TATTOOING = 1,
	},
	ingredients = {
		LUMP_ORE = 3,
	},
}