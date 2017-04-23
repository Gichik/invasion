item_octar = class({}) 


function item_octar:OnCreated(data)
	print("OnCreated")
	local caster = data.caster
	local ability = data.ability

	if not caster:HasModifier("modifier_item_ultimate_scepter") then
		caster:AddNewModifier(caster, ability, "modifier_item_ultimate_scepter", {duration = -1})
	end

	if not caster:HasModifier("modifier_item_octarine_core") then
		caster:AddNewModifier(caster, ability, "modifier_item_octarine_core", {duration = -1})
	end

	--print(caster:HasModifier("modifier_item_octarine_core"))	
end

function item_octar:OnDestroy(data)
	print("OnDestroy")	
	local caster = data.caster
	local num_octarinius = 0

	for i = 0, 5 do  
		local current_item = caster:GetItemInSlot(i)
		if current_item ~= nil then
			local item_name = current_item:GetName()
			
			if item_name == "item_octarinius" then
				num_octarinius = num_octarinius + 1
			end
		end
	end

	if num_octarinius == 0 and caster:HasModifier("modifier_item_ultimate_scepter") then
		caster:RemoveModifierByName("modifier_item_ultimate_scepter")
	end
	if num_octarinius == 0 and caster:HasModifier("modifier_item_octarine_core") then
		caster:RemoveModifierByName("modifier_item_octarine_core")
	end
end




