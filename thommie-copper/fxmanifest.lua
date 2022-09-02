fx_version 'adamant'
game 'gta5'

author 'Thommie'
description 'Copper Cutting Script'

lua54 'yes'

shared_script 'config.lua'
client_script 'client/cl_copper.lua'
server_script 'server/sv_copper.lua'

dependencies {
    'qb-target',
}
