
if modifier_aura_of_death == nil then
    modifier_aura_of_death = class({})
end

function modifier_aura_of_death:GetModifierAura()
    return "modifier_aura_of_death_debuff"
end

function modifier_aura_of_death:IsHidden()
	return true
end

function modifier_aura_of_death:RemoveOnDeath()
	return true
end

function modifier_aura_of_death:IsAura()
    return true
end

function modifier_aura_of_death:CanBeAddToMinions()
    return true
end

function modifier_aura_of_death:GetAuraRadius()
    return self.auraRadius
end

function modifier_aura_of_death:GetTexture()
    return "death_prophet_exorcism"
end

function modifier_aura_of_death:GetEffectName()
    return "particles/items2_fx/radiance_owner.vpcf"
end

function modifier_aura_of_death:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_aura_of_death:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_aura_of_death:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_aura_of_death:GetAuraDuration()
    return self.auraDuration
end

function modifier_aura_of_death:OnCreated()
    self.auraRadius = 1000
    self.auraDuration = 0.3
end

function modifier_aura_of_death:OnDestroy()
	if IsServer() then

	end
end

--------------------------------------------------------------------------------

modifier_aura_of_death_debuff = class({})

function modifier_aura_of_death_debuff:DeclareFunctions()
    return nil
end

function modifier_aura_of_death_debuff:GetTexture()
    return "death_prophet_exorcism"
end

function modifier_aura_of_death_debuff:IsHidden()
    return false
end

function modifier_aura_of_death_debuff:IsDebuff()
	return true
end

function modifier_aura_of_death_debuff:RemoveOnDeath()
    return true
end

function modifier_aura_of_death_debuff:GetEffectName()
    return "particles/items2_fx/radiance.vpcf"
end

function modifier_aura_of_death_debuff:OnCreated(data)
	if IsServer() then
		self.burnDmg = 50
		self.attacker = self:GetCaster() or nil	

		self:StartIntervalThink(1.0) 
	end
end

function modifier_aura_of_death_debuff:OnIntervalThink()
	if self:GetCaster() and self:GetParent() then
	    ApplyDamage({
	        victim = self:GetParent(),
	        attacker = self.attacker,
	        damage = self.burnDmg,
	        damage_type = DAMAGE_TYPE_MAGICAL,
	        ability = self
	       })
	end
end