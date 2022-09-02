fx_version 'adamant'
game 'gta5'

author 'Thommie'
description 'Copper Cutting Script'

lua54 'yes'
escrow_ignore {
    'config.lua',
    'cl_copper.lua',
    'sv_copper.lua'
}

shared_script 'config.lua'
client_script 'cl_copper.lua'
server_script 'sv_copper.lua'

dependencies {
    'qb-target',
}
