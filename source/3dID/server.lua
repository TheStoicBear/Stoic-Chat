local players = {}

RegisterServerEvent('displayPlayerIDs:updateClients')
AddEventHandler('displayPlayerIDs:updateClients', function()
    local player = source
    local playerData = NDCore.getPlayer(player)

    if playerData then
        local job = playerData.job
        players[player] = {
            job = job,
            displayIDs = isJobAllowed(job) -- Set default value based on the job
        }
        TriggerClientEvent('displayPlayerIDs:updateJob', player, job)
    end
end)

RegisterServerEvent('displayPlayerIDs:toggleDisplay')
AddEventHandler('displayPlayerIDs:toggleDisplay', function()
    local player = source
    if players[player] then
        players[player].displayIDs = not players[player].displayIDs
        TriggerClientEvent('displayPlayerIDs:updateDisplay', player, players[player].displayIDs)
    end
end)

function isJobAllowed(job)
    local allowedJobs = {"SASP", "LSSO"}
    for _, allowedJob in ipairs(allowedJobs) do
        if job == allowedJob then
            return true
        end
    end
    return false
end

function getPlayersInAllowedJobs()
    local playersInAllowedJobs = {}
    for player, data in pairs(players) do
        if isJobAllowed(data.job) then
            table.insert(playersInAllowedJobs, player)
        end
    end
    return playersInAllowedJobs
end
