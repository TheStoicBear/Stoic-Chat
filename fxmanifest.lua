fx_version 'adamant'
games { 'gta5' }
dependency 'chat'
lua54 'yes'
version '2.4.6'
author 'TheStoicBear'
description 'Stoic-Chat'

ui_page "source/ui/index.html"

client_scripts {
    'source/cl_chat.lua',
    'source/rp/c_hr.lua',
    'source/rp/c_ufind.lua',
	'source/randomizer/*.lua',
    'source/911/client.lua',
    'source/panic/client.lua',
    'source/fines/client.lua',
	'source/towjob/client.lua',
    'source/utils/client.lua',
    'source/id/c_id.lua',
    'source/hud/client.lua',
    'source/medical/client.lua',
    'source/3dID/client.lua',
    'source/playerlist/client.lua'
}

server_scripts {
    'source/sv_chat.lua',
    'source/rp/s_hr.lua',
    'source/rp/s_ufind.lua',
    'source/rp/s_wdif.lua',
    'source/911/server.lua',
    'source/panic/server.lua',
    'source/notifications/server.lua',
    'source/fines/server.lua',
    'source/utils/server.lua',
	'source/tags/s_tags.lua',
	'source/feed/s_chat.lua',
	'source/feed/s_feed.lua',
	'source/feed/staffcomands.lua',
	'source/discord/hooks.lua',
	'source/towjob/server.lua',
    'source/id/s_id.lua',
    'source/medical/server.lua',
    'source/creatorcodes/server.lua',
    'source/3dID/server.lua',
    'source/playerlist/server.lua'
}

shared_scripts {
    "@ND_Core/init.lua",
    "@ox_lib/init.lua",
    'config/c_3did.lua',
    'config/c_main.lua',
    'config/c_medical.lua',
    'config/c_playerlist.lua'
} 

files {
    'html/style.css'
}

escrow_ignore {
    'config/c_3did.lua',
    'config/c_main.lua',
    'config/c_medical.lua',
    'config/c_playerlist.lua'
}


chat_theme "Stoic-Chat" {
    styleSheet = 'html/style.css',
}