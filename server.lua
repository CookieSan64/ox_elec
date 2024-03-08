if not lib.checkDependency('ox_lib', '3.0.0', true) then return end
if not lib.checkDependency('ox_inventory', '2.28.4', true) then return end

-- Fonction pour vérifier si un modèle de véhicule est électrique
function IsElectricModel(model)
    return Config.electricModels[model] or false
end

---@param playerId number
---@param price number
---@return boolean?
local function defaultPaymentMethod(playerId, price)
    local success = ox_inventory:RemoveItem(playerId, 'money', price)
    if success then return true end
    local money = ox_inventory:GetItem(playerId, 'money', false, true)
    TriggerClientEvent('ox_lib:notify', playerId, {
        type = 'error',
        description = ('Vous n\'avez pas assez d\'argent. Il vous manque $%s.'):format(price - money)
    })
    return false
end

local payMoney = defaultPaymentMethod

exports('setPaymentMethod', function(fn)
    payMoney = fn or defaultPaymentMethod
end)

RegisterNetEvent('ox_elec:pay')
AddEventHandler('ox_elec:pay', function(price, fuel, netid)
    assert(type(price) == 'number', ('Le prix doit être un nombre, reçu %s'):format(type(price)))
    if not payMoney(source, price) then return end
    fuel = math.floor(fuel)
    setFuelState(netid, fuel)
    TriggerClientEvent('ox_lib:notify', source, {
        type = 'success',
        description = ('Vous avez rechargé votre véhicule avec %s unités pour $%s.'):format(fuel, price)
    })
end)

-- Déclencher l'événement pour démarrer le chargement du véhicule
RegisterServerEvent('ox_elec:startCharging')
AddEventHandler('ox_elec:startCharging', function(vehicle)
    StartChargingVehicle(source, vehicle)
end)

-- Déclencher l'événement pour arrêter le chargement du véhicule
RegisterServerEvent('ox_elec:stopCharging')
AddEventHandler('ox_elec:stopCharging', function(vehicle)
    StopChargingVehicle(source, vehicle)
end)

-- Vérifier si un véhicule est électrique lorsqu'il est créé
AddEventHandler('entityCreated', function(vehicle)
    if IsElectricModel(GetEntityModel(vehicle)) then
        TriggerClientEvent('ox_elec:setElectricVehicle', -1, vehicle)
    end
end)

-- Vérifier si un véhicule est électrique lorsque le joueur entre dans un véhicule
AddEventHandler('playerEnteredVehicle', function(vehicle, seat)
    if seat == -1 and IsElectricModel(GetEntityModel(vehicle)) then
        TriggerClientEvent('ox_elec:setElectricVehicle', source, vehicle)
    end
end)

-- Vérifier si un véhicule est électrique lorsque le joueur change de siège dans un véhicule
AddEventHandler('playerChangedSeat', function(vehicle, newSeat, oldSeat)
    if newSeat == -1 and IsElectricModel(GetEntityModel(vehicle)) then
        TriggerClientEvent('ox_elec:setElectricVehicle', source, vehicle)
    end
end)

-- Vérifier si un véhicule est électrique lorsque le joueur sort d'un véhicule
AddEventHandler('playerLeaveVehicle', function(vehicle, seat)
    if seat == -1 and IsElectricModel(GetEntityModel(vehicle)) then
        TriggerClientEvent('ox_elec:setElectricVehicle', source, nil)
    end
end)
