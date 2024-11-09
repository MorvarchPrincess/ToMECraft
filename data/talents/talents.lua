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

local oldNewTalent = Talents.newTalent
Talents.newTalent = function(self, t)
	local tt = engine.interface.ActorTalents.talents_types_def[t.type[1]]
	assert(tt, "No talent category "..tostring(t.type[1]).." for talent "..t.name)

	if tt.is_steam then t.is_steam = true end

	return oldNewTalent(self, t)
end

newTalent{
	name = "Craft Item",
	type = {"technique/other",1},
	points = 1,
	no_npc_use = true,
	on_learn = function(self, t)
		if self:getTalentLevelRaw(t) == 1 then
			self.can_tinker = self.can_tinker or {}
			self.can_tinker.crafting = 1
		end
	end,
	on_unlearn = function(self, t)
		if self:getTalentLevelRaw(t) == 0 then
			self.can_tinker.crafting = nil
			if not next(self.can_tinker) then self.can_tinker = nil end
		end
	end,
	action = function(self, t)
		return self:talentDialog(game.party:createForgingUI())
	end,
	info = function(self, t)
		return (_t[[Allows you to create crafted items.]])
	end,
}
