local lang = Languages[Config.language]
local staffChatState = {}
local playerTags = {}
local imageUrl = Config.DefaultTag.ImageUrl
local active_leo = {}
local playerTags = {}

function sendChatBubble(playerId, job, imageUrl, message, prefix)
    local imageUrl = imageUrl or Config.DefaultTag.ImageUrl
    local player = NDCore.getPlayer(playerId)

    if player then
        local firstname = player.getData("firstname")
        local lastname = player.getData("lastname")

        local function_check, msg = chatblacklist(message)

        if not function_check then
            local formattedMessage = string.format(Config.ChatTemplates.ChatBubble, imageUrl, firstname, lastname, job, prefix, message)
            TriggerClientEvent('chat:addMessage', playerId, { template = formattedMessage, args = {} })
        else
            sendErrorMessage(playerId, "Your message contains profanity.")
        end
    else
        print("Error: Player not found.")
    end
end

function sendErrorMessage(playerId, errorText)
    sendChatBubble(playerId, "Error:", errorText, "", "", "")
end

function sendChatMessage(playerId, message)
    local player = NDCore.getPlayer(playerId)

    if player then
        local firstname = player.getData("firstname")
        local lastname = player.getData("lastname")

        local function_check, msg = chatblacklist(message)

        if not function_check then
            local playerName = string.format("%s %s", firstname, lastname)
            TriggerClientEvent('chatMessage', playerId, playerName, {255, 255, 255}, message)
        else
            sendErrorMessage(playerId, "Your message contains profanity.")
        end
    else
        print("Error: Player not found.")
    end
end

function sChatBubble(targetPlayer, senderInfo, message)
    local imageUrl = Config.DefaultTag.ImageUrl
    local src = source
    local player = NDCore.getPlayer(source)
    
    if not player then
        print("No player found through NDCore.")
        return
    end
    
    local firstname = player.getData("firstname") or "DefaultFirstName"
    local lastname = player.getData("lastname") or "DefaultLastName"
    
    local function_check, msg = chatblacklist(message)

    if not function_check then
        local formattedMessage = string.format(Config.ChatTemplates.StaffChatBubble, imageUrl, firstname, lastname, message)
        TriggerClientEvent('chat:addMessage', targetPlayer, { template = formattedMessage, args = {} })
    else
        sendErrorMessage(targetPlayer, "Your message contains profanity.")
    end
end

function sendtagChatBubble(playerId, message, prefix)
    local imageUrl = Config.DefaultTag.ImageUrl
    local player = NDCore.getPlayer(playerId)

    if player then
        local firstname = player.getData("firstname")
        local lastname = player.getData("lastname")

        local function_check, msg = chatblacklist(message)

        if not function_check then
            local formattedMessage = string.format(Config.ChatTemplates.TagChatBubble, imageUrl, firstname, lastname, prefix, message)
            TriggerClientEvent('chat:addMessage', playerId, { template = formattedMessage, args = {} })
        else
            sendErrorMessage(playerId, "Your message contains profanity.")
        end
    else
        print("Error: Player not found.")
    end
end

function sendFineChatBubble(playerId, message)
    local imageUrl = Config.DefaultTag.ImageUrl
    local playerName = GetPlayerName(playerId)
    local function_check, msg = chatblacklist(message)

    if not function_check then
        local formattedMessage = string.format(Config.ChatTemplates.FineChatBubble, imageUrl, message)
        TriggerClientEvent('chat:addMessage', playerId, { template = formattedMessage, args = {} })
    else
        sendErrorMessage(playerId, "Your message contains profanity.")
    end
end

function sendChatMessageToChat(playerId, message, tag, imageUrl)
    local player = NDCore.getPlayer(playerId)

    if player then
        local firstname = player.getData("firstname")
        local lastname = player.getData("lastname")

        local function_check, msg = chatblacklist(message)

        if not function_check then
            local formattedMessage = string.format(Config.ChatTemplates.DiscordLikeMessage, imageUrl, tag, firstname, lastname, message)
            TriggerClientEvent('chat:addMessage', { template = formattedMessage, args = { firstname, lastname, message } })
        else
            sendErrorMessage(playerId, "Your message contains profanity.")
        end
    else
        print("Error: Player not found.")
    end
end

