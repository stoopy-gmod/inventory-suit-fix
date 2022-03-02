
// Suit Fix
for k, v in pairs(Armor.Data) do 
    local ITEM = XeninInventory:CreateItemV2()
    local dec = ITEM:SetDescription(v.Description)
    local name = v.Name
    local customDes = v.Name .. "" 
    if dec == "" then 
        return ""
    else 
        ITEM:SetDescription(customDes)
    end 

    ITEM.V2 = true
    ITEM:SetMaxStack(3)
    ITEM:SetModel(v.Model)
    ITEM.Name = v.Name
    ITEM:AddDrop(function() end)

    ITEM:AddEquip(function(self, ply, tbl) 
        local hasArmor = Armor:Get( ply.armorSuit )

        if IsValid(hasArmor) then return end 

        if hasArmor then 
            return false 
        end 
        ply.armorSuit = v.Name

        if !cooldown or !hasArmor then 
            ply:applyArmorSuit()
        end 

        net.Start( "armorSend" )
            net.WriteString( v.Name )
        net.Send( ply )

    end, function(self, ply, slot) 
        local hasArmor = Armor:Get( ply.armorSuit )
        local cooldown = ply.ArmorEquipCooldown
        local ent = slot.ent
        local data = slot.data
        local name = self:GetName(slot)
      
        return !hasArmor, "You already have a suit equipped do /dropsuit to equip another suit"

    end)




    function ITEM:GetData(ent)
        return {
            Name = self.Name,
            isArmor = true
        }
    end

    function ITEM:GetName(item)
        return self.Name
    end

    function ITEM:GetCameraModifiers(tbl)
            return {
                FOV = 45,
                X = 0,
                Y = -30,
                Z = 25,
                Angles = Angle(0, 15, 0),
                Pos = Vector(0, 0, -1.5)
            }
    end

    ITEM:Register(v.Entitie)

end 
