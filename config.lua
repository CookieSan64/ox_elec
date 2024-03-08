Config = {}

-- Touches à désactiver pendant le ravitaillement
Config.disabledKeys = { 0, 22, 23, 24, 29, 30, 31, 37, 44, 56, 82, 140, 166, 167, 168, 170, 288, 289, 311, 323 }

-- Prix de charge par unité d'énergie (par exemple, par kWh)
Config.ChargePricePerUnit = 2

-- Capacité maximale de la batterie pour les véhicules électriques (en unités d'énergie)
Config.MaxBatteryCapacity = 100

-- Taux de décharge de la batterie lors de l'utilisation du véhicule (par exemple, en unités d'énergie par seconde)
Config.DischargeRate = 1

-- Taux de charge de la batterie lors de la recharge (par exemple, en unités d'énergie par seconde)
Config.ChargeRate = 2

-- Temps de charge minimum requis pour commencer à facturer le joueur (en secondes)
Config.MinChargeTimeForPayment = 1

-- Coefficient pour calculer le coût total de charge en fonction du temps de charge (par exemple, facteur de 1.5 signifie que le coût total est 1.5 fois le prix normal)
Config.ChargeCostMultiplier = 1.5

-- Message affiché lorsque le joueur commence à charger le véhicule
Config.ChargingStartedMessage = "Chargement du véhicule en cours..."

-- Message affiché lorsque le joueur arrête de charger le véhicule
Config.ChargingStoppedMessage = "Arrêt du chargement du véhicule."

-- Modèles de véhicules électriques
Config.electricModels = {
    ['airtug'] = true,
    ['neon'] = true,
    ['raiden'] = true,
    ['caddy'] = true,
    ['caddy2'] = true,
    ['caddy3'] = true,
    ['cyclone'] = true,
    ['dilettante'] = true,
    ['dilettante2'] = true,
    ['surge'] = true,
    ['tezeract'] = true,
    ['imorgon'] = true,
    ['khamelion'] = true,
    ['voltic'] = true,
    ['iwagen'] = true,
    ['coureuse'] = true,
    ['buffalo5'] = true,
    ['inductor'] = true,
    ['inductor2'] = true,
    ['vivanite'] = true,
}

-- ChargeRate par défaut pour toutes les stations
Config.DefaultChargeRate = 5 -- Taux de charge de la station (en unités d'énergie par seconde)

-- MaxCapacity par défaut pour toutes les stations
Config.DefaultMaxCapacity = 10000 -- Capacité maximale de la station (en unités d'énergie)

Config.pumpModel = 3258418592     -- Remplacez "prop_name_here" par le nom du modèle de la pompe de recharge

-- Liste des stations de recharge avec leurs coordonnées
Config.Stations = {}

-- Coordonnées des stations avec valeurs par défaut
local stationCoordinates = {
    -- Sandy Shores
    { 1943.879, 3770.068, 32.36607 },
    { 1946.807, 3771.705, 32.15898 },
    { 1949.988, 3773.495, 32.16804 },
    { 1953.338, 3775.447, 32.36996 },
    { 1956.471, 3777.257, 32.16774 },
    { 1960.325, 3779.482, 32.35299 },
    { 1963.724, 3781.482, 32.35133 },
    { 1971.158, 3768.831, 32.36246 },
    { 1967.608, 3766.765, 32.36274 },
    { 1963.83,  3764.608, 32.22875 },
    { 1960.561, 3762.719, 32.19764 },
    { 1957.174, 3760.768, 32.19991 },
    { 1954.168, 3759.064, 32.36561 },
    { 1951.174, 3757.336, 32.37903 },
}

-- Initialisation des stations avec les valeurs par défaut
for _, coords in ipairs(stationCoordinates) do
    Config.Stations[vector3(coords[1], coords[2], coords[3])] = {
        chargeRate = Config.DefaultChargeRate,
        maxCapacity = Config.DefaultMaxCapacity,
        pumpModel = Config.pumpModel -- Spécifiez le modèle de la pompe de recharge pour toutes les stations
    }
end


--{2591.786, 450.3466, 107.457138},
--{-2554.159, 2319.495, 32.06378},
--{200.02684, 6632.571, 30.5015163},
--{-1433.94421, -264.217438, 45.26844},
--{164.591812, -1558.0481, 28.2605133},
--{833.8562, -1028.729, 26.1401272},
--{1194.58923, -1402.895, 34.36423},
--{1708.90125, 6424.09326, 31.76174},
--{1177.59937, -313.327271, 68.17966},
--{-341.012634, -1474.0542, 29.76258},
--{-1787.93518, 814.477234, 137.495148},
--{640.317444, 259.9253, 102.296425},
--{-720.571045, -913.1754, 18.0139141},
--{-2075.55176, -331.93042, 12.3162136},
--{-53.7342033, -1769.77527, 28.123745},
--{-534.755, -1217.60559, 17.4567051},
--{287.4449, -1275.55676, 28.439579},
--{42.9389877, 2794.21313, 56.8763046},
--{1694.2417, 4920.897, 41.2319374},
--{1042.12012, 2674.40283, 38.7002525},
--{2675.92969, 3270.2793, 54.410305},
--{287.4553, -1270.21472, 28.4383774},
--{2591.786, 446.763, 107.457138},
--{2591.786, 443.490784, 107.457138},
--{196.624771, 6633.478, 30.5015163},