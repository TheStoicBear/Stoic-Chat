-- Helper function to generate HTML for the icon
    function getIconHtml(imageUrl)
        return string.format(
            '<img src="%s" style="width: 30px; height: 30px; float: left; margin-right: 10px; border-radius: 50%%;">',
            imageUrl
        )
    end
    
    -- Helper function to generate HTML for the background
    function getStyledMessage(messageType, message, imageUrl)
        local colors = {
            error = "255, 0, 0",
            success = "0, 255, 0",
            warning = "255, 165, 0",
            system = "0, 128, 128",
            chattag = "0, 0, 0"
        }
        local color = colors[messageType] or colors.error
        return string.format(
            '<div style="padding: 0.5vw; margin: 0.5vw; background: linear-gradient(to left, rgba(%s, 0.8), transparent); border-radius: 10px; transition: all 0.5s;">%s%s</div>',
            color,
            getIconHtml(imageUrl),
            message
        )
    end
    
    -- Function to send a message bubble
    function sendMessage(playerId, messageType, message)
        local imageUrl = Config[messageType .. "Icon"]
        local formattedMessage =
            getStyledMessage(
            messageType,
            string.format('<b style="color: %s;">%s:</b> %s', imageUrl, messageType, message),
            imageUrl
        )
        TriggerClientEvent("chat:addMessage", playerId, {template = formattedMessage, args = {}})
    end
    
    -- Function to send an error message bubble
    function sendErrorMessage(playerId, message)
        local imageUrl = Config.errorIcon
        local formattedMessage =
            getStyledMessage("error", string.format('<b style="color: red;">Error:</b> %s', message), imageUrl)
        TriggerClientEvent("chat:addMessage", playerId, {template = formattedMessage, args = {}})
    end
    
    -- Function to send a success message bubble
    function sendSuccessMessage(playerId, message)
        local imageUrl = Config.successIcon
        local formattedMessage =
            getStyledMessage("success", string.format('<b style="color: green;">Success:</b> %s', message), imageUrl)
        TriggerClientEvent("chat:addMessage", playerId, {template = formattedMessage, args = {}})
    end
    
    -- Function to send a warning message bubble
    function sendWarningMessage(playerId, message)
        local imageUrl = Config.warningIcon
        local formattedMessage =
            getStyledMessage("warning", string.format('<b style="color: orange;">Warning:</b> %s', message), imageUrl)
        TriggerClientEvent("chat:addMessage", playerId, {template = formattedMessage, args = {}})
    end
    
    -- Function to send a system message bubble
    function sendSystemMessage(playerId, message)
        local imageUrl = Config.systemIcon
        local formattedMessage =
            getStyledMessage("system", string.format('<b style="color: teal;">System:</b> %s', message), imageUrl)
        TriggerClientEvent("chat:addMessage", playerId, {template = formattedMessage, args = {}})
    end
    
    -- Function to send a system message bubble to all players
    function sendSystemMessageToAll(message)
        local players = GetPlayers()
    
        for _, player in ipairs(players) do
            sendSystemMessage(player, message)
        end
    end
    
    -- Test commands for different message types
    local messageTypes = {"error", "success", "warning", "system"}
    for _, messageType in ipairs(messageTypes) do
        RegisterCommand(
            "test" .. messageType,
            function(source, args, rawCommand)
                sendMessage(source, messageType, "This is a " .. messageType .. " message!")
            end,
            false
        )
    end
    
    -- Exporting the functions
    exports("sendMessage", sendMessage)
    exports("sendMessageToAll", sendMessageToAll)
    exports("sendErrorMessage", sendErrorMessage)
    exports("sendSuccessMessage", sendSuccessMessage)
    exports("sendWarningMessage", sendWarningMessage)
    exports("sendSystemMessage", sendSystemMessage)
    