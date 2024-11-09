if not Talents.talents_types_def["technique/gemcraft"] then
	newTalentType{ allow_random=allow_npc, no_silence=true, is_spell=false, mana_regen=false, type="technique/gemcraft", name = "Gemcraft", generic = true, description = "Crafting gems into objects of great power." }
load("/data-morvarchstinkers/talents/techniques/gemcraft.lua")
end