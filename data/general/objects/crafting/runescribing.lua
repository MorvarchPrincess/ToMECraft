local base_newEntity = newEntity
function newEntity(t) t.tinker_category = "chemistry" return base_newEntity(t) end

local Talents = require "engine.interface.ActorTalents"
local Stats = require "engine.interface.ActorStats"
local DamageType = require "engine.DamageType"

local simple = {_t"crude", _t"good", _t"well-made", _t"mastercraft", _t"perfect"}

for i = 1, 5 do
    newEntity{ base = "BASE_CRAFT", define_as = "CRAFT_LIGHTNING_CASTER"..i,
        name = ("%s lightning caster"):tformat(simple[i]), image = "object/tinkers_winterchill_edge_t"..i..".png",
        material_level = i,
        metallic = false,
        special_desc = function(self) return _t"Shoots lightning on command." end,
        on_slot = "HANDS",
        is_tinker = "rune",
        object_tinker = {
            wielder = {
                learn_talent = {[Talents.T_LIGHTNING] = i},
            },
        },
    }
end

for i = 1, 5 do
    newEntity{ base = "BASE_CRAFT", define_as = "CRAFT_SCRYING_GOGGLES"..i,
        name = ("%s lightning caster"):tformat(simple[i]), image = "object/tinkers_winterchill_edge_t"..i..".png",
        material_level = i,
        metallic = false,
        special_desc = function(self) return _t"Scry on enemies from afar." end,
        on_slot = "HEAD",
        is_tinker = "rune",
        object_tinker = {
            wielder = {
                learn_talent = {[Talents.T_ARCANE_EYE] = i},
                infravision = i*2,
            },
        },
    }
end

for i = 1, 5 do
    newEntity{ base = "BASE_CRAFT", define_as = "CRAFT_THAUMATURGICAL_REINFORCEMENT"..i,
        name = ("%s Thamaturgical Reinforcement"):tformat(simple[i]), image = "object/tinkers_winterchill_edge_t"..i..".png",
        material_level = i,
        metallic = false,
        special_desc = function(self) return _t"Reinforces chest armor with runes for defence against magic." end,
        on_slot = "BODY",
        is_tinker = "rune",
        object_tinker = {
            wielder = {
                resists = {[DamageType.ARCANE] = 5*i, [DamageType.DARKNESS] = 5*i, [DamageType.LIGHT] = 5*i},
            },
        },
    }
end

for i = 1, 5 do
    newEntity{ base = "BASE_CRAFT", define_as = "CRAFT_EMERGENCY_SOLE"..i,
        name = ("%s Emergency Sole"):tformat(simple[i]), image = "object/tinkers_winterchill_edge_t"..i..".png",
        material_level = i,
        metallic = false,
        special_desc = function(self) return _t"An emergency escape on the bottom of your boots." end,
        on_slot = "FEET",
        is_tinker = "rune",
        object_tinker = {
            wielder = {
                learn_talent = {[Talents.T_PHASE_DOOR] = i},
                movement_speed=0.1,
            },
        },
    }
end

for i = 1, 5 do
    newEntity{ base = "BASE_CRAFT", define_as = "CRAFT_RUNIC_GENERATION_LOOP"..i,
        name = ("%s Runic Generation Loop"):tformat(simple[i]), image = "object/tinkers_winterchill_edge_t"..i..".png",
        material_level = i,
        metallic = false,
        special_desc = function(self) return _t"Mana generation on your waist." end,
        on_slot = "BELT",
        is_tinker = "rune",
        object_tinker = {
            wielder = {
                mana_regen = i,
            },
        },
    }
end

for i = 1, 5 do
    newEntity{ base = "BASE_CRAFT", define_as = "CRAFT_GLYPHED_EDGE"..i,
        name = ("%s Glyped Edge"):tformat(simple[i]), image = "object/tinkers_winterchill_edge_t"..i..".png",
        material_level = i,
        metallic = false,
        special_desc = function(self) return _t"Infuse arcane damage into your weapon." end,
        on_type = "weapon",
        is_tinker = "rune",
        on_tinker = function(self, o, who)
            local DamageType = require "engine.DamageType"
            if not o.combat then return true end
            
            o.combat.glyped_edge_ml = self.material_level
            o.combat.glyped_edge_damage = function(self, o, who)
                return math.ceil( who:combatMLMagicDamage(o.combat.glpyed_edge_ml, 15, 50) )
            end
            o.combat.tinker_uid = "glyped_edge" .. self.uid
            
            o:craftWeaponAddOnEffect("special_on_hit", "glyped_edge", {desc=("Zap your foe dealing %d arcane damage"):tformat(o.combat.glyped_edge_damage(self, o, who)) , fct=function(combat, who, target)
                if who.turn_procs[combat.tinker_uid or "glyped_edge"] then return end
                local DamageType = require "engine.DamageType"
                local tg = {type="hit", start_x=target.x, start_y=target.y}
                local dam = who:spellCrit(who:combatMLMagicDamage(combat.shocking_edge_ml, 15, 50))
                
                who:project(tg, target.x, target.y, DamageType.ARCANE, dam)
    
                who.turn_procs[combat.tinker_uid or "glyped_edge"] = true
            end})
        end,
        on_untinker = function(self, o, who)
            if not o.combat then return true end
            o:craftWeaponRemoveOnEffect("special_on_hit", "glyped_edge")
            o.combat.glyped_edge_ml = nil
            o.combat.glyped_edge_damage = nil
            o.combat.tinker_uid = nil
        end,
    }
end

for i = 1, 5 do
    newEntity{ base = "BASE_CRAFT", define_as = "CRAFT_CHARGED_WEAVE"..i,
        name = ("%s Charged Weave"):tformat(simple[i]), image = "object/tinkers_winterchill_edge_t"..i..".png",
        material_level = i,
        metallic = false,
        special_desc = function(self) return _t"Builds charge and unleashes a blast of lightning." end,
        on_slot = "CLOAK",
        is_tinker = "rune",
        object_tinker = {
            wielder = {
                resists = {[DamageType.LIGHTNING] = 3*i},
                learn_talent = {[Talents.T_NOVA] = i},
            },
        },
    }
end