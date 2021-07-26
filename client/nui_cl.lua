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