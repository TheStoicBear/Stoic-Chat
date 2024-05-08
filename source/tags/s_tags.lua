-- Modify the event handler for chat messages to include job-based tags
AddEventHandler('chatMessage', function(playerId, playerName, message)
    local player = NDCore.getPlayer(playerId)
    local assignedTag
    local imageUrl

    -- Get the player's job
    local jobName = player.getData("job")

    -- Access the JobTags table from config.lua
    local JobTags = Config.JobTags

    -- Check if the player's job has a corresponding tag
    if JobTags[jobName] then
        assignedTag = JobTags[jobName].Tag
        imageUrl = JobTags[jobName].ImageUrl
    else
        -- If no specific tag for the job, fallback to default tag from Config
        assignedTag = JobTags.default.Tag
        imageUrl = JobTags.default.ImageUrl
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
