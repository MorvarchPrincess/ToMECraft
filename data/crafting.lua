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
--
-- Modified by Morvarch

require "engine.class"

function crafting_levelup(self, t, lvl, old_lvl, lvl_raw, old_lvl_raw, from_dialog)
		-- hack around 1.4 bug :<
		if self:isClassName("mod.dialogs.LevelupDialog") then self = self.actor end
	
		---------------------------------------------------------------------------
		-- Learn tinkers
		---------------------------------------------------------------------------
		game.party.tinkers_auto_learnt = game.party.tinkers_auto_learnt or {}
		game.party.tinkers_auto_learnt[t.id] = game.party.tinkers_auto_learnt[t.id] or 0
	
		local function learn_one(force_level)
			local tinker_id = nil
			local possibles = {}
			for tid, tinker in pairs(game.party.__tinkers_ings) do if tinker.random_schematic and tinker.talents and tinker.talents[t.id] and not game.party:knowCraft(tinker.id) then
				local max, maxid = -1, ""
				for ttid, lvl in pairs(tinker.talents) do if lvl > max then max = lvl; maxid = ttid end end
				local is_major = maxid == t.id
				if (not force_level or tinker.talents[t.id] == force_level) and is_major then
					possibles[#possibles+1] = tinker
				end
			end end
			if #possibles > 0 then
				local tinker = rng.table(possibles)
				game.party.tinkers_auto_learnt[t.id] = game.party.tinkers_auto_learnt[t.id] + 1
				game.log("#VIOLET#EUREKA!")
				if from_dialog then game.bignews:saySimple(120, "#VIOLET#EUREKA!#WHITE# Schematic learnt: #LIGHT_BLUE#%s", tinker.name) end
				game.party:learnCraft(tinker.id)
			end
		end
	
		for i = old_lvl_raw + 1, lvl_raw do
			learn_one(1)
		end
	end

function learnCraftingType(t, type, self)
	if self:getTalentLevelRaw(t) == 1 then
		self.can_tinker = self.can_tinker or {}
		self.can_tinker[type] = 1
	end
end

function unlearnCraftingType(t, type, self)
	if self:getTalentLevelRaw(t) == 0 then
		self.can_tinker[type] = nil
		if not next(self.can_tinker) then self.can_tinker = nil end
	end
end

function recipe_list_for_craft(self, t)
	local l = {}
	l[#l+1] = _t"This talent is required for the following crafting recipes (you still need to learn/find the schematics):"
	for tid, tinker in pairs(game.party.__tinkers_ings) do if tinker.random_schematic and not tinker.unique and tinker.talents and tinker.talents[t.id] then
		local known = ""
		if game.party:knowCraft(tinker.id) then known = _t" #LIGHT_BLUE#(known)#LAST#" end
		l[#l+1] = "#{italic}#* "..tinker.name..known.."#{normal}#"
	end end
	l[#l+1] = _t"#{italic}#* ...perhaps more to discover...#{normal}#"
	return table.concat(l, "\n")
end

local base_newRecipe = newRecipe

function newRecipe(t) t.base_category = _t"runescribing" return base_newRecipe(t) end
load("/data-morvarchstinkers/crafting/runescribing.lua")