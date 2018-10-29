
if modifier_attack_of_deactivating == nil then
    modifier_attack_of_deactivating = class({})
end

function modifier_attack_of_deactivating:IsHidden()
	return true
end

function modifier_attack_of_deactivating:GetTexture()
    return "life_stealer_feast"
end

function modifier_attack_of_deactivating:RemoveOnDeath()
	return true
end

function modifier_attack_of_deactivating:IsPurgable()
	return false
end

function modifier_attack_of_deactivating:IsPurgeException()
	return false
end

function modifier_attack_of_deactivating:DeclareFunctions()
    local funcs = {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
    return funcs
end

function modifier_attack_of_deactivating:OnAttackLanded(data)
	if IsServer() then
		if data.attacker == self:GetParent() and data.target:IsAlive() then
			local hTarget = data.target
			local hItem = nil

			if hTarget:HasItemInInventory("item_heart") then
				for i = 0, 5 do
		            hItem = hTarget:GetItemInSlot(i)
		            if hItem ~= nil then
		                if hItem:GetAbilityName() == "item_heart" then
		                    hItem:StartCooldown(hItem:GetCooldown(1))               
		                end
		            end
		        end
			end
			
		end
	end
end