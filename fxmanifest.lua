fx_version 'cerulean'
game 'gta5'
author 'https://xedev.net'
description 'Drop Christmas presents around the map!'

shared_scripts {
    -- '@es_extended/imports.lua', -- Uncomment if you use ESX Legacy
    'config.lua',
}

server_scripts {
    'server/server.lua'
}

client_scripts {
    'client/client.lua'
}