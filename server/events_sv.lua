stateVrp = GetResourceState('es_extended') == 'Started'
stateEsx = GetResourceState('vrp') == 'Started'

local stateVrp = stateVrp
local stateEsx = stateEsx

if stateEsx then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end


RegisterNetEvent('ev:applyJob', function(whitelisted, jobName, grade, title, message, image, thumbnail, color, location)
    local source <const> = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if stateEsx then
        if xPlayer then
            if whitelisted then
                if ESX.DoesJobExist(jobName, grade) then
                    if xPlayer.getJob().name ~= jobName then
                        if title == nil then title = 'Not Found' end
                        if message == nil then message = 'None' end
                        print('Whitelisted Job: ' .. jobName)
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
                        print(jobName)
                        print(xPlayer.getJob().name)
                        return
                    end
                end
            else
                if ESX.DoesJobExist(jobName, grade) then
                    if xPlayer.getJob().name ~= jobName then
                        xPlayer.setJob(jobName, grade)
                        print(jobName)
                    else
                        print(jobName)
                        print(xPlayer.getJob().name)
                        return
                    end
                end
            end
        else
            return print(source)
        end
    elseif stateVrp then

    else
        return print('No framework found')
    end
end)

RegisterNetEvent('ev:sendAllAdmins', function(prevent)
    if prevent then
        if stateEsx then
            local xPlayers = ESX.GetPlayers()
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if checkPerms(xPlayer) then
                    print(xPlayer)
                end
            end
        elseif stateVrp then

        else
            return print('No framework found')
        end
    else
        print('Hacker')
    end
end)

RegisterNetEvent('ev:sendAdminEndpoint', function(prevent, subject, discord, title, description)
    if prevent then
        sendDiscord(webhook, )
    else
        print('Hacker')
    end
end)