
if modifier_thorns == nil then
    modifier_thorns = class({})
end

function modifier_thorns:IsHidden()
	return false
end

function modifier_thorns:GetTexture()
    return "bristleback_bristleback"
end

function modifier_thorns:RemoveOnDeath()
	return true
end

function modifier_thorns:CanBeAddToMinions()
    return true
end

function modifier_thorns:IsPurgable()
    return false
end

function modifier_thorns:IsPurgeException()
    return false
end

function modifier_thorns:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
    return funcs
end

function modifier_thorns:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() then
			self.incomeDmg = self.incomeDmg + data.damage
			if self.incomeDmg > self:GetParent():GetMaxHealth()/self.numShoots then
				self:ApplyThorns()
				self.incomeDmg = self.incomeDmg - (self:GetParent():GetMaxHealth()/self.numShoots)
			end
		end
	end
end

function modifier_thorns:OnCreated()
	if IsServer() then
		self.incomeDmg = 0
		self.numShoots = 5
		self.thronsDmg = 50
		self.thronsRadius = 400
		self:GetParent():SetRenderColor(139, 69, 19) 
	end
end


function modifier_thorns:ApplyThorns()
	local parent = self:GetParent()
	EmitSoundOn("Hero_Bristleback.QuillSpray.Cast", parent)
	ParticleManager:CreateParticle("particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray_quills.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	
	local units = FindUnitsInRadius( parent:GetTeamNumber(), parent:GetAbsOrigin(), parent, self.thronsRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
		
	if units then	
		for i = 1, #units do
			EmitSoundOn("Hero_Bristleback.QuillSpray.Target", units[i])	
	        ApplyDamage({
	            victim = units[ i ],
	            attacker = parent,
	            damage = self.thronsDmg,
	            damage_type = DAMAGE_TYPE_PHYSICAL,
	            ability = self
	           })	
		end
	end

end