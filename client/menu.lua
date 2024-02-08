local playerId = GetPlayerServerId(PlayerId())
local washCooldown = false
local pedCooldown = false

--main menu
lib.registerMenu({
    id = 'vip_menu',
    title = Config.Strings.MENU_TITLE,
    position = 'top-right',
    options = {
        {label = Config.Strings.PED_BUTTON_TITLE, description = Config.Strings.PED_BUTTON_DESCRIPTION, icon = {'fas', 'person'}},
        {label = Config.Strings.WEAPON_BUTTON_TITLE, description = Config.Strings.WEAPON_BUTTON_DESCRIPTION, icon = {'fas', 'gun'}},
        {label = Config.Strings.CAR_BUTTON_TITLE, description = Config.Strings.CAR_BUTTON_DESCRIPTION, icon= {'fas', 'car'}},
        {label = Config.Strings.PROPS_BUTTON_DESCRIPTION, description = Config.Strings.PROPS_BUTTON_DESCRIPTION, icon= {'fas', 'couch'}},
    }
}, function(selected, scrollIndex, args)
        if selected == 1 then
            lib.showMenu('vip_menu_ped')
        elseif selected == 2 then
            lib.showMenu('vip_menu_weapon')
        elseif selected == 2 then
            lib.showMenu('vip_menu_car')
        elseif selected == 3 then
            --if you want, you can add your own props system
            exports['eProps']:PropsMenu()
        end
end)

--don't touch this, or change if you have more weapon tints
local weapon_list = {
    "Normal",
    "Vert",
    "Or",
    "Rose",
    "Armée",
    "LSPD",
    "Orange",
    "Platinium",
}

--menu ped
lib.registerMenu({
    id = 'vip_menu_ped',
    title = Config.Strings.PED_MENU_TITLE,
    position = 'top-right',
    options = {
        {label = Config.Strings.PED_MENU_BUTTON_CHANGE_TITLE, values = Config.autorisedPedModels},
        {label = Config.Strings.PED_MENU_BUTTON_RESET_TITLE, description = Config.Strings.PED_MENU_BUTTON_RESET_DESCRIPTION},
    }
}, function(selected, scrollIndex, args)
        if selected == 1 then
            if pedCooldown == false then
                TriggerEvent("av_vipmenu:changePlayerPed", playerId, Config.autorisedPedModels[scrollIndex])
                pedCooldown = true
                Citizen.SetTimeout(1440*60*1000, function()
                    pedCooldown = false
                end)
            else
                Config.Notify(Config.Strings.WAIT_BEFORE_CHANGE_PED)
            end
        elseif selected == 2 then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    TriggerEvent('skinchanger:loadSkin', skin)
                    TriggerEvent('esx:restoreLoadout')
                end)
            end)
        end
end)
--menu armes
lib.registerMenu({
    id = 'vip_menu_weapon',
    title = Config.Strings.WEAPON_MENU_TITLE,
    position = 'top-right',
    onSideScroll = function(selected, scrollIndex, args)
        if selected == 1 then
            local weapon = exports.ox_inventory:getCurrentWeapon()
            if weapon then
                TriggerServerEvent('av_vipmenu:changeWeaponTint', weapon, scrollIndex-1)
                SetPedWeaponTintIndex(PlayerPedId(), GetSelectedPedWeapon(PlayerPedId()), scrollIndex-1)
                exports.bulletin:Send(string.format(Config.Strings.YOU_CHOOSED_TINT,weapon_list[scrollIndex]), 500)
            else
                Config.Notify(Config.Strings.YOU_HAVE_NO_EQUIPED_WEAPON)
            end
        end
    end,
    options = {
        {label = Config.Strings.WEAPON_MENU_BUTTON_TINT_TITLE, values = weapon_list, description= Config.Strings.WEAPON_MENU_BUTTON_TINT_DESCRIPTION},
    }
}, function(selected, scrollIndex, args)
end)



-- menu voiture

local labelCouleurs = Config.labelColors
local RGBcoulours = Config.RGBcoulours
neonsChecked = false
lib.registerMenu({
    id = 'vip_menu_car',
    title = Config.Strings.CAR_MENU_TITLE,
    position = 'top-right',
    onSideScroll = function(selected, scrollIndex, args)
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
        if selected == 2 then
            print(RGBcoulours[labelCouleurs[scrollIndex]].r.." "..RGBcoulours[labelCouleurs[scrollIndex]].g.." "..RGBcoulours[labelCouleurs[scrollIndex]].b)
            SetVehicleNeonLightsColour(vehicle, RGBcoulours[labelCouleurs[scrollIndex]].r, RGBcoulours[labelCouleurs[scrollIndex]].g, RGBcoulours[labelCouleurs[scrollIndex]].b)
        end
    end,
    options = {
        {label = Config.Strings.CAR_MENU_BUTTON_NEONS_TITLE, description = Config.Strings.CAR_MENU_BUTONN_NEONS_DESCRIPTION, close = false,},
        {label = Config.Strings.CAR_MENU_BUTTON_NEONS_COLOR_TITLE, values = labelCouleurs, close = false,},
        {label = Config.Strings.CAR_MENU_BUTTON_DRIFT_TITLE, description = Config.Strings.CAR_MENU_BUTONN_DRIFT_DESCRIPTION, close = true,},
        {label = Config.Strings.CAR_MENU_BUTTON_WASH_TITLE, description = Config.Strings.CAR_MENU_BUTONN_WASH_DESCRIPTION, close = true,},
        
    }
}, function(selected, scrollIndex, args)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
    if selected == 1 then
        if neonsChecked == true then
            SetVehicleNeonLightEnabled(vehicle, 0, false)
            SetVehicleNeonLightEnabled(vehicle, 1, false)
            SetVehicleNeonLightEnabled(vehicle, 2, false)
            SetVehicleNeonLightEnabled(vehicle, 3, false)
            neonsChecked = false
        else
            SetVehicleNeonLightEnabled(vehicle, 0, true)
            SetVehicleNeonLightEnabled(vehicle, 1, true)
            SetVehicleNeonLightEnabled(vehicle, 2, true)
            SetVehicleNeonLightEnabled(vehicle, 3, true)
            neonsChecked = true
        end
    end
    if selected == 3 then
        exports['Drift-Script']:toogleDrift(vehicle)
    end
    if selected == 4 then
        if washCooldown == false then
            SetVehicleDirtLevel(vehicle, 0.1)
            Config.Notify(Config.Strings.VEHICLE_WASHED)
            washCooldown = true
            Citizen.SetTimeout(30000, function()
                washCooldown = false
            end)
        else
            Config.Notify(Config.Strings.WAIT_BEFORE_WASH_AGAIN)
        end

    end
end)

RegisterCommand('vipmenu', function(source, args)
    local playerId = GetPlayerServerId(PlayerId())
    ESX.TriggerServerCallback('av_vipmenu:getBoutiqueId', function(callback)
        if callback ~= nil then
            ESX.TriggerServerCallback('av_vipmenu:verifyGroup', function(isvip)
                if isvip == true then
                    lib.showMenu('vip_menu')
                else
                    Config.Notify(Config.Strings.YOU_ARE_NOT_VIP)
                end
            end, callback)
        end
    end, playerId)
end, false)
