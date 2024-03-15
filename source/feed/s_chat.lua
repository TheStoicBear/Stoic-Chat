
if Config.CommandGME then
    RegisterCommand('gme', function(source, args)
        chatCommandHandler('gme', "^2[GME]", source, args)
    end, false)
end

if Config.CommandDo then
    RegisterCommand('do', function(source, args)
        distchatCommandHandler('do', "^2[DO]", source, args)
    end, false)
end

if Config.CommandME then
    RegisterCommand('me', function(source, args)
        chatCommandHandler('me', "^2[ME]", source, args)
    end, false)
end

if Config.CommandTwt then
    RegisterCommand('twt', function(source, args)
        chatCommandHandler('twt', "^5[Twotter]", source, args)
    end, false)
end

if Config.CommandOOC then
    RegisterCommand('ooc', function(source, args)
        chatCommandHandler('ooc', "^#808080[OOC]", source, args)
    end, false)
end

-- RTO Command
if Config.CommandRTO then
    RegisterCommand("rto", function(source, args, rawCommand)
        local player = source
        local players = NDCore.getPlayers()
        hasRTOPermission(player, players, args)
    end, false)
end

-- DarkWeb Command
if Config.CommandDarkWeb then
    RegisterCommand("darkweb", function(source, args, rawCommand)
        local player = source
        local players = NDCore.getPlayers()
        hasDarkWebPermission(player, players, args)
    end, false)
end

-- Function to check RTO permission and send RTO chat message
function hasRTOPermission(player, players, args)
    local playerData = NDCore.getPlayer(player)

    if playerData then
        players[player].job = playerData.job
        for _, department in pairs(Config["/rto"].canNotSee) do
            if players[player].job == department then
                sendErrorMessage(player, "Your job makes it where you cannot access this command.")
                return false
            end
        end

        local messageToSend = table.concat(args, " ")

        for serverPlayer, playerInfo in pairs(players) do
            local isInRestrictedDepartment = false
            for _, department in pairs(Config["/rto"].canNotSee) do
                if playerInfo.job == department then
                    isInRestrictedDepartment = true
                    break
                end
            end

            if not isInRestrictedDepartment and messageToSend ~= "" then
                local rtoURL = Config.URLs.RTO or Config.DefaultTag.ImageUrl
                local template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>[%s] %s %s:</b> %s</div>'
                local formattedMessage = string.format(template, rtoURL, 'Radio', playerData.firstname or "", playerData.lastname or "", messageToSend)
                TriggerClientEvent('chat:addMessage', serverPlayer, {
                    template = formattedMessage
                })
            end
        end
    else
        return
    end
end


-- Function to check RTO permission and send RTO chat message
function hasDarkWebPermission(player, players, args)
    local playerData = NDCore.getPlayer(player)

    if playerData then
        players[player].job = playerData.job
        for _, department in pairs(Config["/darkweb"].canNotSee) do
            if players[player].job == department then
                sendErrorMessage(player, "Your job makes it where you cannot access this command.")
                return false
            end
        end

        local messageToSend = table.concat(args, " ")

        for serverPlayer, playerInfo in pairs(players) do
            local isInRestrictedDepartment = false
            for _, department in pairs(Config["/darkweb"].canNotSee) do
                if playerInfo.job == department then
                    isInRestrictedDepartment = true
                    break
                end
            end

            if not isInRestrictedDepartment and messageToSend ~= "" then
                local darkwebURL = Config.URLs.Darkweb or Config.DefaultTag.ImageUrl
                local template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>[%s] %s %s:</b> %s</div>'
                local formattedMessage = string.format(template, darkwebURL, 'DarkWeb', playerData.firstname or "", playerData.lastname or "", messageToSend)
                TriggerClientEvent('chat:addMessage', serverPlayer, {
                    template = formattedMessage
                })
            end
        end
    else
        return
    end
end



-- -- Function to check DarkWeb permission and send DarkWeb chat message
-- function hasDarkWebPermission(player, players, args)
--     local playerData = NDCore.getPlayer(player)

--     -- Check if the player has switched jobs and update the job information
--     if playerData then
--         players[player].job = playerData.job
--     end

--     if playerData then
--         players[player].job = playerData.job
--         for _, department in pairs(Config["/darkweb"].canNotSee) do
--             if players[player].job == department then
--                 TriggerClientEvent("chat:addMessage", player, {
--                     color = {255, 0, 0},
--                     args = {"^*^5[System]", players[player].job .. " cannot access this command."}
--                 })
--                 return false
--             end
--         end

--         local messageToSend = table.concat(args, " ")

--         for serverPlayer, playerInfo in pairs(players) do
--             local isInRestrictedDepartment = false
--             for _, department in pairs(Config["/darkweb"].canNotSee) do
--                 if playerInfo.job == department then
--                     isInRestrictedDepartment = true
--                     break
--                 end
--             end

--             if not isInRestrictedDepartment and messageToSend ~= "" then
--                 local darkwebURL = Config.URLs.Darkweb or Config.DefaultTag.ImageUrl
--                 local template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>[%s] %s %s:</b> %s</div>'
--                 local formattedMessage = string.format(template, darkwebURL, 'Radio', playerData.firstname or "", playerData.lastname or "", messageToSend)
--                 TriggerClientEvent('chat:addMessage', serverPlayer, {
--                     template = formattedMessage
--                 })
--             end
--         end
--     else
--         return
--     end
-- end