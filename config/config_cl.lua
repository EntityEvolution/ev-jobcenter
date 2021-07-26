Config = Config or {}

-- Opening job center
Config.openCommand = 'jobcenter'
Config.openDesc = 'Open the jobcenter menu'
Config.openKey = 'E' -- Key to open Cityhall

-- Notification Types and Message
Config.openText = '~r~' .. Config.openKey .. '~w~ | Job Center'

Config.useNormal = false -- Basic native notification
Config.use3d = true  -- Basic 3D text

Config.useTnotify = false
Config.tnotifyTitle = 'Job Center'
Config.tnotifyMessage = 'E | Job Center'
Config.tnotifySound = true

-- Set data back
Config.waitSpawn = 3000