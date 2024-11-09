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

function recipe_list_for_craft(self, t)
	local l = {}
	l[#l+1] = _t"This talent is required for the following tinkers (you still need to learn/find the schematics):"
	for tid, tinker in pairs(game.party.__crafting_ings) do if tinker.random_schematic and not tinker.unique and tinker.talents and tinker.talents[t.id] then
		local known = ""
		if game.party:knowCraft(tinker.id) then known = _t" #LIGHT_BLUE#(known)#LAST#" end
		l[#l+1] = "#{italic}#* "..tinker.name..known.."#{normal}#"
	end end
	l[#l+1] = _t"#{italic}#* ...perhaps more to discover...#{normal}#"
	return table.concat(l, "\n")
end

newTalent{
	name = "Cutting",
	type = {"technique/gemcraft",1},
	require = spells_req1,
	points = 5,
	mode = "passive",
	no_unlearn_last = true,
	no_npc_use = true,
	on_levelup_close = crafting_levelup,
	autolearn_talent = "T_FORGING",
	info = function(self, t)
		return ([[Allows you to create therapeutic tinkers of level %d.
		You will learn a new schematic at level 1.
		Each other talent level, you have a 20%% chance to learn one more random schematic, if you have not gained it by level 5 you are guaranteed it (unless all are known).
		%s]])
		:tformat(math.floor(self:getTalentLevel(t)), recipe_list_for_craft(self, t))
	end,
}

newTalent{
	name = "Faceting",
	type = {"technique/gemcraft",2},
	require = spells_req2,
	points = 5,
	mode = "passive",
	no_unlearn_last = true,
	no_npc_use = true,
	on_levelup_close = crafting_levelup,
	autolearn_talent = "T_FORGING",
	info = function(self, t)
		return ([[Allows you to create chemical tinkers of level %d.
		You will learn a new schematic at level 1.
		Each other talent level, you have a 20%% chance to learn one more random schematic, if you have not gained it by level 5 you are guaranteed it (unless all are known).
		%s]])
		:tformat(math.floor(self:getTalentLevel(t)), recipe_list_for_craft(self, t))
	end,
}

newTalent{
	name = "Inbuement",
	type = {"technique/gemcraft",3},
	require = spells_req3,
	points = 5,
	mode = "passive",
	no_unlearn_last = true,
	no_npc_use = true,
	on_levelup_close = crafting_levelup,
	autolearn_talent = "T_FORGING",
	info = function(self, t)
		return ([[Allows you to create explosive tinkers of level %d.
		You will learn a new schematic at level 1.
		Each other talent level, you have a 20%% chance to learn one more random schematic, if you have not gained it by level 5 you are guaranteed it (unless all are known).
		%s]])
		:tformat(math.floor(self:getTalentLevel(t)), recipe_list_for_craft(self, t))
	end,
}

newTalent{
	name = "test Steam Power",
	type = {"technique/gemcraft",4},
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
