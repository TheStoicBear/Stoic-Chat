-- c_randomizer.lua

function GenerateRandomPassword(length)
    local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_-+=<>?"
    local password = ""

    for i = 1, length do
        local randomIndex = math.random(1, #charset)
        password = password .. charset:sub(randomIndex, randomIndex)
    end

    return password
end

function GenerateRandomToken(tokenType)
    local numbers = "0123456789"
    local letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local symbols = "!@#$%^&*()_-+=<>?"
    local charset = ""

    if tokenType == "numbers" then
        charset = numbers
    elseif tokenType == "letters" then
        charset = letters
    elseif tokenType == "symbols" then
        charset = symbols
    elseif tokenType == "all" then
        charset = numbers .. letters .. symbols
    else
        return "Invalid token type."
    end

    local token = ""
    local tokenLength = 16

    for i = 1, tokenLength do
        local randomIndex = math.random(1, #charset)
        token = token .. charset:sub(randomIndex, randomIndex)
    end

    return token
end


RegisterCommand("random", function(source, args, rawCommand)
    -- Randomizer command with suggestions
    if args[1] then
        local subCommand = args[1]
        table.remove(args, 1)  -- Remove the subcommand from the arguments

        if subCommand == "number" then
            RandomNumber(args)
        elseif subCommand == "password" then
            RandomPassword(args)
        elseif subCommand == "token" then
            RandomToken(args)
        elseif subCommand == "8ball" then
            Magic8Ball(args)
        else
            -- Suggest valid subcommands using chat suggestions
            TriggerEvent("chat:addSuggestions", {
                {
                    name = '/random number',
                    help = 'Generate a random number within a range',
                    params = {
                        { name = 'min', help = 'Minimum value for the range' },
                        { name = 'max', help = 'Maximum value for the range' }
                    }
                },
                {
                    name = '/random password',
                    help = 'Generate a random password',
                    params = {
                        { name = 'length', help = 'Optional: length of the password' }
                    }
                },
                {
                    name = '/random token',
                    help = 'Generate a random token',
                    params = {
                        { name = 'type', help = 'Optional: numbers/letters/symbols/all' }
                    }
                },
                {
                    name = '/random 8ball',
                    help = 'Ask the Magic 8 Ball a question',
                    params = {
                        { name = 'question', help = 'Your question for the Magic 8 Ball' }
                    }
                }
            })
        end
    else
        -- Provide usage information if no subcommand is provided
        -- Suggest valid subcommands using chat suggestions
        TriggerEvent("chat:addSuggestions", {
            {
                name = '/random number',
                help = 'Generate a random number within a range',
                params = {
                    { name = 'min', help = 'Minimum value for the range' },
                    { name = 'max', help = 'Maximum value for the range' }
                }
            },
            {
                name = '/random password',
                help = 'Generate a random password',
                params = {
                    { name = 'length', help = 'Optional: length of the password' }
                }
            },
            {
                name = '/random token',
                help = 'Generate a random token',
                params = {
                    { name = 'type', help = 'Optional: numbers/letters/symbols/all' }
                }
            },
            {
                name = '/random 8ball',
                help = 'Ask the Magic 8 Ball a question',
                params = {
                    { name = 'question', help = 'Your question for the Magic 8 Ball' }
                }
            }
        })
    end
end, false)


-- Provide chat suggestions for each subcommand
function RandomNumber(args)
    if args[1] and args[2] then
        local minRange = tonumber(args[1])
        local maxRange = tonumber(args[2])

        if minRange and maxRange then
            local randomNumber = math.random(minRange, maxRange)
            ShowRandomizer("Generated Number: " .. randomNumber)
            ShowRandomizer("Debug: Min Range: " .. minRange .. ", Max Range: " .. maxRange)
        else
            ShowRandomizer("Error: Invalid range values.")
        end
    else
        ShowRandomizer("Error: Usage: /random number [min] [max]")
        -- Suggest usage for the /random number command
        TriggerEvent("chat:addMessage", {
            color = {255, 255, 255},
            multiline = true,
            args = {"Usage: /random number [min] [max]", "Generate a random number within a specified range."}
        })
    end
end

function RandomPassword(args)
    local passwordLength = 8  -- Default password length

    if args[1] then
        passwordLength = tonumber(args[1]) or passwordLength
    end

    local password = GenerateRandomPassword(passwordLength)
    ShowRandomizer("Generated Password: " .. password)
    ShowRandomizer("Debug: Password Length: " .. passwordLength)

    -- Suggest usage for the /random password command
    TriggerEvent("chat:addMessage", {
        color = {255, 255, 255},
        multiline = true,
        args = {"Usage: /random password [length]", "Generate a random password with an optional length."}
    })
end

function RandomToken(args)
    local tokenType = args[1] or "all"
    local token = GenerateRandomToken(tokenType)
    ShowRandomizer("Generated Token: " .. token)
    ShowRandomizer("Debug: Token Type: " .. tokenType)

    -- Suggest usage for the /random token command
    TriggerEvent("chat:addMessage", {
        color = {255, 255, 255},
        multiline = true,
        args = {"Usage: /random token [numbers/letters/symbols/all]", "Generate a random token of specified type."}
    })
end

function Magic8Ball(args)
    local responses = {
        "It is certain.",
        "It is decidedly so.",
        "Without a doubt.",
        "Yes, definitely.",
        "You may rely on it.",
        "As I see it, yes.",
        "Most likely.",
        "Outlook good.",
        "Yes, but don't hold your breath.",
        "Not now, but maybe later.",
        "I'm not sure. Ask again later.",
        "Don't count on it.",
        "My sources say no.",
        "Outlook not so good.",
        "Very doubtful."
    }

    local randomResponse = responses[math.random(1, #responses)]
    Show9Ball("Magic 8 Ball Response: " .. randomResponse)

    -- Suggest usage for the /random 8ball command
    TriggerEvent("chat:addMessage", {
        color = {255, 255, 255},
        multiline = true,
        args = {"Usage: /random 8ball [question]", "Ask the Magic 8 Ball a question and get a random response."}
    })
end

function Show9Ball(message)
    local imageUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Magic_eight_ball.png/640px-Magic_eight_ball.png"  -- Replace with your image URL
    TriggerEvent("chat:addMessage", {
        color = {255, 255, 255},
        args = {message},
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                   '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                   '{0}' ..
                   '</div>',
        bubble = true
    })
end

function ShowRandomizer(message)
    local imageUrl = "YOUR_IMAGE_URL"  -- Replace with your image URL
    TriggerEvent("chat:addMessage", {
        color = {255, 255, 255},
        args = {message},
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
                   '<img src="' .. imageUrl .. '" style="max-width: 30px; height: auto; margin-right: 10px;">' ..
                   '{0}' ..
                   '</div>',
        bubble = true
    })
end
