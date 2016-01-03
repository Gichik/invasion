
function GiveMana(data)
--print("give mana")
data.caster:GiveMana(100)
StartSoundEvent("Item.MoonShard.Consume", data.caster)
end



function GiveHealth(data)
--print("give heal")
local health = data.caster:GetHealth()+150
data.caster:SetHealth(health)
StartSoundEvent("DOTA_Item.Cheese.Activate", data.caster)
end




function RemoveItemFromHero(data)
local caster = data.caster
local item = nil
local charges = 0
local first = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == data.item_name and first == 0 then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
					else
						caster:RemoveItem(item)
					end
				else
					caster:RemoveItem(item)			
				end
				first = 1
			end
		end
	end	
end


function CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end 
