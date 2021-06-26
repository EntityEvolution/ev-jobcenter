local Wait = Wait
local PlayerPedId = PlayerPedId
local GetEntityCoords = GetEntityCoords

local isOpen = false
local insidePoly, startNoti = false, false

local dict, anim = 'amb@world_human_seat_wall_tablet@female@base', 'base'
local model = GetHashKey('prop_cs_tablet')

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

CreateThread(function()
    while true do
        if isOpen then
            local min, hours, day, month, monthNum = GetClockMinutes(), GetClockHours(), GetClockDayOfWeek(), GetClockMonth(), GetClockDayOfMonth()
            local basedHour = 0
            local timeText = 'AM'

            if (hours <= 11) then
                basedHour = hours
                timeText = 'AM'
            elseif (hours >= 12) then
                basedHour = hours - 12
                timeText = 'PM'
            end
            local time = tostring(basedHour .. ':' .. min .. ' ' .. timeText)
            SendNUIMessage({
                action = "time",
                time = time
            })
        end
        Wait(1000)
    end
end)

-- Callbacks
RegisterNUICallback('close', function()
    if isOpen then
        isOpen = false
        SetNuiFocus(false, false)
        local location = stNoti()
        --TriggerServerEvent('ev:applyJob', true, 'police', nil, 'LSPD', 'I would be a good member for the team.', '', '', 123456, location)
        stopAnim()
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
            startAnim()
        end
    end
end)

RegisterKeyMapping(Config.openCommand, Config.openDesc, 'keyboard', Config.openKey)

-- Polyzones
local jobCenter <const> = PolyZone:Create({
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

-- Polyzones check
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

function ShowFloatingHelpNotification(message, coords)
    AddTextEntry('FloatingHelpNotification', message)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

function stNoti()
    local stName = 'Not found'
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    local stHash = GetStreetNameAtCoord(x, y, z)
    if (stHash ~= nil) then
        stName = GetStreetNameFromHashKey(stHash)
        return stName
    end
end

function startAnim()
    local ped = PlayerPedId()
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(10)
	end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    
    local bone = GetPedBoneIndex(ped, 57005)
    prop = CreateObject(model, 1.0, 1.0, 1.0, 1, 1, 0)
	if isUnarmed then
		SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
        AttachEntityToEntity(prop, ped, bone, 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, 1, 1, 0, 1, 1, 1)
	else
        AttachEntityToEntity(prop, ped, bone, 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, 1, 1, 0, 1, 1, 1)
	end
	TaskPlayAnim(ped, dict, anim, 2.0, -1, -1, 50, 0, false, false, false)
end

function stopAnim()
    if (prop ~= 0) then
        local ped = PlayerPedId()
		DeleteEntity(prop)
		StopAnimTask(ped, dict, anim, 1.0)
		prop = 0
    end
end