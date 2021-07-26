local stateEsx = stateEsx
local stateVrp = stateVrp

function checkPerms(xPlayer)
	local group = xPlayer.getGroup()
    local check
    if stateEsx then check = Config.esxRanks elseif stateVrp then check = Config.vrpRanks else return print('No framework found') end
	for _, v in pairs(check) do
		if v == group then
            return true
		end
	end
	return false
end

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
    return PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = username, embeds = embeds, avatar_url = avatar_url}), { ['Content-Type'] = 'application/json' })
end
