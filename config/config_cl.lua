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