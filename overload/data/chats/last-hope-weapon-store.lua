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

local Stats = require("engine.interface.ActorStats")
local Talents = require "engine.interface.ActorTalents"

local reward_types = {
	stat = {
			[Stats.STAT_STR] = 5,
			[Stats.STAT_DEX] = 5,
			[Stats.STAT_MAG] = 5,
			[Stats.STAT_WIL] = 5,
			[Stats.STAT_CUN] = 5,
			[Stats.STAT_CON] = 5,
	},
}

local increase = reward_types

newChat{ id="welcome",
	text = _t[[Welcome @playername@ to my shop.]],
	answers = {
		{_t"Let me see your wares.", action=function(npc, player)
			npc.store:loadup(game.level, game.zone)
			npc.store:interact(player)
		end},
		{_t"I am looking for training.", jump="training"},
		{_t("Sorry, I have to go!", "chat_last-hope-weapon-store")},
	}
}

newChat{ id="train",
	text = [[What would you like to know?]],
	answers = {
		{"Teach me magic forging!", jump="forging"},
		{"I think I'll be on my way now."},
	}
}

newChat{ id="forging",
	text = [[Sure, I'll even do so for free!]],
	answers = {
		{"Nice!", action=function(npc, player) 
		    game.logPlayer(player, "#LIGHT_GREEN#*Free forging training!")
			player.unused_generics = player.unused_generics + 2
			player:learnTalentType("spell/runescribing", true)
		end},
		{"#LIGHT_BLUE#I'm interested insomething else...", jump="train"},
		{"#DARK_GREY#Nevermind."},
	}
}

newChat{ id="training",
	text = _t[[I can indeed offer some martial training (talent category Technique/Combat-training) for a fee of 50 gold pieces; or the basic usage of bows and slings (Shoot talent) for 8 gold pieces.]],
	answers = {
		{_t"Please train me in generic weapons and armour usage.", action=function(npc, player)
			game.logPlayer(player, "The smith spends some time with you, teaching you the basics of armour and weapon usage.")
			player:incMoney(-50)
			player:learnTalentType("technique/combat-training", true)
			player.changed = true
		end, cond=function(npc, player)
			if player.money < 50 then return end
			if player:knowTalentType("technique/combat-training") then return end
			return true
		end},
		{_t"Please train me in the basic usage of bows and slings.", action=function(npc, player)
			game.logPlayer(player, "The smith spends some time with you, teaching you the basics of bows and slings.")
			player:incMoney(-8)
			player:learnTalent(player.T_SHOOT, true, nil, {no_unlearn=true})
			player.changed = true
		end, cond=function(npc, player)
			if player.money < 8 then return end
			if player:knowTalent(player.T_SHOOT) then return end
			return true
		end},
		{"Can you train me in skills/sats?", jump="train"},
		{_t"No thanks."},
	}
}

return "welcome"