function sendIDChatBubble(playerId, message, tag, imageUrl)
    local player = NDCore.getPlayer(playerId)

    if player then
        local playerName = player.getName()
        local function_check, msg = chatblacklist(message)

        if not function_check then
            local formattedMessage = string.format(Config.ChatTemplates.DiscordLikeMessage, imageUrl, tag, playerName, "", message)
            TriggerClientEvent('chat:addMessage', { template = formattedMessage, args = { playerName, "", message } })
        else
            sendErrorMessage(playerId, "Your message contains profanity.")
        end
    else
        print("Error: Player not found.")
    end
end

function sendComChatBubble(playerId, firstname, lastname, job, imageUrl, message, prefix)
    local imageUrl = imageUrl or Config.DefaultTag.ImageUrl
    local playerName = GetPlayerName(playerId)
    local function_check, msg = chatblacklist(message)

    if not function_check then
        local formattedMessage = string.format(Config.ChatTemplates.ComChatBubble, imageUrl, firstname, lastname, job, prefix, message)
        TriggerClientEvent('chat:addMessage', playerId, { template = formattedMessage, args = {} })
    else
        sendErrorMessage(playerId, "Your message contains profanity.")
    end
end

function chatCommandHandler(command, prefix, source, args, color, additionalArgs)
    local player = source
    local character = NDCore.getPlayer(player)

    if character then
        local length = string.len(table.concat(args, " "))
        local tag = playerTags[player] or "Default Tag"

        if length > 0 then
            sendComChatBubble(-1, character.firstname, character.lastname, character.job, Config.DefaultTag.ImageUrl, table.concat(args, " "), prefix, color, additionalArgs)
        end
    else
        print("Error: Player data not found.")
    end
end

function distchatCommandHandler(command, prefix, source, args, color, additionalArgs)
    local player = source
    local character = NDCore.getPlayer(player)
    local length = string.len(table.concat(args, " "))
    local tag = playerTags[player] or "Default Tag"

    if length > 0 then
        local posX, posY, posZ = table.unpack(GetEntityCoords(GetPlayerPed(player)))
        local radius = Config.CommandRadius or 10.0

        for _, targetPlayer in ipairs(GetPlayers()) do
            local targetPos = GetEntityCoords(GetPlayerPed(targetPlayer))
            local distance = #(vector3(posX, posY, posZ) - targetPos)

            if distance <= radius then
                sendComChatBubble(targetPlayer, character.firstname, character.lastname, character.job, Config.DefaultTag.ImageUrl, table.concat(args, " "), prefix, color, additionalArgs)
            end
        end
    end
end

AddEventHandler('chatMessage', function(source, name, message)
    CancelEvent()
    local src = source
    local function_check, msg = chatblacklist(message)

    if function_check then
        --TriggerClientEvent('chatMessage', -1, string.format(Filter.return_message, msg))
    else
		--Something or another
    end
end)

function chatblacklist(str)
    for _, badword in ipairs(Filter.words) do
        if string.match(string.lower(str), badword) then
            return true, badword
        end
    end
    return false, nil
end

RegisterServerEvent("server:sendChatBubble")
AddEventHandler("server:sendChatBubble", function(playerId, tag, message, firstname, lastname, job, imageUrl)
    sendChatBubble(playerId, tag, message, firstname, lastname, job, imageUrl)
end)
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
exports('addMessage', function(target, message)
    if not message then message, target = target, -1 end
    if not target or not message then return end
    TriggerClientEvent('chat:addMessage', target, message)
end)

local hooks, hookIdx = {}, 1

exports('registerMessageHook', function(hook)
    local resource = GetInvokingResource()
    hooks[hookIdx + 1], hookIdx = { fn = hook, resource = resource }, hookIdx + 1
end)

local modes = {}

