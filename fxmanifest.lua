fx_version 'adamant'

game 'gta5'

description 'Vip menu for FiveM compatible with esx_skin.'

author 'Av3nirr'

client_scripts {
    "menu.lua",
    "cl_main.lua",
}

server_scripts {
    "sv_main.lua",
    '@mysql-async/lib/MySQL.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
lua54 'yes'