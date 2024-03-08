if not lib.checkDependency('ox_lib', '3.0.0', true) then return end
if not lib.checkDependency('ox_inventory', '2.28.4', true) then return end

local pumpModel = 3258418592 -- Modèle de la pompe de recharge

-- Fonction pour créer une pompe de recharge
local function createPump(coords)
    local pumpObject = CreateObject(pumpModel, coords.x, coords.y, coords.z, true, false, true)
    SetEntityAsMissionEntity(pumpObject, true, true)
    FreezeEntityPosition(pumpObject, true)
    return pumpObject
end

-- Créer les pompes de recharge
for _, station in pairs(Config.Stations or {}) do
    for _, pumpCoords in ipairs(station.pumps or {}) do
        createPump(pumpCoords)
    end
end

AddTextEntry('ox_elec_station', "Station de recharge électrique")

local function createBlip(station)
    local blip = AddBlipForCoord(station.x, station.y, station.z)
    SetBlipSprite(blip, 354)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 81)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('ox_elec_station')
    AddTextComponentSubstringPlayerName('Station de recharge électrique')
    EndTextCommandSetBlipName(blip)
    return blip
end

-- Créer les blips pour les stations de recharge
for station, pumps in pairs(Config.Stations or {}) do
    createBlip(station)
end

-- Boucle principale pour gérer les interactions avec les stations de recharge
CreateThread(function()
    local blips = {}         -- Tableau pour stocker les blips des stations de recharge
    local isCharging = false -- Variable pour suivre si le joueur est en train de recharger

    while true do
        Citizen.Wait(500)
        local playerCoords = GetEntityCoords(PlayerPedId())

        -- Vérifier la proximité des stations de recharge
        for station, pumps in pairs(Config.Stations or {}) do
            local stationDistance = #(playerCoords - station)

            if stationDistance < 60 then
                if not blips[station] then
                    blips[station] = createBlip(station)
                end

                -- Gérer les interactions avec les pompes de recharge
                for i = 1, #pumps do
                    local pump = pumps[i]
                    local pumpDistance = #(playerCoords - pump)

                    if pumpDistance < 3 then
                        -- Afficher les instructions pour recharger
                        DisplayHelpTextThisFrame('Appuyer sur E pour faire le plein', false)

                        -- Attendre que le joueur appuie sur la touche pour recharger
                        if IsControlJustPressed(0, 38) then
                            if not isCharging then
                                StartChargingVehicle()
                                isCharging = true
                            end
                        end
                    end
                end
            end
        end

        -- Supprimer les blips des stations de recharge non proches du joueur
        for station, blip in pairs(blips) do
            local distance = #(playerCoords - station)
            if distance > 60 then
                RemoveBlip(blip)
                blips[station] = nil
            end
        end
    end
end)

local ox_inventory = exports.ox_inventory

---@return number
local function defaultMoneyCheck()
    return ox_inventory:Search('count', 'money')
end

local getMoneyAmount = defaultMoneyCheck

exports('setMoneyCheck', function(fn)
    getMoneyAmount = fn or defaultMoneyCheck
end)

-- Fonction pour démarrer le chargement du véhicule
function StartChargingVehicle()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if IsElectricModel(GetEntityModel(vehicle)) then
        TriggerServerEvent('ox_elec:startCharging', vehicle)
    else
        TriggerEvent('chatMessage', '^1Erreur: ^7Ce véhicule n\'est pas électrique.')
    end
end

-- Fonction pour arrêter le chargement du véhicule
function StopChargingVehicle()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if IsElectricModel(GetEntityModel(vehicle)) then
        TriggerServerEvent('ox_elec:stopCharging', vehicle)
    end
end

-- Boucle principale
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        if electricVehicle then
            local chargeLevel = GetVehicleChargeLevel(GetVehiclePedIsIn(PlayerPedId(), false))

            -- Vérifier si le niveau de charge est inférieur à un certain seuil et commencer le chargement si nécessaire
            if chargeLevel < Config.MaxBatteryCapacity then
                StartChargingVehicle()
            else
                StopChargingVehicle()
            end
        end
    end
end)