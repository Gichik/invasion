axe_culling_blade_custom = class({})

LinkLuaModifier("modifier_autocast_culling_blade", "modifiers/modifier_autocast_culling_blade.lua", LUA_MODIFIER_MOTION_NONE )

function axe_culling_blade_custom:GetCastAnimation()  
    return ACT_DOTA_CAST_ABILITY_4  
end

 function axe_culling_blade_custom:GetBehavior() 
     local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_AUTOCAST 
     return behav
 end


function axe_culling_blade_custom:OnSpellStart()

    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local killThreshold = self:GetSpecialValueFor("kill_threshold_scepter")
    local speedDuration = self:GetSpecialValueFor("speed_duration")

    if caster:HasItemInInventory("item_ultimate_scepter") then
        killThreshold = self:GetSpecialValueFor("kill_threshold_scepter")
        speedDuration = self:GetSpecialValueFor("speed_duration_scepter")
    end
    
    if target:GetHealth() <= killThreshold then
        EmitSoundOn("Hero_Axe.Culling_Blade_Success", self:GetCaster())
        self:KillUnit(target) 
        self:GiveBaff(caster,speedDuration)
            
    else
        EmitSoundOn("Hero_Axe.Culling_Blade_Fail", self:GetCaster())
        ApplyDamage( { victim = target, attacker = caster, damage = self:GetSpecialValueFor("damage"),
                        damage_type = DAMAGE_TYPE_PURE, ability = self} )
    end
end


function axe_culling_blade_custom:KillUnit(target) 
    target:ForceKill(false)
    --ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf", PATTACH_ABSORIGIN, target)
    ParticleManager:CreateParticle("particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_bloody.vpcf", PATTACH_ABSORIGIN, target)
    
end


function axe_culling_blade_custom:GiveBaff(caster,speedDuration)
    local units = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetAbsOrigin(), caster, self:GetSpecialValueFor("speed_aoe") ,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
        
    for i = 1, #units do        
        if units[ i ] then
            units[ i ]:AddNewModifier(caster, self, "modifier_axe_culling_blade_boost", { duration = speedDuration})  
            ParticleManager:CreateParticle("particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff_symbol.vpcf", PATTACH_ABSORIGIN, units[ i ])


        end
    end  
end


function axe_culling_blade_custom:OnUpgrade()

    local caster = self:GetCaster()
        
    if self:GetLevel() == 1 then
        GameRules:GetGameModeEntity():SetContextThink("axe_culling_blade_custom_autocast", 
            function()
                if self:GetAutoCastState() then
                    caster:AddNewModifier(caster, self, "modifier_autocast_culling_blade", {})
                else
                    caster:RemoveModifierByName("modifier_autocast_culling_blade")
                end
            return 1
            end,
            1)
    end

end


function axe_culling_blade_custom:IsStealable()
    return false
end

function axe_culling_blade_custom:IsHiddenWhenStolen()
	return true
end