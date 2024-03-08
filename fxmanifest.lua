fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'ox_elec'
author 'ChouCookieSan'
description 'Transformez les rues de Los Santos en un réseau de recharge électrique avec ox_elec. Inspiré par le succès de ox_fuel, ce script apporte une alternative éco-responsable aux stations-service traditionnelles. Rechargez vos véhicules électriques à des stations spécialement conçues, gagnez en autonomie et contribuez à réduire votre empreinte carbone.'
version '1.0.0'

-- Dépendances
dependencies {
    'ox_lib',
    'ox_inventory',
}

-- Scripts partagés
shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

-- Scripts serveur
server_scripts {
    'server.lua'
}

-- Scripts client
client_scripts {
    'client.lua'
}
