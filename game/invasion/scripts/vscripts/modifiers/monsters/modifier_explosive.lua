
if modifier_explosive == nil then
    modifier_explosive = class({})
end

function modifier_explosive:IsHidden()
	return false
end

function modifier_explosive:GetTexture()
    return "invoker_forge_spirit"
end

function modifier_explosive:RemoveOnDeath()
	return true
end

function modifier_explosive:CanBeAddToMinions()
    return true
end

function modifier_explosive:IsPurgable()
    return false
end

function modifier_explosive:IsPurgeException()
    return false
end


function modifier_explosive:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_DEATH
    }
    return funcs
end

function modifier_explosive:OnDeath(data)
	if IsServer() then
		if data.unit == self:GetParent() then
			local parent = self:GetParent()

			EmitSoundOn("Hero_LifeStealer.Infest", parent)
			ParticleManager:CreateParticle("particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_bloody_mid.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)

			local units = FindUnitsInRadius( parent:GetTeamNumber(), parent:GetAbsOrigin(), parent, self.explosiveRadius,
				DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, 0, false )

			if units then	
				for i = 1, #units do
			        ApplyDamage({
			            victim = units[ i ],
			            attacker = parent,
			            damage = self.explosiveDmg,
			            damage_type = DAMAGE_TYPE_MAGICAL,
			            ability = self
			           })	
				end
			end			
		end
	end
end

function modifier_explosive:OnCreated()
	if IsServer() then
		self.explosiveDmg = 170
		self.explosiveRadius = 400
		self:GetParent():SetRenderColor(255, 69, 0) 
	end
end