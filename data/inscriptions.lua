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
-- darkgod@te4.org

local Talents = require "engine.interface.ActorTalents"
local Map = require "engine.Map"

local newInscription = function(t)
	-- Warning, up that if more than 5 inscriptions are ever allowed
	for i = 1, 6 do
		local tt = table.clone(t)
		tt.short_name = tt.name:upper():gsub("[ ]", "_").."_"..i
		tt.display_name = function(self, t)
			local data = self:getInscriptionData(t.short_name)
			if data.item_name then
				local n = tstring{t.name, " ["}
				n:merge(data.item_name)
				n:add("]")
				return n
			else
				return t.name
			end
		end
		if tt.type[1] == "inscriptions/infusions" then tt.auto_use_check = function(self, t) return not self:hasEffect(self.EFF_INFUSION_COOLDOWN) end
		elseif tt.type[1] == "inscriptions/runes" then tt.auto_use_check = function(self, t) return not self:hasEffect(self.EFF_RUNE_COOLDOWN) end
		elseif tt.type[1] == "inscriptions/taints" then tt.auto_use_check = function(self, t) return not self:hasEffect(self.EFF_TAINT_COOLDOWN) end
		end
		tt.auto_use_warning = "- will only auto use when no saturation effect exists"
		tt.cooldown = function(self, t)
			local data = self:getInscriptionData(t.short_name)
			return data.cooldown
		end
		tt.old_info = tt.info
		tt.info = function(self, t)
			local ret = t.old_info(self, t)
			local data = self:getInscriptionData(t.short_name)
			if data.use_stat and data.use_stat_mod then
				ret = ret..("\nIts effects scale with your %s stat."):format(self.stats_def[data.use_stat].name)
			end
			return ret
		end
		if not tt.image then
			tt.image = "talents/"..(t.short_name or t.name):lower():gsub("[^a-z0-9_]", "_")..".png"
		end
		tt.no_unlearn_last = true
		tt.is_inscription = true
		newTalent(tt)
	end
end

newInscription{
	name = "Rune: Amplifying Shield",
	type = {"inscriptions/runes", 1},
	points = 1,
	is_spell = true,
	allow_autocast = true,
	no_energy = true,
	tactical = { DEFEND = 2 },
	getPower = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		if data.power and data.inc_stat then 
			return data.power + data.inc_stat
		else
			return 100+5*self:getMag()
		end
	end,
	getDuration = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		return data.dur or 5
	end,
	on_pre_use = function(self, t)
		return not self:hasEffect(self.EFF_DAMAGE_SHIELD)
	end,
	action = function(self, t)
		local runepower = t.getPower(self, t)
		local regenpower = runepower/5
		local dur = t.getDuration(self, t)
		self:setEffect(self.EFF_DAMAGE_SHIELD, data.dur, {power=runepower})
		self:setEffect(self.HP_SHIELD_REGEN, data.dur, {regenpower})
		return true
	end,
	info = function(self, t)
		local power = t.getPower(self, t)
		local dur = t.getDuration(self, t)
		return ([[Activate the rune to create a protective shield absorbing %d damage for %d turns that regenerates by %d every turn.]]):tformat(self:getShieldAmount(power), self:getShieldDuration(dur), power/5)
	end,
	short_info = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		local power = t.getPower(self, t)
		local dur = t.getDuration(self, t)
		return ([[absorb %d; dur %d; regen %d; cd %d]]):tformat(self:getShieldAmount(power), self:getShieldDuration(dur), power/5, data.cd)
	end,
}

newInscription{
	name = "Rune: Emergency Shield",
	type = {"inscriptions/runes", 1},
	points = 1,
	is_spell = true,
	allow_autocast = true,
	no_energy = true,
	tactical = { DEFEND = 2 },
	getPower = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		if data.power and data.inc_stat then 
			return data.power + data.inc_stat
		else
			return 300+10*self:getMag()
		end
	end,
	getDuration = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		return (data.dur*2) or 10
	end,
	on_pre_use = function(self, t)
		return not self:hasEffect(self.EFF_DAMAGE_SHIELD)
	end,
	action = function(self, t)
		local runepower = t.getPower(self, t)
		local regenpower = runepower/5
		local dur = t.getDuration(self, t)
		self:setEffect(self.EFF_DAMAGE_SHIELD, data.dur, {power=runepower})
		self:setEffect(self.HP_SHIELD_FEEDBACK, data.dur, 75)
		return true
	end,
	info = function(self, t)
		local power = t.getPower(self, t)
		local dur = t.getDuration(self, t)
		return ([[Activate the rune to create a powerful protective shield absorbing %d damage for %d turns. However this will reduce all damage you deal by 75%]]):tformat(self:getShieldAmount(power), self:getShieldDuration(dur))
	end,
	short_info = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		local power = t.getPower(self, t)
		local dur = t.getDuration(self, t)
		return ([[absorb %d; dur %d; cd %d]]):tformat(self:getShieldAmount(power), self:getShieldDuration(dur), data.cd)
	end,
}

newInscription{
	name = "Rune: Martial Surge", --short_name = "HP_RUNE:_ENCHANTMENT",
	type = {"inscriptions/runes", 1},
	points = 1,
	no_energy = true,
	tactical = { BUFF = 2 },
	on_learn = function(self, t)
		if not self:knowTalent(self.T_MARTIAL_CURRENT) then
			self:learnTalent(self.T_MARTIAL_CURRENT, true)
		end
	end,
	on_unlearn = function(self, t)
		if self:knowTalent(self.T_MARTIAL_CURRENT) then
			self:unlearnTalent(self.T_MARTIAL_CURRENT)
		end
	end,
	action = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		self:setEffect(self.EFF_HP_MARTIAL_SURGE, data.dur, {power=data.power + data.inc_stat})
		return true
	end,
	info = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		return ([[Activate the rune to boost your combat prowess for %d turns based on your magic stat.
		This enchantment increases your accuracy and armour by %d and adds %d arcane damage to all your hits.]])
		:format(data.dur, data.power + data.inc_stat, Talents.damDesc(self, DamageType.ARCANE, data.power + data.inc_stat))
	end,
	short_info = function(self, t)
		local data = self:getInscriptionData(t.short_name)
		return ([[+%d for %d turns]]):format(data.power + data.inc_stat, data.dur)
	end,
	info_cmp = function(self, t1, d1, t2, d2)
		if t2 == nil and d2 == nil then
		return ([[Activate the rune to enchant your weapons and armour for %d turns.
		This enchantment increases your accuracy and armour by %d and adds %d arcane damage to all your hits.]])
		:format(d1.dur, d1.power + d1.inc_stat, Talents.damDesc(self, DamageType.ARCANE, d1.power + d1.inc_stat))
		end
		return ([[Activate the rune to enchant your weapons and armour for %d->%d turns.
		This enchantment increases your accuracy and armour by %d->%d and adds %d->%d arcane damage to all your hits.]])
		:format(d2.dur, d1.dur, d2.power + d2.inc_stat, d1.power + d1.inc_stat, Talents.damDesc(self, DamageType.ARCANE, d2.power + d2.inc_stat), Talents.damDesc(self, DamageType.ARCANE, d1.power + d1.inc_stat))
	end,
}