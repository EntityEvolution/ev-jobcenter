local Wait = Wait
local PlayerPedId = PlayerPedId
local GetEntityCoords = GetEntityCoords

local isOpen = false
local insidePoly = false
local startNoti = false

ESX = nil
CreateThread(function()
	while (ESX == nil) do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(250)
	end
end)

CreateThread(function()
    while isOpen do
        DisableControlAction(0, 322, true)
    end
end)

-- Callbacks
RegisterNUICallback('close', function()
    if isOpen then
        isOpen = false
        SetNuiFocus(false, false)
    end
end)

-- Commands
RegisterCommand(Config.openCommand, function()
    if insidePoly then
        if not isOpen then
            isOpen = true
            SendNUIMessage({
                action = 'open'
            })
            SetNuiFocus(true, true)
        end
    end
end)

RegisterKeyMapping(Config.openCommand, Config.openDesc, 'keyboard', Config.openKey)

-- Polyzones
local jobCenter = PolyZone:Create({
    vector2(-260.07339477539, -967.36651611328),
    vector2(-265.25463867188, -969.923828125),
    vector2(-269.91510009766, -960.05834960938),
    vector2(-265.19049072266, -957.45562744141)
}, {
    name="jobcenter",
    minZ = 30.223127365112,
    maxZ = 32.02501373291,
    lazyGrid = true,
    debugPoly = false
})
  
jobCenter:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        if not insidePoly then
            insidePoly = true
            startNoti = true
            showNoti()
        end
    else
        if insidePoly then
            insidePoly = false
            showNoti()
        end
    end
end)

-- Functions
function showNoti()
    if insidePoly then
        if Config.use3d then
            CreateThread(function()
                while insidePoly do
                    local coords = GetEntityCoords(PlayerPedId())
                    ShowFloatingHelpNotification(Config.openText, vec3(coords.x, coords.y, coords.z + 1))
                    Wait(7)
                end
            end)
        elseif Config.useNormal then
            if startNoti then
                ESX.ShowHelpNotification(Config.openText)
            end
        elseif Config.useTnotify then
            if startNoti then
                exports['t-notify']:Persist({
                    id = 'jobcenter',
                    step = 'start',
                    options = {
                        style = 'info',
                        title = Config.tnotifyTitle,
                        message = Config.tnotifyMessage,
                        sound = Config.tnotifySound
                    }
                })
            end
        end
    else
        if startNoti then
            startNoti = false
            if Config.useTnotify then
                exports['t-notify']:Persist({
                    id = 'jobcenter',
                    step = 'end'
                })
            end
        end
    end
end

ShowFloatingHelpNotification = function(message, coords)
    AddTextEntry('FloatingHelpNotification', message)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end