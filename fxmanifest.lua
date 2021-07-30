fx_version 'cerulean'
 
game 'gta5'
 
lua54 'yes'
 
description 'A polyzone gym created by Entity Evolution'
 
version '0.0.1'
 
client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'config/config_cl.lua',
    'client/*.lua'
}
 
dependency 'PolyZone'