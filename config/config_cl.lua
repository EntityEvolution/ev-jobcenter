Config = {}

-- Opening job center
Config.openCommand = 'jobcenter'
Config.openDesc = 'Open the jobcenter menu'
Config.openKey = 'E' -- Key to open job center

-- Notification Types and Message
Config.openText = '~r~' .. Config.openKey .. '~w~ | Job Center'

Config.useNormal = false -- Basic native notification
Config.useFloating = true  -- Basic Floating text

Config.useTnotify = false
Config.tnotifyTitle = 'Job Center'
Config.tnotifyMessage = 'E | Job Center'
Config.tnotifySound = false

-- Wait times
Config.waitSpawn = 3000 -- Set data back in NUI
Config.waitDate = 1000 -- Update time in the jobcenter date (1000 = 1sec)

-- Blips
Config.enableBlips = true -- Show blips
Config.Blips = {
    nearbyBlips = true, -- Show only the closest one
    nearbyDistance = 100, -- How close to change to other one
    blipColor = 1, -- Color of blip https://docs.fivem.net/docs/game-references/blips/
    blipSprite = 1, -- Type of blip
    blipSize = 1.0, -- Size of blip
    blipDisplay = 2, -- https://docs.fivem.net/natives/?_0x9029B2F3DA924928
    blipRefresh = 1000,
    blipLocations = {
        {label = "Jobcenter", coords = vec3(-264.724, -964.472, 31.223)},
        {label = "Jobcenter", coords = vec3(-1044.83, -2749.87, 21.363)},
        {label = "Jobcenter", coords = vec3(-544.552, -205.950, 38.091)},
        {label = "Jobcenter", coords = vec3(-248.384, 6331.844, 32.426)}
    }
}