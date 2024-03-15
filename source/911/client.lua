local activeBlips = {}

if Config.Command911 then
    RegisterNetEvent("ND_Chat:911")
    AddEventHandler("ND_Chat:911", function(coords, description)
        local src = GetPlayerServerId(-1)
        local useND = Config.UseND
        local player = useND and NDCore.getPlayer(src) or src

        if not player then
            print("Failed to get player information!")
            return
        end

        local department = useND and player.job or IsAceAllowed(player, "CX911.Allow")
        if not department then
            print("Player has no job or insufficient permissions!")
            return
        end

        print("Player job:", department)

        local playerName = useND and (player.firstname .. " " .. player.lastname) or GetPlayerName(player)

        for _, departmentConfig in pairs(Config["/c911"].callTo) do
            if department == departmentConfig then
                local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                print("Location:", location)

                PlaySoundOnReceiver('911call')

                local chatMessage = string.format("^1^*[Dispatch]: ^3Location: ^7%s ^3| Information: ^7%s", location, description)
                local imageUrl = Config.URLs.Dispatch

                ShowChatMessage(chatMessage, {255, 0, 0}, imageUrl, true)

                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                table.insert(activeBlips, { blip = blip, expiryTime = GetGameTimer() + Config.blipExpiryTime })
                SetBlipSprite(blip, 189)
                SetBlipAsShortRange(blip, true)
                SetBlipColour(blip, 59)
                --SetBlipName(blip, "Active 911 Call: " .. location)

                CreateWaypointOnKeyPress(coords)

                Citizen.CreateThread(function()
                    CheckBlipExpiry()
                end)
    -- Add the new call directly to the activeCalls table in menu.lua
    TriggerEvent('AddNewCall', description, coords)

    -- Trigger the 'active_calls' event to display the updated active calls menu
    TriggerEvent('active_calls')
                break
            end
        end
    end)
end
-- Active 911 Call Event
RegisterCommand(Config.Command911, function(source, args, rawCommand)
    local description = table.concat(args, " ")
    local playerCoords = GetEntityCoords(PlayerPedId())

    -- Trigger the 'ND_Chat:911' event with coordinates and description
    TriggerServerEvent("ND_Chat:911", playerCoords, description)
end, false)

function PlaySoundOnReceiver(soundName)
    TriggerEvent('InteractSound_CL:PlayOnOne', soundName, 0.2)
end

function ShowChatMessage(text, color, imageUrl, bubble)
    local template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                    '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                    '{0}' ..
                    '</div>'

    TriggerEvent("chat:addMessage", {
        color = color,
        args = {text},
        template = template,
        bubble = bubble
    })
end

function CreateWaypointOnKeyPress(coords)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsControlPressed(0, 246) then -- Y button
                SetNewWaypoint(coords.x, coords.y)
                break
            end
        end
    end)
end

function CheckBlipExpiry()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local currentTime = GetGameTimer()
            for i, blipData in ipairs(activeBlips) do
                if currentTime >= blipData.expiryTime then
                    -- Blip expired, remove it
                    RemoveBlip(blipData.blip)
                    table.remove(activeBlips, i)
                    break
                end
            end
        end
    end)
end
