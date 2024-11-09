local Object = require "engine.Object"
local Tinkers = require "data-morvarchstinkers.tinkers"

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

local craftType = "rune"

newTalent{
	name = "Etching",
	type = {"spell/runescribing",1},
	require = spells_req1,
	points = 5,
	mode = "passive",
	no_unlearn_last = true,
	no_npc_use = true,
	on_levelup_close = crafting_levelup,
	autolearn_talent = "T_CRAFT_ITEM",
    on_learn = function(self, t)
		learnCraftingType(t, craftType, self)
	end,
	on_unlearn = function(self, t)
		learnCraftingType(t, craftType, self)
	end,
	info = function(self, t)
		return ([[Allows you to create etched runes of level %d.
		You will learn a new schematic at level 1.
		Each other talent level, you have a 20%% chance to learn one more random schematic, if you have not gained it by level 5 you are guaranteed it (unless all are known).
		%s]])
		:tformat(math.floor(self:getTalentLevel(t)), recipe_list_for_craft(self, t))
	end,
}

newTalent{
	name = "Tattooing",
	type = {"spell/runescribing",2},
	require = spells_req2,
	points = 5,
	mode = "passive",
	no_unlearn_last = true,
	no_npc_use = true,
	on_levelup_close = crafting_levelup,
	autolearn_talent = "T_CRAFT_ITEM",
    on_learn = function(self, t)
		learnCraftingType(t, craftType, self)
	end,
	on_unlearn = function(self, t)
		learnCraftingType(t, craftType, self)
	end,
	info = function(self, t)
		return ([[Allows you to create tattooed runes of level %d.
		You will learn a new schematic at level 1.
		Each other talent level, you have a 20%% chance to learn one more random schematic, if you have not gained it by level 5 you are guaranteed it (unless all are known).
		%s]])
		:tformat(math.floor(self:getTalentLevel(t)), recipe_list_for_craft(self, t))
	end,
}

newTalent{
	name = "Compounding",
	type = {"spell/runescribing",3},
	require = spells_req3,
	points = 5,
	mode = "passive",
	no_unlearn_last = true,
	no_npc_use = true,
	on_levelup_close = crafting_levelup,
	autolearn_talent = "T_CRAFT_ITEM",
    on_learn = function(self, t)
		learnCraftingType(t, craftType, self)
	end,
	on_unlearn = function(self, t)
		learnCraftingType(t, craftType, self)
	end,
	info = function(self, t)
		return ([[Allows you to create compounding runes of level %d.
		You will learn a new schematic at level 1.
		Each other talent level, you have a 20%% chance to learn one more random schematic, if you have not gained it by level 5 you are guaranteed it (unless all are known).
		%s]])
		:tformat(math.floor(self:getTalentLevel(t)), recipe_list_for_craft(self, t))
	end,
}

newTalent{
	name = "Resonance",
	type = {"spell/runescribing",4},
	require = spells_req4,
	points = 5,
	mode = "passive",
	getPower = function(self, t)
		return self:combatTalentScale(t, 15, 60)
	end,
	passives = function(self, t, p)
		self:talentTemporaryValue(p, "combat_steampower", t.getPower(self, t))
	end,
	info = function(self, t)
		return ([[Increases the efficiency of all steamtech you operate, granting %d steampower.]])
		:tformat(t.getPower(self, t))
	end,
}

newTalent{
	name = "Martial Current",
	type = {"spell/runescribing",4},
	points = 1,
	mode = "sustained",
	cooldown = 2,
	tactical = { BUFF = 2, DISABLE = 1, },
	getPower = function(self, t)
		return self:combatTalentScale(t, 10, 10, t.getSpellpower(self, t))
	end,
	passives = function(self, t, p)
		self:talentTemporaryValue(p, "combat_atk", t.getPower(self, t))
		self:talentTemporaryValue(p, "combat_def", t.getPower(self, t))
	end,
	info = function(self, t)
		return ([[Passively increases attack and defence based on spellpower.]])
		:tformat(t.getPower(self, t))
	end,
}
