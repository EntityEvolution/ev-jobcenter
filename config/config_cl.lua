Config = Config or {}

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

Config.Blips = {
    enabled = true,
    CloseBlips = true ,
    CenterBlips = {
        {title="Jobcenter", colour=5, id=280,x = -264.724, y = -964.472, z = 31.223},
        {title="Jobcenter", colour=5, id=280,x = -1044.83, y = -2749.87, z = 21.363},
        {title="Jobcenter", colour=5, id=280,x = -544.552, y = -205.950, z = 38.091},
        {title="Jobcenter", colour=5, id=280,x = -248.384, y = 6331.844, z = 32.426}

    }
}