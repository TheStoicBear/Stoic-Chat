local jailedPlayers = {}

-- Get player any identifier, available types: steam, license, xbl, ip, discord, live.
function GetPlayerIdentifierFromType(type, source)
    local identifierCount = GetNumPlayerIdentifiers(source)
    for count = 0, identifierCount do
        local identifier = GetPlayerIdentifier(source, count)
        if identifier and string.find(identifier, type) then
            return identifier
        end
    end
    return nil
end

-- send discord embed with webhook.
function sendToDiscord(name, message, color)
    local embed = {
        {
            title = name,
            description = message,
            footer = {
                icon_url = "https://cdn.discordapp.com/attachments/982855421779922944/1188734865542226081/transparent-judge-icon-law-and-justice-icon-lawyer-icon-5fc80983df3f02.3235765216069451559144.png?ex=659b9a9d&is=6589259d&hm=d8e6a2b4e41e3fffd026f9b73d1228448d993ebc6761df6543c3ae1dec7cb5a3&",
                text = "Jailer"
            },
            color = color
        }
    }
    PerformHttpRequest(Jailer.discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = "ND Jailing", embeds = embed}), {["Content-Type"] = "application/json"})
end

-- Jail the nearest player to the source
RegisterNetEvent("Jailer:jailNearestPlayer")
AddEventHandler("Jailer:jailNearestPlayer", function(time, fine, reason)
    local source = source
    local nearestPlayer = GetNearestPlayer(source)

    if nearestPlayer ~= nil then
        TriggerEvent("Jailer:jailPlayer", nearestPlayer, time, fine, reason)
    else
        print("No players nearby to jail.")
    end
end)

function GetNearestPlayer(source)
    local players = GetPlayers()

    local nearestPlayer
    local shortestDistance = math.huge

    for _, player in ipairs(players) do
        if player ~= source then
            local playerPed = GetPlayerPed(player)
            local sourcePed = GetPlayerPed(source)

            local distance = GetDistanceBetweenCoords(GetEntityCoords(playerPed), GetEntityCoords(sourcePed), true)

            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    return nearestPlayer
end


-- Jail player discord log, trigger the event on the player's client and send a message to everyone.
RegisterNetEvent("Jailer:jailPlayer", function(id, time, fine, reason)
    local player = source
    print("Received Jailer:jailPlayer event with parameters - ID:", id, "Time:", time, "Fine:", fine, "Reason:", reason)

    local useND = Config.UseND
    local dept

    if useND then
        local players = NDCore.getPlayers()
        dept = players[player].job
    else
        -- If UseND is false, get the player's Steam name for jailingOfficer/jailedPerson
        local steamName = GetPlayerName(player)
        local jailingOfficer = steamName
        local jailedPerson = steamName
        print("Steam Name:", steamName)
    end

    local character = NDCore.getPlayer(id) -- Get jailed person's character
    local jailingOfficer = character.firstname .. " " .. character.lastname .. " (" .. character.job .. ")" -- Get jailing officer's name
    local jailedPerson = character.firstname .. " " .. character.lastname -- Get jailed person's name

    for _, department in pairs(Jailer.accessDepartments) do
        if department == dept then
            jailedPlayers[GetPlayerIdentifierFromType("license", id)] = time

            if useND then
                character.deductMoney("bank", fine, id)
            end

            TriggerClientEvent("Jailer:jailPlayer", id, time)

            if GetResourceState('ModernHUD') == 'started' then
                TriggerClientEvent("Jailer:TriggerModernHUDNotify", -1, jailingOfficer, jailedPerson, time, reason)
            else
                TriggerClientEvent('chat:addMessage', -1, {
                    color = { 255, 0, 0 },
                    multiline = true,
                    args = {"[Judge]", jailingOfficer .. " jailed " .. jailedPerson .. " for " .. time .. " seconds with the reason: " .. reason}
                })
            end

            sendToDiscord("Jail Logs", "**" .. jailingOfficer .. "** jailed **" .. jailedPerson .. "** for **" .. time .. " seconds** with the reason: **" .. reason .. "**.", 1595381)
            break
        end
    end
end)




RegisterNetEvent("Jailer:updateJailing", function(time)
    local player = source
    if time == 0 then
        jailedPlayers[GetPlayerIdentifierFromType("license", player)] = nil
    else
        jailedPlayers[GetPlayerIdentifierFromType("license", player)] = time
    end
end)

-- Gets all players on the server and adds them to a table.
RegisterNetEvent("Jailer:getPlayers", function()
    local players = {}
    for _, id in pairs(GetPlayers()) do
        players[id] = "(" .. id .. ") " .. GetPlayerName(id)
    end
    TriggerClientEvent("Jailer:returnPlayers", source, players)
end)

RegisterNetEvent("Jailer:getJailTime", function()
    local player = source
    local time = jailedPlayers[GetPlayerIdentifierFromType("license", player)]
    if time then
        TriggerClientEvent("Jailer:jailPlayer", player, time)
    end
end)