local function getMatchingPlayers(seObject)
    local players, retval = GetPlayers(), {}
    for _, v in ipairs(players) do if IsPlayerAceAllowed(v, seObject) then retval[#retval + 1] = v end
    end
    return retval
end

exports('registerMode', function(modeData)
    if not modeData.name or not modeData.displayName or not modeData.cb then return false end
    local resource = GetInvokingResource()
    modes[modeData.name], modes[modeData.name].resource = modeData, resource

    local clObj = {
        name = modeData.name,
        displayName = modeData.displayName,
        color = modeData.color or '#fff',
        isChannel = modeData.isChannel,
        isGlobal = modeData.isGlobal,
    }

    if not modeData.seObject then TriggerClientEvent('chat:addMode', -1, clObj)
    else for _, v in ipairs(getMatchingPlayers(modeData.seObject)) do TriggerClientEvent('chat:addMode', v, clObj) end end

    return true
end)

function unregisterHooks(resource)
    local toRemove = {}

    for k, v in pairs(hooks) do if v.resource == resource then table.insert(toRemove, k) end
    end

    for _, v in ipairs(toRemove) do hooks[v] = nil end

    toRemove = {}

    for k, v in pairs(modes) do
        if v.resource == resource then
            table.insert(toRemove, k)
        end
    end

    for _, v in ipairs(toRemove) do
        TriggerClientEvent('chat:removeMode', -1, { name = v })
        modes[v] = nil
    end
end

function routeMessage(source, author, message, mode, fromConsole)
    if source >= 1 then author = GetPlayerName(source) end

    local outMessage = { color = { 255, 255, 255 }, multiline = true, args = { message }, mode = mode }

    if author ~= "" then outMessage.args = { author, message } end

    if mode and modes[mode] then
        local modeData = modes[mode]

        if modeData.seObject and not IsPlayerAceAllowed(source, modeData.seObject) then return end
    end

    local messageCanceled, routingTarget, hookRef = false, -1, {
        updateMessage = function(t)
            for k, v in pairs(t) do
                if k == 'template' then outMessage['template'] = v:gsub('%{%}', outMessage['template'] or '@default')
                elseif k == 'params' then
                    if not outMessage.params then outMessage.params = {} end
                    for pk, pv in pairs(v) do outMessage.params[pk] = pv end
                else outMessage[k] = v end
            end
        end,

        cancel = function() messageCanceled = true end,

        setSeObject = function(object) routingTarget = getMatchingPlayers(object) end,

        setRouting = function(target) routingTarget = target end
    }

    for _, hook in pairs(hooks) do if hook.fn then hook.fn(source, outMessage, hookRef) end end

    if modes[mode] then local m = modes[mode] m.cb(source, outMessage, hookRef) end

    if messageCanceled then return end

    TriggerEvent('chatMessage', source, #outMessage.args > 1 and outMessage.args[1] or '', outMessage.args[#outMessage.args])

    if not WasEventCanceled() then
        if type(routingTarget) ~= 'table' then TriggerClientEvent('chat:addMessage', routingTarget, outMessage)
        else for _, id in ipairs(routingTarget) do TriggerClientEvent('chat:addMessage', id, outMessage) end end
    end

    if not fromConsole then
        print(author .. '^7' .. (modes[mode] and (' (' .. modes[mode].displayName .. ')') or '') .. ': ' .. message .. '^7')
    end
end

AddEventHandler('codexchat:messageEntered', function(author, color, message, mode)
    if not message or not author then return end
    local source = source
    routeMessage(source, author, message, mode)
end)

function ToDiscord(embed, webhook)
    if Logger.use then
        local payload = json.encode({ embeds = { embed } })
        PerformHttpRequest(webhook, function(statusCode, response, headers) end, 'POST', payload, { ["Content-Type"] = "application/json" })
    end
end

AddEventHandler('playerJoining', function()
    if Logger.use and GetConvarInt('chat_showJoins', 1) == 0 then return end
    local playerName = GetPlayerName(source)
    local embed = { title = Logger.playerJoinTitle, description = playerName .. " has joined the server.", color = Logger.playerJoinColor, footer = { text = Logger.serverName .. " Server Event", },
        author = { name = playerName, icon_url = Logger.serverIconURL, },
    }
    ToDiscord(embed, Logger.generalURL)
end)

AddEventHandler('playerDropped', function(reason)
    if Logger.use then
        local playerName = GetPlayerName(source)
        local embed = { title = Logger.playerLeaveTitle, description = playerName .. " has left the server.", color = Logger.playerLeaveColor, footer = { text = Logger.serverName .. " Server Event", },
            fields = { { name = "Reason", value = reason, inline = false }, },
            author = { name = playerName, icon_url = Logger.serverIconURL, },
        }
        ToDiscord(embed, Logger.generalURL)
    end
end)

function CommandChecker()
    local self = {}
    self.commandStartCharacter, self.rawCommand = '/', {}
    self.isCommand = function(text) return text:sub(1, #self.commandStartCharacter) == self.commandStartCharacter end
    self.splitCommand = function(command) for token in string.gmatch(command, "[^%s]+") do table.insert(self.rawCommand, token) end
        return self.rawCommand
    end
    return self
end

RegisterServerEvent('commandLoggerDiscord:commandWasExecuted')
AddEventHandler('commandLoggerDiscord:commandWasExecuted', function(playerId, data)
    local commandChecker = CommandChecker()
    if commandChecker.isCommand(data.message) then
        local webhook = Webhook(Logger.DiscordWebHookSettings.url, Logger.DiscordWebHookSettings.image)
        webhook.send(playerId, data.message)
    end
end)

function Webhook(webHookUrl, webHookImage)
    local self = {}
    self.webHookUrl, self.webHookImage = webHookUrl, webHookImage
    if not self.webHookUrl then error('discordWebHookUrl was expected but got nil') return end
    self.send = function(playerId, rawCommand)
        local user, messageObj = self.getPlayerServerInfo(), self.messageBuilder(user, rawCommand)
        PerformHttpRequest(self.webHookUrl, function(err, text, header) print(err, text) end, 'POST', json.encode(messageObj), {
            ['Content-Type'] = 'application/json'
        })
    end
    self.messageBuilder = function(user, rawCommand)
        return {
            embeds = {
                {
                    title = user.name .. ' was execute a command',
                    description = '```' .. rawCommand .. '```\n',
                    color = 3666853,
                    fields = {
                        { name = 'Steam Hex:', value = user.steamhex, inline = true },
                        { name = 'Rockstar License:', value = user.license, inline = true },
                        { name = 'Xbox:', value = user.xbox, inline = true },
                        { name = 'IP:', value = user.ip, inline = true },
                        { name = 'Discord ID:', value = user.discord, inline = true },
                        { name = 'Microsoft:', value = user.microsoft, inline = true }
                    },
                    thumbnail = { url = self.webHookImage },
                    author = { name = user.name },
                },
            }
        }
    end
    self.getPlayerServerInfo = function ()
        local user = {
            steamhex = "None",
            license = "None",
            xbox = "None",
            ip = "None",
            discord = "None",
            microsoft = "None"
        }
        user.name = GetPlayerName(source)
        for k, v in pairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("steam:")) == "steam:" then user.steamhex = string.sub(v, 7)
            elseif string.sub(v, 1, string.len("license:")) == "license:" then user.license = string.sub(v, 9)
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then user.xbox = string.sub(v, 5)
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then user.ip = string.sub(v, 4)
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then user.discord = string.sub(v, 9)
            elseif string.sub(v, 1, string.len("live:")) == "live:" then user.microsoft = string.sub(v, 6)
            end
        end
        return user
    end
    self.createDescription = function(user)
        return string.format("Steam: %s |\n License: %s |\n Xbox: %s |\n Ip: %s |\n Discord: %s |\n Microsoft: %s |", user.steamhex, user.license, user.xbox, user.ip, user.discord, user.microsoft)
    end
    return self
end

AddEventHandler('codexlistener', function(source, name, message)
    if Logger.use then
        local playerName = GetPlayerName(source)
        if string.sub(message, 1, 1) == '/' then
            local command, fullCommand = string.sub(message, 2), playerName .. ' used command: /' .. command
            local embed = {
                title = Logger.regularChatTitle,
                description = message,
                color = Logger.regularChatColor,
                footer = { text = Logger.serverName .. " Server Event", },
                author = { name = playerName, icon_url = Logger.serverIconURL, },
            }
            ToDiscord(embed, Logger.generalURL)
        end
    end
end)

RegisterCommand('say', function(source, args, rawCommand)
    routeMessage(source, (source == 0) and 'console' or GetPlayerName(source), rawCommand:sub(5), nil, true)
end)

function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands, suggestions = GetRegisteredCommands(), {}
        for _, command in ipairs(registeredCommands) do if IsPlayerAceAllowed(player, ('command.%s'):format(command.name)) then
                table.insert(suggestions, { name = '/' .. command.name, help = '' }) end
        end
        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('chat:init', function()
    local source = source
    refreshCommands(source)
    for _, modeData in pairs(modes) do
        local clObj = { name = modeData.name, displayName = modeData.displayName, color = modeData.color or '#fff', isChannel = modeData.isChannel,
            isGlobal = modeData.isGlobal, }
        if not modeData.seObject or IsPlayerAceAllowed(source, modeData.seObject) then TriggerClientEvent('chat:addMode', source, clObj) end
    end
end)

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)
    for _, player in ipairs(GetPlayers()) do refreshCommands(player) end
end)

AddEventHandler('onResourceStop', function(resName) unregisterHooks(resName) end)