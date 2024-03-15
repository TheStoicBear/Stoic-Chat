
-- Function to send a Discord embed with a webhook for /x, /fbmarket, /news, and /dot
function sendToDiscord(username, message, color)
    local embed = {
        {
            title = "@" .. username,
            description = message,
            color = color,
            footer = {
                text = "Created by 5M-CodeX" -- Replace with your Discord username and tag
            },
            author = {
                name = "New Bleeter Post",
                icon_url = Config.XIconURL
            }
        }
    }

    local payload = {
        embeds = embed
    }

    PerformHttpRequest(Config.DiscordWebhook, function(err, text, headers)
        if err == 200 then
            print("Bleeter post sent to Discord successfully!")
        end
    end, 'POST', json.encode(payload), { ["Content-Type"] = "application/json" })
end

-- Function to send a Discord embed with a webhook for /Lifeinvader
function sendLifeinvaderToDiscord(playerName, message, color)
    local embed = {
        {
            title = "@" .. playerName,
            description = message,
            color = color,
            footer = {
                text = "Created by 5M-CodeX" -- Replace with your Discord username and tag
            },
            author = {
                name = "New Lifeinvader Post",
                icon_url = Config.LifeinvaderIconURL
            }
        }
    }

    local payload = {
        embeds = embed
    }

    PerformHttpRequest(Config.LifeinvaderWebhook, function(err, text, headers)
        if err == 200 then
            print("Lifeinvader post sent to Discord successfully!")
        end
    end, 'POST', json.encode(payload), { ["Content-Type"] = "application/json" })
end

-- Function to send a Discord embed with a webhook for /news
function sendNewsToDiscord(playerName, message, color)
    local embed = {
        {
            title = "@" .. playerName,
            description = message,
            color = color,
            footer = {
                text = "Created by 5M-CodeX" -- Replace with your Discord username and tag
            },
            author = {
                name = "New News Post",
                icon_url = Config.NewsIconURL
            }
        }
    }

    local payload = {
        embeds = embed
    }

    PerformHttpRequest(Config.NewsWebhook, function(err, text, headers)
        if err == 200 then
            print("News post sent to Discord successfully!")
        end
    end, 'POST', json.encode(payload), { ["Content-Type"] = "application/json" })
end

-- Function to send a Discord embed with a webhook for /dot
function sendDotToDiscord(playerName, message, color)
    local embed = {
        {
            title = "@" .. playerName,
            description = message,
            color = color,
            footer = {
                text = "Created by 5M-CodeX" -- Replace with your Discord username and tag
            },
            author = {
                name = "New LSDOT Post",
                icon_url = Config.DotIconURL
            }
        }
    }

    local payload = {
        embeds = embed
    }

    PerformHttpRequest(Config.DotWebhook, function(err, text, headers)
        if err == 200 then
            print("Dot post sent to Discord successfully!")
        end
    end, 'POST', json.encode(payload), { ["Content-Type"] = "application/json" })
end

-- Function to send a Discord embed with a webhook for /snapmatic
function sendInstaToDiscord(playerName, message, color)
    local embed = {
        {
            title = "@" .. playerName,
            description = message,
            color = color,
            footer = {
                text = "Created by 5M-CodeX" -- Replace with your Discord username and tag
            },
            author = {
                name = "New Snapmatic Post",
                icon_url = Config.InstaIconURL
            }
        }
    }

    local payload = {
        embeds = embed
    }

    PerformHttpRequest(Config.InstaWebhook, function(err, text, headers)
        if err == 200 then
            print("Snapmatic post sent to Discord successfully!")
        end
    end, 'POST', json.encode(payload), { ["Content-Type"] = "application/json" })
end
