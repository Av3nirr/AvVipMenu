ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('av_vipmenu:changePlayerPed')
AddEventHandler('av_vipmenu:changePlayerPed', function(playerId, input)
    local playerIdx = GetPlayerFromServerId(playerId)
    local ped = GetPlayerPed(playerIdx)
    exports["illenium-appearance"]:setPlayerModel(input)
    exports.bulletin:Send('Vous avez choisi le ped: ~g~'..input)
end)

RegisterNetEvent("av_vipmenu:setPlayerAppearance")
AddEventHandler('av_vipmenu:setPlayerAppearance', function(appearance)
    exports["illenium-appearance"]:setPlayerAppearance(appearance)
end)
local cooldowned = false
RegisterCommand('driftmode', function(source)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(PlayerId()), false)
            if vehicle ~= 0 then
                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 1) == PlayerPedId() then
                    local playerId = GetPlayerServerId(PlayerId())
                    ESX.TriggerServerCallback('av_vipmenu:getBoutiqueId', function(callback)
                        if callback ~= nil then
                            ESX.TriggerServerCallback('av_vipmenu:verifyGroup', function(isvip)
                                if isvip == true then
                                    exports['Drift-Script']:toogleDrift(vehicle)
                                else
                                    Config.Notify(Config.Strings.YOU_ARE_NOT_VIP)
                                end
                            end, callback)
                        end
                    end, playerId)
                end
            end
end, false)

RegisterKeyMapping('driftmode', '(VIP) Activer le mode drift', 'keyboard', 'LSHIFT')