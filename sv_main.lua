ESX = exports["es_extended"]:getSharedObject()


function checkGroup(boutiqueId)
    print(boutiqueId)
    local response = MySQL.query.await('SELECT `isvip` FROM `vip_users` WHERE `boutiqueId` = ?', {
        boutiqueId
    })
    if response then
        for i = 1, #response do
            local row = response[i]
            if row.isvip == true then
                return true
            end
        end
    else
        return false
    end

end

ESX.RegisterServerCallback('av_vipmenu:verifyGroup', function(src, cb, playerId)
    cb(checkGroup(playerId))
end)

function getPlayerBoutiqueId(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer ~= nil then 
        local identifier = xPlayer.getIdentifier()
        local response = MySQL.query.await('SELECT `boutiqueId` FROM `users` WHERE `identifier` = ?', {
            identifier
        })
        if response then
            for i = 1, #response do
                local row = response[i]
                return row.boutique_code
            end
        else
            return nil
        end
    end
end

ESX.RegisterServerCallback('av_vipmenu:getBoutiqueId', function(src, cb, playerId)
    cb(getPlayerBoutiqueId(playerId))
end)





function addVip(boutiqueId)
    MySQL.Async.execute('INSERT INTO `vip_users` (boutiqueId, isvip) VALUES (@boutiqueId, true) ON DUPLICATE KEY UPDATE isvip=true', {
        ['@boutiqueId'] = boutiqueId
    }, function(rowsAffected)
        if rowsAffected > 0 then
            print("Utilisateur VIP inséré ou mis à jour avec succès.")
        else
            print("L'utilisateur VIP n'a pas été inséré ou mis à jour.")
        end
    end)
end

function removeVip(boutiqueId)
    MySQL.Async.execute('DELETE FROM `vip_users` WHERE `boutiqueId` = @boutiqueId', {
        ['@boutiqueId'] = boutiqueId
    }, function(rowsAffected)
        if rowsAffected > 0 then
            print("Utilisateur VIP supprimé avec succès.")
        else
            print("L'utilisateur VIP n'a pas été trouvé.")
        end
    end)
end


RegisterNetEvent('av_vipmenu:addMoney')
AddEventHandler("av_vipmenu:addMoney", function(playerId, amount)
    local xPlayer = ESX.GetPlayerFromId(tonumber(playerId))
    if xPlayer ~= nil then
        xPlayer.addAccountMoney('bank', amount)
    end
end)

RegisterNetEvent('av_vipmenu:resetPlayerPed')
AddEventHandler('av_vipmenu:resetPlayerPed', function(playerId)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0
        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
            end)
        end)
    end)
end)


ESX.RegisterCommand({'addvip', 'vipadd'}, 'admin', function(xPlayer, args, showError)
    if args["idboutique"] ~= nil then
        addVip(args["idboutique"])
        xPlayer.showNotification("~g~Vous avez donné un accès VIP illimité à l'id boutique: "..args["idboutique"])
    end
  end, false, {arguments = {{name = 'idboutique', help = "Id boutique du joueur", type = 'number'}}
})

ESX.RegisterCommand({'removevip', 'vipremove'}, 'admin', function(xPlayer, args, showError)
    if args["idboutique"] ~= nil then
        removeVip(args["idboutique"])
        xPlayer.showNotification("~r~Vous avez révoqué un accès VIP illimité à l'id boutique: "..args["idboutique"])
    end
  end, false, {arguments = {{name = 'idboutique', help = "Id boutique du joueur", type = 'number'}}
})


CreateThread(function()
    while true do
        local amount = Config.subventionAmount
        local timeInMinutes = Config.subventionDelay
        for _, playerId in ipairs(GetPlayers()) do
            local boutiqueId = getPlayerBoutiqueId(playerId)
            if checkGroup(boutiqueId) == true then
                local xPlayer = ESX.GetPlayerFromId(playerId)
                if xPlayer ~= nil then
                    xPlayer.addAccountMoney('bank', amount)
                    xPlayer.showAdvancedNotification('Aide de l\'Etat', '~y~Bonus V.I.P', 'Vous avez reçu '..amount..'$ d\'aides de l\'Etat', 'CHAR_BANK_FLEECA', nil, nil, nil, nil, 4000)
                else
                    print("xPlayer nil:"..playerId)
                end
            else
                print("Pas VIP ID:"..playerId)
            end
        end
        Wait(timeInMinutes*60000)
    end
end)

ESX.RegisterCommand({'idboutique'}, 'admin', function(xPlayer, args, showError)
    if not args.radius then args.radius = 4 end
    xPlayer.showNotification('ID boutique du joueur '..args['playerid'].. ": ~g~"..getPlayerBoutiqueId(args['playerid']))
  end, false, {help = "Récupérer l'id boutique du joueur", arguments = {{name = 'playerid', help = "Id du joueur", type = 'number'}}
  })