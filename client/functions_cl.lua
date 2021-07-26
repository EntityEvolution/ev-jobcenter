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

function stNoti(ped)
	local coords = GetEntityCoords(ped)
	local stHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	if stHash ~= nil then
		local stName = GetStreetNameFromHashKey(stHash)
		return stName
	else
		return 'Unknown place'
	end
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