
if modifier_hommer_cry == nil then
    modifier_hommer_cry = class({})
end

function modifier_hommer_cry:IsHidden()
	return true
end

function modifier_hommer_cry:GetTexture()
    return "nevermore_shadowraze1"
end

function modifier_hommer_cry:RemoveOnDeath()
	return true
end

function modifier_hommer_cry:CanBeAddToMinions()
    return true
end

function modifier_hommer_cry:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return funcs
end

--[[new_pos, process_procs,order_type,issuer_player_index,fail_type,damage_category,reincarnate,damage,ignore_invis
attacker,ranged_attack,record,unit,do_not_consume,damage_type,activity,heart_regen_applied,diffusal_applied
mkb_tested,no_attack_cooldown,damage_flags,original_damage,gain,cost,basher_tested,distance]]
function modifier_hommer_cry:OnTakeDamage(data)
	if IsServer() then
		if data.unit == self:GetParent() then
			if self.numbAttack <= 0 then
				self.numbAttack = 70
				EmitGlobalSound("Invasion.HommerCry")
			else
				self.numbAttack = self.numbAttack - 1
			end
		end
	end
end


function modifier_hommer_cry:OnCreated()
	if IsServer() then	
		self.numbAttack = 0
	end
end