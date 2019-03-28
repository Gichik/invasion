
if modifier_circulator_infection == nil then
    modifier_circulator_infection = class({})
end

function modifier_circulator_infection:IsHidden()
	return false
end

function modifier_circulator_infection:GetTexture()
    return "venomancer_poison_sting"
end

function modifier_circulator_infection:RemoveOnDeath()
	return true
end

function modifier_circulator_infection:CanBeAddToMinions()
    return true
end

function modifier_circulator_infection:IsPurgable()
    return false
end

function modifier_circulator_infection:IsPurgeException()
    return false
end

function modifier_circulator_infection:GetEffectName()
    return "particles/econ/items/juggernaut/jugg_fortunes_tout/jugg_healling_ward_fortunes_tout_hero_heal.vpcf"
end

function modifier_circulator_infection:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_circulator_infection:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() then
			data.target:AddNewModifier(data.attacker, self, "modifier_circulator_infection_debuff", {duration = 5})
		end
	end
end

function modifier_circulator_infection:OnCreated()
	if IsServer() then
		self:GetParent():SetRenderColor(50, 205, 50) 
	end
end


--------------------------------------------------------------------------------

modifier_circulator_infection_debuff = class({})

function modifier_circulator_infection_debuff:GetTexture()
    return "venomancer_poison_sting"
end

function modifier_circulator_infection_debuff:IsHidden()
    return false
end

function modifier_circulator_infection_debuff:RemoveOnDeath()
    return true
end

function modifier_circulator_infection_debuff:OnCreated(data)
	if IsServer() then
		self:StartIntervalThink(1.0) 
		self.poisonDmg = 60
		self.attacker = self:GetCaster() or nil
	end
end

function modifier_circulator_infection_debuff:OnIntervalThink()
    self.attacker = self:GetCaster() or nil
    ApplyDamage({
        victim = self:GetParent(),
        attacker = self.attacker,
        damage = self.poisonDmg,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self
       })
end