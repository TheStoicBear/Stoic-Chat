local blip
local c = Config
local lang = Languages[c.language]
local peds = {}
local GetGameTimer = GetGameTimer
local currentBlips = {}
local isRDR = not TerraingridActivate and true or false
local chatInputActive = false
local playerNamesDist = 10
local isMouseEnabled = true 

function draw3dText(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    local scale = 200 / (GetGameplayCamFov() * dist)

    SetTextColour(c.color.r, c.color.g, c.color.b, c.color.a)
    SetTextScale(0.0, c.scale * scale)
    SetTextFont(c.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

function displayText(ped, text)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local targetPos = GetEntityCoords(ped)
    local dist = #(playerPos - targetPos)
    local los = HasEntityClearLosToEntity(playerPed, ped, 17)

    if dist <= c.dist and los then
        local exists = peds[ped] ~= nil
        peds[ped] = {
            time = GetGameTimer() + c.time,
            text = text
        }

        if not exists then
            Citizen.CreateThread(function()
                while GetGameTimer() <= peds[ped].time do
                    Wait(0)
                    local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 1.0)
                    draw3dText(pos, peds[ped].text)
                end
                peds[ped] = nil
            end)
        end
    end
end

function onShareDisplay(text, target)
    local player = GetPlayerFromServerId(target)
    if player ~= -1 or target == GetPlayerServerId(PlayerId()) then
        local ped = GetPlayerPed(player)
        displayText(ped, text)
    end
end

-- Register the event
RegisterNetEvent('codex:shareDisplay', onShareDisplay)

RegisterNetEvent('displayAvailableTags')
AddEventHandler('displayAvailableTags', function(tags)
    local tagList = ""
    for _, data in ipairs(tags) do
        tagList = tagList .. string.format('<br><div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle; border-radius: 50%%; margin-right: 5px;"> %s</div>', data.imageUrl, data.tag)
    end

    -- Trigger the server-side event to display the chat bubble
    TriggerServerEvent('displayChatBubble', tagList)
end)

function SetCursorImage()
    local imagePath = 'chat/html/image/your_cursor_image.png' -- Adjust the path accordingly
    SetCursorSprite(1, imagePath, 'idle_a', 0, 0)
end

-- Function to toggle the mouse state
function SetMouseEnabled(enabled)
    local player = PlayerId()

    if enabled then
        SetNuiFocus(false, false)
        ShowCursorThisFrame()
        SetPlayerInvincible(player, false)
    else
        SetNuiFocus(true, true)
        HideHudComponentThisFrame(19) -- Hide the weapon reticle
        SetPlayerInvincible(player, true)
    end

    isMouseEnabled = enabled
end

RegisterNUICallback('chatResult', function(data, cb)
    chatInputActive = false
    SetNuiFocus(false)

    if not data.canceled then
        local id = PlayerId()
        local message = data.message

        -- Check for links
        local hasLink = string.match(message, "%b<>")

        if hasLink then
            -- Check if the link includes a word from Config.BlockedWords
            local blockedWords = Config.BlockedWords or {}
            local isBlocked = false

            for _, word in ipairs(blockedWords) do
                if string.find(hasLink:lower(), word:lower()) then
                    isBlocked = true
                    break
                end
            end

            if isBlocked then
                -- Block the message
                return cb('blocked')
            end
        end

        -- Deprecated
        local r, g, b = 0, 0x99, 255
        if message:sub(1, 1) == '/' then
            ExecuteCommand(message:sub(2))
        else
            TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, message, data.mode)
        end
    end

    cb('ok')
end)

Citizen.CreateThread(function()
    while true do
        for id = 0, 31 do
            if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= GetPlayerPed(-1) then
                local ped = GetPlayerPed(id)
                local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
                local targetPos = GetEntityCoords(ped, true)
                local distance = math.floor(GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, targetPos.x, targetPos.y, targetPos.z, true))
                local takeaway = 0.95

                if distance < playerNamesDist and IsEntityVisible(ped) ~= GetPlayerPed(-1) then
                    local x2, y2, z2 = table.unpack(targetPos)
                    local x1, y1, z1 = table.unpack(playerPos)

                    if NetworkIsPlayerTalking(id) then
                        DrawMarker(25, x2, y2, z2 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 10.3, 55, 160, 205, 105, 0, 0, 2, 0, 0, 0, 0)
                    else
                        DrawMarker(25, x2, y2, z2 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 239, 239, 239, 50, 0, 0, 2, 0, 0, 0, 0)
                    end
                end  
            end
        end
        Citizen.Wait(0)
    end
end)
