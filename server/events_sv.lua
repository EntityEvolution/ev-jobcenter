stateEsx =  GetResourceState('es_extended') == 'started' or GetResourceState('extendedmode') == 'started'
stateQbus =  GetResourceState('qb-core') == 'started'

local stateEsx = stateEsx
local stateQbus = stateQbus

if stateEsx then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if stateQbus then
    QBCore = nil
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
end

RegisterNetEvent('ev:applyJob', function(whitelisted, jobName, grade, webhook, title, message, image, thumbnail, color, location)
    local source <const> = source
    if stateEsx then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            if whitelisted then
                if ESX.DoesJobExist(jobName, grade) then
                    if xPlayer.getJob().name ~= jobName then
                        if title == nil then title = 'Not Found' end
                        if message == nil then message = 'None' end
                        sendDiscord(webhook,
                        '**Job Center Information | ' .. title .. '**',
                        "__Player Information__\n ```Player ID: " .. source .. "\nPlayer Name: " .. GetPlayerName(source) ..
                        "```\n __Job Information__\n```Character Name: " .. xPlayer.getName() .. "\nCharacter Job: " .. xPlayer.getJob().label ..
                        "\nCharacter Job Rank: " .. xPlayer.getJob().grade_label .. "\nCharacter Sex: "
                        .. xPlayer.get('sex') .. "\nCharacter DOB: " .. xPlayer.get('dateofbirth') .. "\nCharacter Height: " .. xPlayer.get('height') ..
                        "in```" .. "\n __About__\n```Reason: " .. message .. "\nLocation: " .. location .. "```",
                        image,
                        thumbnail,
                        color)
                        return
                    else
                        return
                    end
                end
            else
                if ESX.DoesJobExist(jobName, grade) then
                    if xPlayer.getJob().name ~= jobName then
                        xPlayer.setJob(jobName, grade)
                    else
                        return
                    end
                end
            end
        else
            return print(source)
        end
    elseif stateQbus then
        if whitelisted then
            if checkJob then
                if xPlayer.getJob().name ~= jobName then
                    if title == nil then title = 'Not Found' end
                    if message == nil then message = 'None' end
                    sendDiscord(webhook,
                    '**Job Center Information | ' .. title .. '**',
                    "__Player Information__\n ```Player ID: " .. source .. "\nPlayer Name: " .. GetPlayerName(source) ..
                    "```\n __Job Information__\n```Character Name: " .. xPlayer.getName() .. "\nCharacter Job: " .. xPlayer.getJob().label ..
                    "\nCharacter Job Rank: " .. xPlayer.getJob().grade_label .. "\nCharacter Sex: "
                    .. xPlayer.get('sex') .. "\nCharacter DOB: " .. xPlayer.get('dateofbirth') .. "\nCharacter Height: " .. xPlayer.get('height') ..
                    "in```" .. "\n __About__\n```Reason: " .. message .. "\nLocation: " .. location .. "```",
                    image,
                    thumbnail,
                    color)
                    return
                else
                    return
                end
            else
                if ESX.DoesJobExist(jobName, grade) then
                    if xPlayer.getJob().name ~= jobName then
                        xPlayer.setJob(jobName, grade)
                    else
                        return print(source .. ' already has the job')
                    end
                end
            end
        end
    else
        return print('No framework found')
    end
end)

RegisterNetEvent('ev:sendAllAdmins', function(prevent, location)
    if prevent then
        if stateEsx then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if checkPerms(xPlayer) then
                    TriggerClientEvent('chat:addMessage', xPlayers[i], {
                        color = { 255, 0, 0},
                        multiline = true,
                        args = {"Job Center Help", "The id " .. source .. " requested help at the job center named: " .. location}
                      })                      
                end
            end
        elseif stateQbus then

            return
        else
            return print('No framework found')
        end
    else
        print('Hacker')
    end
end)

RegisterNetEvent('ev:sendAdminEndpoint', function(prevent, subject, discord, topic, description)
    local source <const> = source
    if prevent then
        local id = getIdentifiers(source)
        sendDiscord(Config.adminWebhook, 
        '**Bugs Form Information | Subject: ' .. subject .. "**", 
        "__Player Information__\n ```Player ID: " .. source .. "\nPlayer Name: " .. GetPlayerName(source) ..
        "```\n__About__\n```Discord Name: " .. discord .. "\nTopic: " .. topic .. "\nDescription: " .. description .. "```" ..
        "\n __Player identifiers__\n```License: "  .. id.license .. 
        "\nLicense2: ".. id.license2 .. "\nXbl: " .. id.xbl .. "\nLive: " .. id.live .. "\nDiscord: " .. id.discord .. "\nSteamHex: " ..
        id.steam .. "\nFivem: " .. id.fivem .. "\nIP: " .. id.ip .. "```", 
        image,
        thumbnail,
        color)
    else
        print('Hacker most likely')
    end
end)