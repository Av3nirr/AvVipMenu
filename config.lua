Config = {}

-- menu strings

Config.Strings = {
    MENU_TITLE = '💎 Menu VIP 💎',
    PED_BUTTON_TITLE = 'Menu PED',
    PED_BUTTON_DESCRIPTION = 'Permet de modifier son PED',
    CAR_BUTTON_TITLE = 'Menu Voiture',
    CAR_BUTTON_DESCRIPTION = 'Permet de modifier sa voiture',
    WEAPON_BUTTON_TITLE = 'Menu Armes',
    WEAPON_BUTTON_DESCRIPTION = 'Permet de modifier son arme',
    PROPS_BUTTON_TITLE = 'Menu Props',
    PROPS_BUTTON_DESCRIPTION = 'Permet d\'ajouter/enlever des props',
    PED_MENU_TITLE = 'Menu PED',
    PED_MENU_BUTTON_CHANGE_TITLE = 'Changer d\'apparence',
    PED_MENU_BUTTON_RESET_TITLE = 'Redevenir Normal',
    PED_MENU_BUTTON_RESET_DESCRIPTION = 'Permet de redevenir normal',
    WAIT_BEFORE_CHANGE_PED = '~r~Vous devez encore attendre avant de changer à nouveau de ped !',
    WEAPON_MENU_TITLE = 'Menu Arme',
    WEAPON_MENU_BUTTON_TINT_TITLE = 'Skin',
    WEAPON_MENU_BUTTON_TINT_DESCRIPTION = 'Changer le skin de l\'armne',
    CAR_MENU_TITLE = 'Menu Voiture',
    CAR_MENU_BUTTON_NEONS_TITLE = 'Activer/Désactiver les néons',
    CAR_MENU_BUTONN_NEONS_DESCRIPTION = 'Permet d\'activer/désactiver les néons',
    CAR_MENU_BUTTON_NEONS_COLOR_TITLE = 'Couleur des néons',
    CAR_MENU_BUTTON_DRIFT_TITLE = 'Activer/Désactiver le mode Drift',
    CAR_MENU_BUTONN_DRIFT_DESCRIPTION = 'Permet d\'activer/désactiver le mode DRIFT',
    CAR_MENU_BUTTON_WASH_TITLE = 'Nettoyer le véhicule',
    CAR_MENU_BUTONN_WASH_DESCRIPTION = 'Enlever la saleté présente dans votre véhicule',
    WAIT_BEFORE_WASH_AGAIN = '~r~Vous devez encore attendre avant de netooyer à nouveau votre véhicule !',
    VEHICLE_WASHED = "~g~Votre véhicule à été nettoyé !",
    YOU_ARE_NOT_VIP = "Vous n'êtes pas VIP",
    YOU_HAVE_NO_EQUIPED_WEAPON= '~r~Vous n\'avez pas d\'arme équipée !',
    YOU_CHOOSED_TINT = 'Vous avez choisi le skin %s',
    --ADMINS COMMANDS
    YOU_GAVE_VIP = '~g~Vous avez donné un accès VIP illimité à l\'id boutique: %s',
    YOU_REMOVED_VIP = "~r~Vous avez révoqué un accès VIP illimité à l'id boutique: %s"

}
Config.labelColors = {"Rouge", "Vert", "Jaune", "Bleu", "Violet"}
Config.RGBcoulours = {
    ["Rouge"] = {
        r = 255,
        g = 0,
        b= 0
    },
    ["Vert"] = {
        r = 0,
        g = 255,
        b= 0
    },
    ["Jaune"] = {
        r = 255,
        g = 240,
        b= 0
    },
    ["Bleu"] = {
        r = 0,
        g = 0,
        b= 255
    },
    ["Violet"] = {
        r = 209,
        g = 0,
        b= 255
    },
}

--Here are the allowed ped model for the ped menu
Config.autorisedPedModels = {
    "a_f_m_beach_01",
    "a_f_m_bevhills_01",
    "a_f_m_soucentmc_01",
    "a_f_o_salton_01",
    "a_f_y_scdressy_01",
    "a_m_m_farmer_01",
    "a_m_m_hillbilly_01",
    "a_f_m_bevhills_01",
    "a_f_m_fatwhite_01",
    "a_f_m_prolhost_01",
    "a_f_m_skidrow_01",
    "a_f_y_bevhills_01",
    "a_f_y_bevhills_02",
    "a_f_y_bevhills_03",
    "a_f_y_business_02",
    "s_f_y_clubbar_01",
    "g_f_y_families_01",
    "s_f_y_movprem_01",
    "g_f_y_vagos_01",
    "a_f_y_clubcust_02",
    "u_f_m_miranda_02",
    "a_f_y_bevhills_04",
    "ig_bride",
    "ig_djtalaurelia",
    "a_m_m_hasjew_01",
    "a_m_m_og_boss_01",
    "a_m_m_paparazzi_01",
    "a_m_y_beach_03",
    "u_m_m_jesus_01",
    "a_m_y_breakdance_01",
    "a_m_y_musclbeac_02",
    "cs_joeminuteman",
    "ig_djsolfotios",
    "u_m_m_partytarget",
    "cs_lamardavis",
    "ig_priest",
    "ig_ramp_mex",
    "csb_sol",
    "ig_djtalignazio",
    "csb_talmm",
    "csb_thornton",
    "ig_djblamryans",
    "s_m_y_waretech_01",
    "s_m_y_westsec_01"
}



Config.Notify = function(text)
    --change this by your notifications system
    exports.bulletin:Send(text)
end


Config.advancedNotify = function(text, title, subject, icon, timeout, progress)
    --change this by your advanced notifications system
    exports.bulletin:SendAdvanced({
        message = text,
        title = title,
        subject = subject,
        icon = icon,
        timeout = timeout,
        progress = progress,
    })
end

Config.subventionAccount = 'bank'
Config.subventionAmount = 200 --argent donné en banque !
Config.subventionDelay = 30 -- en minutes

Config.getPlayerBoutiqueId = function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer ~= nil then 
        local identifier = xPlayer.getIdentifier()
        local response = MySQL.query.await('SELECT `boutiqueId` FROM `users` WHERE `identifier` = ?', {
            identifier
        })
        if response then
            for i = 1, #response do
                local row = response[i]
                return row.boutiqueId
            end
        else
            return nil
        end
    end
end