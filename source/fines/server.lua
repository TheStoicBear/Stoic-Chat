-- Additional functions for chat bubbles
function sendChatBubbles(targetPlayerId, chatBubbles, cost)


    for _, chatBubble in ipairs(chatBubbles) do
        TriggerClientEvent('chatMessage', targetPlayerId, "SYSTEM", {255, 255, 255}, chatBubble)
    end
end

-- Function to send notifications or chat messages
function SendCitationHandler(playerId, title, message, cost)
    local notificationEvent = 'SendModernHUDNotification'
    local chatEvent = 'chatMessage'

    if GetResourceState("ModernHUD") ~= "started" then
        notificationEvent = chatEvent
        title = '^3Citation Handler'
    end

    local imageUrl = "https://i.imgur.com/adrNj4A.png"  -- Replace with the actual URL
    local assignedTag = "[" .. "Dispatch" .. "]"

    local bubbleData = {
        { label = title, value = message }
    }

    local chatBubbles = {}

    for _, data in ipairs(bubbleData) do
        table.insert(chatBubbles, formatChatBubble(imageUrl, assignedTag, data.label, data.value))
    end

    sendChatBubbles(playerId, chatBubbles, cost)
end

function HasPermission(player)
    local player = NDCore.getPlayer(player)

    if player then
        -- Check if the player's job is in the callTo departments for /c911
        for _, department in ipairs(Config["/c911"].callTo) do
            if player.getData("job") == department then
                return true
            end
        end
    end

    return false
end

-- Function to deduct fines and send a message to the target player
function DeductFine(targetPlayerId, amount, reason)
    local player = NDCore.getPlayer(targetPlayerId)
    player.deductMoney("bank", amount, "Player Citations")
    local message = ' You have been fined: $' .. amount .. ' for: ' .. reason
    SendCitationHandler(targetPlayerId, "Fine:", message, amount)
end

-- Command handler function
function HandleCommand(source, args, commandSettings, eventType, notificationTitle)
    local src = source

    -- Check if the source player has permission to use the command
    if not HasPermission(src) then
        sendErrorMessage(src, "Your job prevents you from accessing this command.")
        return
    end

    local targetPlayerId = tonumber(args[1])
    local amount = tonumber(args[2])
    local reason = table.concat(args, " ", 3)
    local maxAmount = commandSettings.MaxValue
    local maxText = commandSettings.MaxText

    if targetPlayerId and amount ~= nil then
        if amount < maxAmount then
            if reason ~= "" then
                DeductFine(targetPlayerId, amount, reason)
            else
                sendErrorMessage(src, "You must include a reason for the "..eventType..".")
            end
        else
            sendErrorMessage(src, "You can only "..eventType.." up to $"..maxText)
        end
    else
        sendErrorMessage(src, "Wrong usage. /" .. commandSettings.Command .. " <id> <amount> <reason>")
    end
end

-- Commands
if Settings.Fine.Toggle then
    RegisterCommand(Settings.Fine.Command, function(source, args, rawCommand)
        HandleCommand(source, args, Settings.Fine, "fined", "Fine:")
    end, false)
end

if Settings.Ticket.Toggle then
    RegisterCommand(Settings.Ticket.Command, function(source, args, rawCommand)
        HandleCommand(source, args, Settings.Ticket, "ticketed", "Ticket:")
    end, false)
end

if Settings.Parking.Toggle then
    RegisterCommand(Settings.Parking.Command, function(source, args, rawCommand)
        HandleCommand(source, args, Settings.Parking, "issued a parking ticket", "Parking Ticket:")
    end, false)
end

if Settings.Impound.Toggle then
    RegisterCommand(Settings.Impound.Command, function(source, args, rawCommand)
        local src = source

        -- Check if the source player has permission to use the impound command
        if HasPermission(src) then
            local targetPlayerId = tonumber(args[1])
            local message = "Your vehicle has been impounded."
            SendCitationHandler(targetPlayerId, "Impound:", message, 0)  -- Assuming impound has no cost
        else
            sendErrorMessage(src, "Your job prevents you from accessing this command.")
        end
    end, false)
end


