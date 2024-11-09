if not Talents.talents_types_def["spell/runescribing"] then
	newTalentType{ allow_random=allow_npc, no_silence=true, is_spell=true, mana_regen=true, type="spell/runescribing", name = "Runescribing", generic = true, description = "Writing runes of great power onto objects and living beings." }
load("/data-morvarchstinkers/talents/spells/runescribing.lua")
end