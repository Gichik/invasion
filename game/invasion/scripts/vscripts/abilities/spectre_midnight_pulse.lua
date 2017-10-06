spectre_midnight_pulse = class({})


function spectre_midnight_pulse:GetCastAnimation()  
    return ACT_DOTA_CAST_ABILITY_4  
end

 function spectre_midnight_pulse:GetAOERadius()
     return self:GetSpecialValueFor("radius")
 end

function spectre_midnight_pulse:OnSpellStart()

    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local radius = self:GetSpecialValueFor("radius")
    local damage_percent = self:GetSpecialValueFor("damage_percent")/100   
    local duration = self:GetSpecialValueFor("duration")   
    local tick_rate = 1
    local MagicLifeSteal = false

    local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_enigma/enigma_midnight_pulse.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControl( id1, 0, point)  
    ParticleManager:SetParticleControl( id1, 1, Vector(1,1,1)*radius) 
    StartSoundEventFromPosition("Hero_Enigma.Midnight_Pulse", point)
    GridNav:DestroyTreesAroundPoint(point, radius, true)


    Timers:CreateTimer(duration,function()
        ParticleManager:DestroyParticle(id1, false)
        tick_rate = nil
    end)
    Timers:CreateTimer(0,function()

        local units = FindUnitsInRadius( caster:GetTeamNumber(), point, caster, radius,
            DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

        for i = 1, #units do        
            if units[ i ] then 
                ApplyDamage({
                    victim = units[ i ],
                    attacker = caster,
                    damage = units[ i ]:GetMaxHealth() * damage_percent,
                    damage_type = self:GetAbilityDamageType(),
                    ability = self
                   })
            end
        end

        return tick_rate
    end)

end

function spectre_midnight_pulse:IsStealable()
    return true
end

function spectre_midnight_pulse:IsHiddenWhenStolen()
	return false
end

