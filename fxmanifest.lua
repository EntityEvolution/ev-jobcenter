fx_version 'cerulean'

game 'gta5'

lua54 'yes'

description 'A simple job center created by Entity Evolution'

version '0.0.1'

client_scripts {
    'config/config_cl.lua',
    '@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
    'client/*.lua'
}

server_scripts {
    'config/config_sv.lua',
    'server/*.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'json/*.json',
    'html/img/tablet/*.png',
    'html/img/tablet/*.jpg',
    'html/img/backgrounds/*.png',
    'html/img/backgrounds/*.jpg',
    'html/img/apps/*.png',
    'html/fonts/*.ttf',
    'html/css/*.css',
    'config/config.js',
    'html/js/*.js'
}

dependency 'PolyZone'
