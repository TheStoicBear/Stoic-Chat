
-- /announce command
RegisterCommand('announce', function(source, args, rawCommand)
    local player = source
    local message = table.concat(args, ' ')

    -- Check if the player has the required Ace Permission (Config.StaffChat)
    if IsPlayerAceAllowed(player, Config.StaffChat) then
        -- Broadcast the system message to all players
        sendSystemMessageToAll(message)
    else
        -- Inform the player that they don't have permission
        sendErrorMessage(player, 'Insufficient permissions to use /announce.')
    end
end, false)
-- /kick command
RegisterCommand('kick', function(source, args, rawCommand)
    local player = source
    local target = tonumber(args[1])
    local reason = table.concat(args, ' ', 2)

    -- Check if the player has the required Ace Permission (Config.StaffChat)
    if IsPlayerAceAllowed(player, Config.StaffChat) then
        -- Check if a valid target player ID is provided
        if target then
            -- Kick the player with a reason
            kickPlayer(player, target, reason)
        else
            -- Inform the player that they don't have permission
            sendErrorMessage(player, 'Invalid player ID. Usage: /kick [playerId] [reason]')
        end
    else
        -- Inform the player that they don't have permission
        sendErrorMessage(player, 'Insufficient permissions to use /kick.')
    end
end, false)
-- /warn command
RegisterCommand('warn', function(source, args, rawCommand)
    local player = source
    local target = tonumber(args[1])
    local message = table.concat(args, ' ', 2)

    -- Check if the player has the required Ace Permission (Config.StaffChat)
    if IsPlayerAceAllowed(player, Config.StaffChat) then
        -- Check if a valid target player ID is provided
        if target then
            -- Warn the player with a custom message
            warnPlayer(player, target, message)
        else
            -- Inform the player that they don't have permission
            sendErrorMessage(player, 'Invalid player ID. Usage: /warn [playerId] [message]')
        end
    else
        -- Inform the player that they don't have permission
        sendErrorMessage(player, 'Insufficient permissions to use /warn.')
    end
end, false)

-- Register the /clearchat command
RegisterCommand('clearchat', function(source, args, rawCommand)
    local player = source

    -- Check if the player has the required Ace Permission (Config.StaffChat)
    if IsPlayerAceAllowed(player, Config.StaffChat) then
        -- Trigger an event to clear the chat
        TriggerClientEvent('chat:clear', -1)
        sendSuccessMessage(player, 'Chat cleared by admin.')
    else
        -- Inform the player that they don't have permission
        sendErrorMessage(player, 'Insufficient permissions to use /clearchat.')
    end
end, false)


-- Function to kick a player with a reason
function kickPlayer(player, target, reason)
    DropPlayer(target, reason)
    sendSystemMessageToAll(GetPlayerName(target) .. ' has been kicked by ' .. GetPlayerName(player) .. ' for ' .. reason)
end

-- Function to warn a player with a custom message
function warnPlayer(player, target, message)
    sendWarningMessage(target, 'You have been warned by ' .. GetPlayerName(player) .. ': ' .. message)
end
