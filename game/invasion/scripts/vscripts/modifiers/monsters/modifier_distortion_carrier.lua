
if modifier_distortion_carrier == nil then
    modifier_distortion_carrier = class({})
end

function modifier_distortion_carrier:IsHidden()
	return false
end

function modifier_distortion_carrier:GetTexture()
    return "dark_seer_ion_shell"
end

function modifier_distortion_carrier:RemoveOnDeath()
	return true
end

function modifier_distortion_carrier:CanBeAddToMinions()
    return true
end

function modifier_distortion_carrier:IsPurgable()
    return false
end

function modifier_distortion_carrier:IsPurgeException()
    return false
end

function modifier_distortion_carrier:OnCreated()
	self.damagePerTick = 10
	self.damageType = DAMAGE_TYPE_MAGICAL
	self.damageRadius = 250

	if self.particle_id then
		ParticleManager:DestroyParticle(self.particle_id, false)
		ParticleManager:ReleaseParticleIndex(self.particle_id)
	end

	self.particle_id = nil

	if IsServer() then
		self:GetParent():SetRenderColor(148, 0, 211)
		self:StartIntervalThink(0.3) 
	end
end

function modifier_distortion_carrier:OnIntervalThink()
	
	local parent = self:GetParent()

	if parent:IsAlive() then

		if self.particle_id == nil then

			self.particle_id = ParticleManager:CreateParticle( "particles/units/heroes/hero_dark_seer/dark_seer_ion_shell.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent )
			ParticleManager:SetParticleControlEnt( self.particle_id, 0, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", parent:GetAbsOrigin(), true )
			ParticleManager:SetParticleControl( self.particle_id, 1, Vector(50, 50, 50) )
			parent:EmitSound("Hero_Dark_Seer.Ion_Shield_lp")

		end

		local units = FindUnitsInRadius( parent:GetTeamNumber(), parent:GetAbsOrigin(), parent, self.damageRadius,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )
			
		if units then	
			for i = 1, #units do
		        ApplyDamage({
		            victim = units[ i ],
		            attacker = parent,
		            damage = self.damagePerTick,
		            damage_type = self.damageType,
		            ability = self
		           })	
			end
		end
	end
end


function modifier_distortion_carrier:OnDestroy()
	if IsServer() then
		local parent = self:GetParent()
		parent:StopSound("Hero_Dark_Seer.Ion_Shield_lp")

		if self.particle_id then
			ParticleManager:DestroyParticle(self.particle_id, false)
			ParticleManager:ReleaseParticleIndex(self.particle_id)
			self.particle_id = nil
		end
	end
end