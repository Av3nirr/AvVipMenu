fx_version 'adamant'

game 'gta5'

description 'Vip menu for FiveM compatible with esx_skin.'

author 'Av3nirr'

client_scripts {
    "client/*",
}

server_scripts {
    "server/*",
    '@mysql-async/lib/MySQL.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}
lua54 'yes'