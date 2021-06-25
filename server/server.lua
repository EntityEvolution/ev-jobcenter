ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ev:applyJob', function(whitelisted, jobName, webhook, title, message, image, thumbnail, color)
    local source <const> = source
    xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if whitelisted then
            if title == nil then title = 'Not Found' end
            if message == nil then message = 'None' end
            print('Whitelisted Job: ' .. jobName)
            sendDiscord(webhook,
            '**Job Center Information | ' .. title .. '**',
            "__Player Information__\n ```Player ID: " .. source .. "\nPlayer Name: " .. GetPlayerName(source) .. 
            "```\n __Job Information__\n```Character Name: " .. xPlayer.getName() .. "\nCharacter Job: " .. xPlayer.getJob().label ..
            "\nCharacter Job Rank: " .. xPlayer.getJob().grade_label .. "\nCharacter Sex: "
            .. xPlayer.get('sex') .. "\nCharacter DOB: " .. xPlayer.get('dateofbirth') .. "\nCharacter Height: " .. xPlayer.get('height') ..
            "in```" .. "\n __About__\n```Reason: " .. message .. "```",
            image,
            thumbnail,
            color)
        else
            xPlayer.setJob(jobName, 0)
            print(jobName)
        end
    else
        print(source)
    end
end)

function sendDiscord(webhook, title, message, image, thumbnail, color)
    if webhook == nil then webhook = Config.defaultWebhook end
    if message == nil then message = Config.defaultMessage end
    if title == nil then title = Config.defaultTitle end
    if image == nil then image = Config.defaultImage end
    if thumbnail == nil then thumbnail = Config.defaultThumbnail end
    if color == nil then color = Config.defaultColor end
    local embeds = {
        {
            ["title"] = title,
            ["thumbnail"] = {
                ["url"] = thumbnail, 
            },
            ["image"] ={
                ["url"] = image,
            },
            ["color"] = color,
            ["description"]  = message
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = username, embeds = embeds, avatar_url = avatar_url}), { ['Content-Type'] = 'application/json' })
end