local playerTags = {}

-- Event handler for displaying chat messages from players as chat bubbles
AddEventHandler('chatMessage', function(playerId, playerName, message)
    local player = NDCore.getPlayer(playerId)
    local assignedTag
    local imageUrl

    -- Check if the player has a custom tag set via KVP
    local customTagFromKVP = GetResourceKvpString('playerTag:' .. playerId)
    if customTagFromKVP and customTagFromKVP ~= '' then
        assignedTag = "[" .. customTagFromKVP .. "]"

        -- Now, you may want to check if the custom tag from KVP is still valid,
        -- for example, it matches one of the preset tags in Config.ChatTags.
        local isValidCustomTag = false
        for _, data in pairs(Config.ChatTags) do
            if customTagFromKVP == data.Tag then
                imageUrl = data.ImageUrl
                isValidCustomTag = true
                break
            end
        end

        -- If the custom tag from KVP is not valid, fallback to the default tag
        if not isValidCustomTag then
            assignedTag = nil
        end
    end

    -- If no custom tag from KVP or it's not valid, check preset tags
    if not assignedTag then
        for _, data in pairs(Config.ChatTags) do
            assignedTag = "[" .. data.Tag .. "]"
            imageUrl = data.ImageUrl
            break
        end
    end

    -- If no tag found, use the default tag
    if not assignedTag then
        assignedTag = "[" .. Config.DefaultTag.Tag .. "]"
        imageUrl = Config.DefaultTag.ImageUrl
    end

    local function_check, msg = chatblacklist(message)

    if not function_check then
        local formattedMessage = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> %s<b>%s %s</b> %s</div>', imageUrl, assignedTag, player.getData("firstname"), player.getData("lastname"), message)

        TriggerClientEvent('chat:addMessage', -1, {
            template = formattedMessage,
            args = { player.getData("firstname"), player.getData("lastname"), message }
        })
        CancelEvent()
    else
        sendErrorMessage(playerId, "Your message contains profanity.")
    end
end)

-- Event triggered when a player joins
AddEventHandler('playerConnecting', function(playerName, setKickReason)
    local playerId = tonumber(source)
    local savedTag = GetResourceKvpString('playerTag:' .. playerId)
    
    if savedTag then
        playerTags[playerId] = savedTag
    else
        playerTags[playerId] = Config.DefaultTag.ImageUrl
    end
end)

-- Command to set a custom chat tag from preset tags
RegisterCommand('settag', function(source, args)
    local playerId = source

    if #args == 0 then
        local tagList = '<div style="display: flex; flex-wrap: wrap;">'
        for _, data in pairs(Config.ChatTags) do
            if IsPlayerAceAllowed(playerId, data.Permission) then
                tagList = tagList .. string.format('<div style="width: 33.33%%; padding: 5px;"><img src="%s" width="20" height="20" style="margin-right: 5px;">%s</div>', data.ImageUrl, data.Tag)
            end
        end
        tagList = tagList .. '</div>'

        sendTagChatBubble(playerId, "Available tags:<br>" .. tagList, "chattag")  -- Use "chattag" as the messageType
        return
    end

    local chosenTag = table.concat(args, " ")

    local tagData = nil
    for _, data in pairs(Config.ChatTags) do
        if chosenTag == data.Tag then
            tagData = data
            break
        end
    end

    if tagData then
        if IsPlayerAceAllowed(playerId, tagData.Permission) then
            playerTags[playerId] = chosenTag
            SetResourceKvp('playerTag:' .. playerId, chosenTag) -- Save the selected tag for the player
            sendTagChatBubble(playerId, "Your chat tag has been set to: " .. chosenTag, "chattag")
        else
            sendTagChatBubble(playerId, "You don't have the required permission for this chat tag.", "chattag")
        end
    else
        sendTagChatBubble(playerId, "Invalid chat tag. Please choose from the available preset tags.", "chattag")
    end
end, false)

-- Function to send a chat tag message bubble
function sendTagChatBubble(playerId, message, messageType)
    local player = NDCore.getPlayer(playerId)

    if player then
        local firstname = player.getData("firstname")
        local lastname = player.getData("lastname")
        local imageUrl = playerTags[playerId] or Config.DefaultTag.ImageUrl
        local formattedMessage = getStyledMessage(messageType, message, imageUrl, firstname, lastname)
        TriggerClientEvent('chat:addMessage', playerId, { template = formattedMessage, args = {} })
    else
        print("Error: Player not found.")
    end
end
