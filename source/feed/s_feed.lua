-- Handle the /x command for tweets
if Config.XCommandEnabled then
    RegisterCommand('bleeter', function(source, args)
        local playerId = source
        local playerName = GetPlayerName(playerId)
        local message = table.concat(args, " ")

        if not message or message == "" then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.XIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> <b>{0}</b> <br> {1}</div>',
                args = { playerName, "Invalid tweet format. Use /bleeter Your Tweet Message" }
            })
        else
            local isVerified = false
            if IsPlayerAceAllowed(playerId, Config.VerificationAcePerm) then
                isVerified = true
            end

            local verificationMark = ""
            if isVerified then
                verificationMark = string.format('<a href="%s"><img src="%s" style="width: 20px; height: 20px; vertical-align: middle;"></a> ', Config.VerificationImage, Config.VerificationImage)
            end

            local tweetText = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.XIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> %s %s</div>', verificationMark, "@ " .. playerName .. ":" .. message)
            TriggerClientEvent('chat:addMessage', -1, {
                template = tweetText,
                args = { playerName, message }
            })

            -- Send to Discord webhook
            sendToDiscord(playerName, message, tonumber(Config.DefaultTweetColor, 16))
        end
    end, false)

    -- Add a suggestion for the /x command to the chat
    TriggerEvent('chat:addSuggestion', '/x', 'Send a tweet with a message.', {
        { name = "message", help = "The message you want to tweet." }
    })
end

-- Handle the /Lifeinvader command
if Config.LifeinvaderCommandEnabled then
    RegisterCommand('lifeinvader', function(source, args)
        local playerName = GetPlayerName(source)
        local message = table.concat(args, " ")

        if not message or message == "" then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.LifeinvaderIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> <b>{0}</b> <br> {1}</div>',
                args = { playerName, "Invalid Lifeinvader format. Use /Lifeinvader Your Market Message" }
            })
        else
			local LifeinvaderText = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.LifeinvaderIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> %s %s</div>', playerName, ":" .. message)
            TriggerClientEvent('chat:addMessage', -1, {
                template = LifeinvaderText,
                args = { playerName, message }
            })

            -- Send message to Discord webhook for /Lifeinvader
            sendLifeinvaderToDiscord(playerName, message, tonumber(Config.LifeinvaderColor, 16), "Lifeinvader", Config.LifeinvaderIconURL)
        end
    end)

    -- Add a suggestion for the /Lifeinvader command to the chat
    TriggerEvent('chat:addSuggestion', '/lifeinvader', 'Send a message to the Lifeinvader.', {
        { name = "message", help = "The message you want to send." }
    })
end

-- Handle the /news command
if Config.NewsCommandEnabled then
    RegisterCommand('news', function(source, args)
        local playerName = GetPlayerName(source)
        local message = table.concat(args, " ")

        if not message or message == "" then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.NewsIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> <b>{0}</b> <br> {1}</div>',
                args = { playerName, "Invalid news format. Use /news Your News Headline" }
            })
        else
            local newsText = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.NewsIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> %s %s</div>', playerName, ":" .. message)
            TriggerClientEvent('chat:addMessage', -1, {
                template = newsText,
                args = { playerName, message }
            })

            -- Send message to Discord webhook for /news
            sendNewsToDiscord(playerName, message, tonumber(Config.NewsColor, 16), "News", Config.NewsIconURL)
        end
    end)

    -- Add a suggestion for the /news command to the chat
    TriggerEvent('chat:addSuggestion', '/news', 'Send a news headline.', {
        { name = "message", help = "The news headline you want to send." }
    })
end

-- Handle the /Finsta command
if Config.InstaCommandEnabled then
    RegisterCommand('snapmatic', function(source, args)
        local playerName = GetPlayerName(source)
        local message = table.concat(args, " ")

        if not message or message == "" then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.InstaIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> <b>{0}</b> <br> {1}</div>',
                args = { playerName, "Invalid Finsta format. Use /snapmatic Your Instagram post" }
            })
        else
            local instaText = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.InstaIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> %s %s</div>', playerName, ":" .. message)
            TriggerClientEvent('chat:addMessage', -1, {
                template = instaText,
                args = { playerName, message }
            })

            -- Send message to Discord webhook for /Finsta
            sendInstaToDiscord(playerName, message, tonumber(Config.InstaColor, 16), "Finstagram", Config.InstaIconURL)
        end
    end)

    -- Add a suggestion for the /insta command to the chat
    TriggerEvent('chat:addSuggestion', '/snapmatic', 'Send a Finstagram Post.', {
        { name = "message", help = "The Snapmatic post you want to send." }
    })
end

-- Handle the /dot command
if Config.DotCommandEnabled then
    RegisterCommand('dot', function(source, args)
        local playerName = GetPlayerName(source)
        local message = table.concat(args, " ")

        if not message or message == "" then
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.DotIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> <b>{0}</b> <br> {1}</div>',
                args = { playerName, "Invalid dot format. Use /dot Your SADot Message" }
            })
        else
            local dotText = string.format('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="' .. Config.DotIconURL .. '" style="width: 30px; height: 30px; vertical-align: middle;"> %s %s</div>', playerName, ":" ..  message)
            TriggerClientEvent('chat:addMessage', -1, {
                template = dotText,
                args = { playerName, message }
            })

            -- Send message to Discord webhook for /dot
            sendDotToDiscord(playerName, message, tonumber(Config.DotColor, 16), "Dot", Config.DotIconURL)
        end
    end)

    -- Add a suggestion for the /dot command to the chat
    TriggerEvent('chat:addSuggestion', '/dot', 'Send a Dot message.', {
        { name = "message", help = "The Dot message you want to send." }
    })
end


function onMeCommand(source, args)
    local character = NDCore.getPlayer(source)

    if character then
        local firstname = character.firstname
        local lastname = character.lastname
        local text = "" .. firstname .. ' ' .. lastname .. ' ' .. Languages.prefix .. table.concat(args, " ") .. ""
        TriggerClientEvent('codex:shareDisplay', -1, text, source)
    else
        TriggerClientEvent('chatMessage', source, '', {255, 0, 0}, 'Unable to retrieve character information.')
    end
end

-- Register the command
if Config.CommandMe then
    RegisterCommand('me', function(source, args, rawCommand)
        local playerId = source
        local playerName = GetPlayerName(playerId)

        if Config.use3DMe then
            -- Use 3D /me if enabled
            onMeCommand(playerId, args)
        end

        if Config.useChatme then
            -- Use chat command /me if enabled
            distchatCommandHandler('me', "^2[ME]", playerId, args)
        end
    end)
end

-- Command handler for /dispatch
-- Register the command
if Config.CommandDispatch then
    RegisterCommand('cdispatch', function(source, args)
        local playerId = source
        local playerName = GetPlayerName(playerId)
        local message = table.concat(args, ' ')

        local imageUrl = Config.URLs.Dispatch
        local assignedTag = "[" .. "Dispatch" .. "]"

        sendChatMessageToChat(playerName, message, assignedTag, imageUrl)
    end, false)
end


