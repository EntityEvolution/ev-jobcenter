fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'A simple ESX job center created by Entity Evolution'

version '0.0.1'

client_scripts {
    'config/config.lua',
    '@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'config/config.json',
    'html/fonts/*.ttf',
    'html/css/*.css',
    'html/js/*.js'
}