local activeBlips = {}

function PlayPanicSound()
    TriggerEvent('InteractSound_CL:PlayOnOne', 'panic', 0.2)
end

if Config.CommandPanic then
    RegisterNetEvent("ND_Chat:PanicButton")
    AddEventHandler("ND_Chat:PanicButton", function(coords, description)
        local player, playerInfo = source, Config.UseND and NDCore.getPlayer(source) or source
        if not playerInfo then
            return print("Failed to get player information!")
        end

        local department = Config.UseND and playerInfo.job or IsAceAllowed(playerInfo, "CXPanic.Allow")
        if not department then
            return print("Player has no job or insufficient permissions!")
        end

        print("Player job:", department)
        local playerName = Config.UseND and (playerInfo.firstname .. " " .. playerInfo.lastname) or GetPlayerName(player)

        for _, departmentConfig in pairs(Config["/panic"].callTo) do
            if department == departmentConfig then
                local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
                print("Location:", location)

                local chatMessage = string.format(" ^1^*[Dispatch]: ^3Location: ^7%s ^3| Information: ^7%s", location, description)
                local imageUrl = Config.URLs.Dispatch

                TriggerEvent("chat:addMessage", {
                    color = {255, 0, 0},
                    args = {chatMessage},
                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                               '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                               '{0}' ..
                               '</div>',
                    bubble = true
                })

                local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                table.insert(activeBlips, {blip = blip, expiryTime = GetGameTimer() + 30000}) -- Set blip duration to 30 seconds
                SetBlipSprite(blip, 161)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                SetBlipColour(blip, 59)
                AddTextComponentString("Active Panic Button: " .. location)
                EndTextCommandSetBlipName(blip)

                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0)
                        if IsControlPressed(0, 246) then
                            SetNewWaypoint(coords.x, coords.y)
                            break
                        end
                    end
                end)

                Citizen.CreateThread(function()
                    while GetGameTimer() < activeBlips[#activeBlips].expiryTime do
                        Citizen.Wait(10000)
                        TriggerEvent('InteractSound_CL:PlayOnOne', 'panic', 1.0)
                    end
                end)

                Citizen.CreateThread(function()
                    while GetGameTimer() < activeBlips[#activeBlips].expiryTime do
                        Citizen.Wait(1000)
                    end
                    RemoveBlip(blip)
                    table.remove(activeBlips, #activeBlips)
                end)

                break
            end
        end
    end)
end
