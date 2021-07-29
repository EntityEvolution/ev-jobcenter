local stateEsx = stateEsx
local stateVrp = stateVrp
local stateQbus = stateQbus

function checkPerms(xPlayer)
	local group = xPlayer.getGroup()
    local check
    if stateEsx then check = Config.esxRanks elseif stateVrp then check = Config.vrpRanks elseif stateQbus then check = Config.qbusRanks else return print('No framework found') end
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

function getIdentifiers(target)
    local identifiers = {
        license = 'Not found',
        xbl = 'Not found',
        live = 'Not found',
        discord = 'Not found',
        license2 = 'Not found',
        ip = 'Not found',
        fivem = 'Not found',
        steam = 'Not found'
    }

    local function match(total, identifier)
        local match = string.match(total, identifier)
        return match
    end

    local function cut(total, identifier)
        local cut = string.gsub(total, identifier, '')
        return cut
    end

    for k, v in ipairs(GetPlayerIdentifiers(target)) do
        if match(v, 'license') and not match(v, 'license2:') then
            identifiers.license = cut(v, 'license:')
        elseif match(v, 'xbl') then
            identifiers.xbl = cut(v, 'xbl:')
        elseif match(v, 'live') then
            identifiers.live = cut(v, 'live:')
        elseif match(v, 'discord') then
            identifiers.discord = cut(v, 'discord:')
        elseif match(v, 'license2') then
            identifiers.license2 = cut(v, 'license2:')
        elseif match(v, 'ip') then
            identifiers.ip = cut(v, 'ip:')
        elseif match(v, 'fivem') then
            identifiers.fivem = cut(v, 'fivem:')
        elseif match(v, 'steam') then
            identifiers.steam = cut(v, 'steam:')
        end
    end
    return identifiers
end