
if modifier_unity_of_evil == nil then
    modifier_unity_of_evil = class({})
end

function modifier_unity_of_evil:IsHidden()
	return false
end

function modifier_unity_of_evil:RemoveOnDeath()
	return true
end

function modifier_unity_of_evil:CanBeAddToMinions()
    return true
end

function modifier_unity_of_evil:IsPurgable()
    return false
end

function modifier_unity_of_evil:IsPurgeException()
    return false
end

function modifier_unity_of_evil:GetTexture()
    return "bane_fiends_grip"
end

function modifier_unity_of_evil:GetEffectName()
    return "particles/units/heroes/hero_witchdoctor/witchdoctor_maledict_dot_skulls.vpcf"
end

function modifier_unity_of_evil:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MODEL_SCALE
    }
    return funcs
end

function modifier_unity_of_evil:GetModifierPreAttack_BonusDamage()	
	return self:GetStackCount()*self.damageBonus or 0
end

function modifier_unity_of_evil:GetModifierConstantHealthRegen()	
	return self:GetStackCount()*self.healthRegen or 0
end

function modifier_unity_of_evil:GetModifierMagicalResistanceBonus()	
	return self:GetStackCount()*self.magicResBonus or 0
end

function modifier_unity_of_evil:GetModifierPhysicalArmorBonus()	
	return self:GetStackCount()*self.physArmorBonus or 0
end

function modifier_unity_of_evil:GetModifierModelScale()	
	return self:GetStackCount()*self.modelScalePers or 0
end

function modifier_unity_of_evil:OnCreated()
	self.damageBonus = 90
	self.healthRegen = 9
	self.magicResBonus = 15 
	self.physArmorBonus = 15
	self.modelScalePers = 20
	self.auraRadius = 600
	self.auraDuration = 0.3

	if IsServer() then
		self:GetParent():SetRenderColor(199, 21, 133)
	end
end

function modifier_unity_of_evil:IsAura()
    return true
end

function modifier_unity_of_evil:GetAuraRadius()
    return self.auraRadius
end

function modifier_unity_of_evil:GetModifierAura()
    return "modifier_unity_of_evil_mark"
end

function modifier_unity_of_evil:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_unity_of_evil:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_unity_of_evil:GetAuraDuration()
    return self.auraDuration
end

--------------------------------------------------------------------------------

modifier_unity_of_evil_mark = class({})

function modifier_unity_of_evil_mark:IsHidden()
    return true
end

function modifier_unity_of_evil_mark:RemoveOnDeath()
    return true
end

function modifier_unity_of_evil_mark:OnCreated()
	self.auraRadius = 600
end

function modifier_unity_of_evil_mark:OnDestroy()
	if IsServer() then
		local units = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent(), self.auraRadius,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
			
		if units then
			--EmitSoundOn("Hero_Axe.CounterHelix", caster)	
			for i = 1, #units do	
			local modifier = units[i]:FindModifierByName("modifier_unity_of_evil")	
				if modifier and modifier:GetStackCount() < 5 then
					modifier:IncrementStackCount()
				end		
			end
		end		
	end
end

