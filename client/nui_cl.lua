local Wait = Wait
local PlayerPedId = PlayerPedId
local GetEntityCoords = GetEntityCoords
local GetStreetNameAtCoord = GetStreetNameAtCoord

local isOpen = false
local insidePoly, startNoti = false, false

local dict, anim = 'amb@world_human_seat_wall_tablet@female@base', 'base'
local model = GetHashKey('prop_cs_tablet')

CreateThread(function()
    while isOpen do
        DisableControlAction(0, 322, true)
    end
end)

CreateThread(function()
    while true do
        if isOpen then
            local min, hours, day, month, dayText = GetClockMinutes(), GetClockHours(), GetClockDayOfMonth(), getMonthText(), getDayText()
            local basedHour = 0
            local timeText = 'AM'
            if (min <= 9) then
                min = 0 .. min
            end
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
                time = time,
                day = day,
                dayText = dayText,
                month = month
            })
        end
        Wait(Config.waitDate)
    end
end)

-- Callbacks
RegisterNUICallback('close', function(_, cb)
    if isOpen then
        isOpen = false
        SetNuiFocus(false, false)
        stopAnim()
    end
    cb({})
end)

RegisterNUICallback('getDataLocation', function(data, cb)
    if isOpen then
        print(cb)
        for i in string.gmatch(data, "%S+") do
            print(i)
        end
        local x, y
        SetNewWaypoint(x, y)
    end
    cb({})
end)

RegisterNUICallback('getDataForm', function(data, cb)
    if isOpen then
        print(data)
        print(cb)
        TriggerServerEvent('ev:sendAdminEndpoint', isOpen, data.subject, data.discord, data.issue, data.description)
    end
    cb({})
end)

RegisterNUICallback('sendAdminMessage', function(_, cb)
    if isOpen then
        TriggerServerEvent('ev:sendAllAdmins', isOpen)
    end
    cb({})
end)

RegisterNUICallback('sendFormData', function(data, cb)
    if isOpen then
        TriggerServerEvent('ev:applyJob', data.whitelist, data.job, data.grade, data.title, data.message)
    end
    cb({})
end)

RegisterNUICallback('setDataJob', function(data, cb)
    if isOpen then
        TriggerServerEvent('ev:applyJob', data.whitelist, data.job, data.grade)
    end
    cb({})
end)

-- Commands
RegisterCommand(Config.openCommand, function()
    if insidePoly then
        if not isOpen then
            if not IsEntityDead(PlayerPedId()) then
                isOpen = true
                SendNUIMessage({
                    action = 'open'
                })
                SetNuiFocus(true, true)
                startAnim()
            end
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
    if not insidePoly then
        insidePoly = true
        startNoti = true
        showNoti()
    else
        insidePoly = false
        showNoti()
    end
end)

-- Handlers
AddEventHandler('playerSpawned', function()
    if Config.useSuggestion then
	    TriggerEvent('chat:addSuggestion', '/' .. Config.openCommand, Config.openDesc, {})
    end
	Wait(Config.waitSpawn)
	SendNUIMessage({ action = 'restoreData' })
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
        if Config.useSuggestion then
            TriggerEvent('chat:addSuggestion', '/' .. Config.openCommand, Config.openDesc, {})
        end
		Wait(Config.waitResource)
		SendNUIMessage({ action = 'restoreData' })
	end
end)

-- Noti
function showNoti()
    if insidePoly then
        if Config.useFloating then
            CreateThread(function()
                while insidePoly do
                    local coords = GetEntityCoords(PlayerPedId())
                    showFloatingHelpNotification(Config.openText, vec3(coords.x, coords.y, coords.z + 1))
                    Wait(5)
                end
            end)
        elseif Config.useNormal then
            if startNoti then
                CreateThread(function()
                    while insidePoly do
                        showHelpNotification(Config.openText)
                        Wait(5)
                    end
                end)
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

-- Functions
function getDayText()
    local day = 'Mon'
    local dayNum = GetClockDayOfWeek()
    if (dayNum == 1) then
        day = day
    elseif (dayNum == 2) then
        day = 'Tue'
    elseif (dayNum == 3) then
        day = 'Wed'
    elseif (dayNum == 4) then
        day = 'Thu'
    elseif (dayNum == 5) then
        day = 'Fri'
    elseif (dayNum == 6) then
        day = 'Sat'
    elseif (dayNum == 7) then
        day = 'Sun'
    end
    return day
end

function getMonthText()
    local month = 'Jan'
    local dayMonth = GetClockMonth()
    if (dayMonth == 1) then
        month = month
    elseif (dayMonth == 2) then
        month = 'Feb'
    elseif (dayMonth == 3) then
        month = 'Mar'
    elseif (dayMonth == 4) then
        month = 'Apr'
    elseif (dayMonth == 5) then
        month = 'May'
    elseif (dayMonth == 6) then
        month = 'Jun'
    elseif (dayMonth == 7) then
        month = 'Jul'
    elseif (dayMonth == 8) then
        month = 'Aug'
    elseif (dayMonth == 9) then
        month = 'Sep'
    elseif (dayMonth == 10) then
        month = 'Oct'
    elseif (dayMonth == 11) then
        month = 'Nov'
    elseif (dayMonth == 12) then
        month = 'Dec'
    end
    return month
end

function showFloatingNotification(message, coords)
    AddTextEntry('floatingHelpNotification', message)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('floatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

function showHelpNotification(message)
    AddTextEntry('HelpNotification', message)
    DisplayHelpTextThisFrame('HelpNotification', false)
end

function startAnim()
    local ped = PlayerPedId()
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(15)
	end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(15)
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
