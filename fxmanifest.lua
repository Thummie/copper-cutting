fx_version 'adamant'
game 'gta5'

author 'Thommie'
description 'Money washing system'

shared_script 'config.lua'

client_scripts {
    'client/cl_main.lua',
    'client/cl_dumpster.lua',
    'client/cl_copper.lua',
}

server_scripts {
    'server/sv_main.lua',
    'server/sv_copper.lua',
}

dependencies {
    'moon-target',
}