-- ToME - Tales of Maj'Eyal:
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
local DamageType = require "engine.DamageType"

newEntity{
	define_as = "BASE_CRAFT",
	power_source = {technique=true},
	type = "tinker", subtype="other",
	display = "*", color=colors.SLATE,
	encumber = 0,
	material_level = 1,
	rarity = false,
	metallic = false,
	desc = _t[[A crafted object that can be equipped!]],
	cost = 1,
}

load("/data-morvarchstinkers/general/objects/crafting/runescribing.lua")