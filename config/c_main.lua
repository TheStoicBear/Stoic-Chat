

Config = {
    UseND = true,
    enableMoneyHud = true,
    AutoDisplay = true,
    enableCommand = true,
    PoliceJob = {
        "LSCSO",
        "SASP",
        "DOA"
    },
    FireJob = {
        "SAFR"
    },
    ChatTags = {
        {
            Tag = "Civillian",
            Permission = "Invalid.permission",
            ImageUrl = "https://cdn2.iconfinder.com/data/icons/avatars-2-7/128/6-512.png"
        },
        {
            Tag = "Owner",
            Permission = "owner.permission",
            ImageUrl = "https://static.wikia.nocookie.net/callofduty/images/7/78/Bested_Emblem_MWII.png/revision/latest?cb=20230213155144&format=original"
        },
        {
            Tag = "Global Statement",
            Permission = "admin.permission",
            ImageUrl = "https://static.wikia.nocookie.net/callofduty/images/f/f7/GoalBreaker_Emblem_MWII.png/revision/latest?cb=20230213155148&format=original"
        }
    },
    ["/darkweb"] = {
        canNotSee = {
            "LSCSO",
            "SASP",
            "SAFR",
            "DOA"
        }
    },
    ["/rto"] = {
        canNotSee = {
            "CIV"
        }
    },
    blipExpiryTime = 100000, -- 5 minutes
    ["/911"] = {
        callTo = {
            "LSCSO",
            "SASP",
            "SAFR",
            "DOA"
        }
    },
    ["/panic"] = {
        ignoreDepartments = false, -- Add this option to ignore departments
        callTo = {
            "LSCSO",
            "SASP",
            "SAFR",
            "DOA"
        }
    },
    ["/tow"] = {
        enabled = true,
        callTo = {
            "LSDOT"
        }
    },
 
-- Configuration for staff chat
StaffChat = "Admin.permission",

--Medical NPC
npcInfo = {
        model = "a_m_m_business_01", -- Replace with the desired NPC model
        coords = { x = 1794.54, y = 3618.32, z = 34.30 },
        heading = 70.87,
        label = "Doctor",
        options = {
            { label = "Check in to medical center", event = "ndcore:interact" }
        }
},

    ProxDist = 10, -- Set your proximity distance here (adjust as needed)
    -- Custom Image URLs for commands
URLs = {
        Dispatch = "https://i.imgur.com/adrNj4A.png",
        Me = "https://i.imgur.com/bONDaMZ.png",
        Do = "https://i.imgur.com/gnHegRk.png",
        Gm = "url_for_gm_image.png",
        DarkWeb = "https://i.imgur.com/byJ48nh.png",
        StaffChat = "https://i.imgur.com/Xw7suUe.png",
        RTO = "https://i.imgur.com/PKQZSfJ.png"
},

-- Default tag for players without permissions
DefaultTag = {
        Tag = "Default",
        ImageUrl = "https://cdn.discordapp.com/attachments/1182385820959784970/1187491272194277386/mylogo.png?ex=6597146d&is=65849f6d&hm=404ba649d949e5d10657215ea7ae782d914a622eeaea4335e0adf9928927bc75&" -- Provide the URL for the default image
},

    XCommandEnabled = true, -- Set to false to disable the /x command
    LifeinvaderCommandEnabled = true, -- Set to false to disable the /Lifeinvader command
    NewsCommandEnabled = true, -- Set to false to disable the /news command
    DotCommandEnabled = true, -- Set to false to disable the /dot command
    InstaCommandEnabled = true, -- Set to false to disable the /insta command
    language = "en",
    color = {r = 230, g = 230, b = 230, a = 255}, -- Text color
    font = 0, -- Text font
    time = 8000, -- Duration to display the text (in ms)
    scale = 0.5, -- Text scale
    dist = 250, -- Min. distance to draw for 3dme
    MaxDistanceToShowSearch = 20,
    useChatme = true, -- Set this to false to disable chat me and leave 3dme.
    use3DMe = true, -- Set this to false to disable 3DMe and leave chat me.
    CommandMe = true, -- Set to false to disable the /me command
    CommandGME = true, -- Set to false to disable the /gme command
    CommandDo = true, -- Set to false to disable the /do command
    CommandGDo = true, -- Set to false to disable the /do command
    CommandTwt = true, -- Set to false to disable the /twt	command
    CommandPanic = true, -- Set to false to disable the /panic command
    CommandDarkWeb = true, -- Set to false to disable the /darkweb command
    CommandOOC = true, -- Set to false to disable the /ooc command
    CommandRTO = true, -- Set to false to disable the /rto command
    Command911 = true, --
    fbmarket = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> %s<b>%s</b> <br> %s</div>',
    news = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> %s<b>%s</b> <br> %s</div>',
    dot = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> %s<b>%s</b> <br> %s</div>',
    insta = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> %s<b>%s</b> <br> %s</div>',

ChatTemplates = {
        ChatBubble = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>%s %s [%s] %s</b>: %s</div>',
        StaffChatBubble = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 6, 6, 0.16); border-radius: 10px; color: white; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> [StaffChat] %s %s: %s</div>',
        TagChatBubble = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>%s</b>: %s</div>',
        FineChatBubble = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;">%s</div>',
        DiscordLikeMessage = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>%s %s:</b> %s</div>',
        idMessage = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 10px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>%s:</b> %s %s</div>',
        ComChatBubble = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>%s %s [%s] %s</b>: %s</div>',
        DarkWebChatBubble = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 15px; max-width: 80vw; overflow-wrap: break-word; word-wrap: break-word; word-break: break-all;">' ..
            '<img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> <b>[DarkWeb] %s:</b> %s %s</div>',
        EmergencyMessage = "^1^*[^7911^1]^3: CallerInfo: ^7%s ^3| ^3Location^3: ^7%s ^3| Information^3: ^7%s ^3",
        EmergencyHelperMessage = ""
},
    -- Discord Webhook Settings
    DiscordWebhook = "https://discordapp.com/api/webhooks/1197248247245320404/nmuXTSnisMO7hQ9VOH9LUFWQ8Cjn4azlbkhEbp4jX7obUaOi0eeoqa8uyZ_bgwViN83U",
    X = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 0, 0.8); border-radius: 3px;"><img src="%s" style="width: 30px; height: 30px; vertical-align: middle;"> %s<b>%s</b> <br> %s</div>',
    ServerName = "X Feed",
    VerifiedColor = "#0099FF", -- Color for verified users (hex color code)
    InvalidFormatColor = "#FF0000", -- Color for invalid tweet format (hex color code)
    DefaultTweetColor = "#FFFFFF", -- Default tweet color (hex color code)
    VerificationAcePerm = "Admin.permission", -- ACE permission for verification		             
    XIconURL = "https://static.dezeen.com/uploads/2023/07/x-logo-twitter-elon-musk_dezeen_2364_col_0.jpg",
    DefaultTweetImage = "https://static.dezeen.com/uploads/2023/07/x-logo-twitter-elon-musk_dezeen_2364_col_0.jpg",
    VerificationImage = "https://i.imgur.com/VZ2JNy7.png", -- Verification mark image
    -- Edit colors here please use hex color codes: https://shorturl.at/BDNP6
    LifeinvaderColor = "#00FF00", -- Color for Lifeinvader messages (hex color code)
    NewsColor = "#FFA500", -- Color for news messages (hex color code)
    DotColor = "#FFFF00", -- Color for Dot messages (hex color code)
    InstaColor = "#FFA500", -- Color for news messages (hex color code)
    -- Edit Image/Icon urls here. Please note it'll resize all images to fit the SQUARE Icon.
    LifeinvaderIconURL = "https://i.imgur.com/TNOqF7Q.png", -- Lifeinvader icon image
    NewsIconURL = "https://static.wikia.nocookie.net/gtawiki/images/8/83/Weazel_News.png/revision/latest?cb=20120708181541", -- News icon image
    DotIconURL = "https://pbs.twimg.com/profile_images/932249208433848321/GmIum3vp_400x400.jpg", -- Dot icon image
    InstaIconURL = "https://i.imgur.com/Bmigbv5.png", -- Instagram icon image
    errorIcon = "https://cdn0.iconfinder.com/data/icons/shift-interfaces/32/Error-512.png", -- Replace with the actual URL for the error icon
    successIcon = "https://i.imgur.com/ABXvTus.png", -- Replace with the actual URL for the success icon
    warningIcon = "https://i.imgur.com/dtHAxfU.png", -- Replace with the actual URL for the warning icon
    systemIcon = "https://i.imgur.com/hAvQDmv.png", -- Replace with the actual URL for the system icon
    -- Edit these to include WebHook URLS to where you want LOG's sent to.
    NewsWebhook = "YOUR_DISCORD_WEBHOOK",
    DotWebhook = "YOUR_DISCORD_WEBHOOK",
    InstaWebhook = "https://discordapp.com/api/webhooks/1197248247245320404/nmuXTSnisMO7hQ9VOH9LUFWQ8Cjn4azlbkhEbp4jX7obUaOi0eeoqa8uyZ_bgwViN83U", --
    LifeinvaderWebhook = "https://discordapp.com/api/webhooks/1197248247245320404/nmuXTSnisMO7hQ9VOH9LUFWQ8Cjn4azlbkhEbp4jX7obUaOi0eeoqa8uyZ_bgwViN83U"
}
Settings = {
    Prefix = "^3[^1Police^3] ",
    aceperms = false, 
    Fine = {
        Toggle = true,
        Command = "fine", 
        MaxValue = 1001,  MaxText = "$1000." -- Sets the maximum amount an officer can fine for.
    },
    Ticket = {
        Toggle = true,
        Command = "ticket", 
        MaxValue = 1001,  MaxText = "$1000." -- Sets the maximum amount an officer can ticket for.
    },
    Parking = {
        Toggle = true,
        Command = "parking", 
        MaxValue = 1001,  MaxText = "$1000." -- Sets the maximum amount an officer can issue a parking ticket for.
    },
    Impound = {
        Toggle = true,
        Command = "impound", 
        MaxValue = 0, -- Set to 0 for no fines
        ImpoundLocations = {
            {X = 404.24, Y = -1631.18, Z = 29.29, H = 310.91}, -- First impound location
			{X = 397.54, Y = -1642.8, Z = 29.29, H = 324.64}, -- First impound location
			{X = 400.09, Y = -1644.92, Z = 29.29, H = 316.55}, -- First impound location
			{X = 402.27, Y = -1646.92, Z = 29.29, H = 326.7}, -- First impound location
            -- Add more impound locations here
        }
    },
    fineDepartments = {
        "LSCSO",
        "SASP",
        "SAFR",
        "DOA"
    },
    DiscordLogs = {
        Toggle = true,
        Webhook = 'YOUR_DISCORD_WEBHOOK' -- Be sure to include the webhook link.
    },
    Debug = {
        Toggle = true
    },
}

Logger = {
    use = true,
    generalURL = "YOUR_DISCORD_WEBHOOK",--- Join's/Leaves/
    discordWebHookUrl = "YOUR_DISCORD_WEBHOOK",
    discordWebHookImage = "https://cdn.discordapp.com/attachments/1182385820959784970/1187491272194277386/mylogo.png?ex=6597146d&is=65849f6d&hm=404ba649d949e5d10657215ea7ae782d914a622eeaea4335e0adf9928927bc75&",
    serverName = "KSRP", -- Change to your server's name
    serverIconURL = "https://cdn.discordapp.com/attachments/1182385820959784970/1187491272194277386/mylogo.png?ex=6597146d&is=65849f6d&hm=404ba649d949e5d10657215ea7ae782d914a622eeaea4335e0adf9928927bc75&", -- Replace with your server icon URL
    playerJoinTitle = "Player Joined", -- Customize the title for player joins
    playerJoinColor = 65280, -- Green
    playerLeaveTitle = "Player Left", -- Customize the title for player leaves
    playerLeaveColor = 16711680, -- Red
    playerCommandTitle = "Player used Command", -- Customize the title for player commands
    playerCommandColor = 16776960, -- Yellow
    regularChatTitle = "Game Chat", -- Customize the title for regular chat messages
    regularChatColor = 65535 -- White
}

Filter = {
    words = {
        "profanity1",
        "profanity2"
    },
    return_message = "Your messsage has been blocked, note it will be logged.",
    webhook = "YOUR_DISCORD_WEBHOOK",
    color = 16711680, -- Red color (change as needed)
    avatar_url = "https://previews.123rf.com/images/roxanabalint/roxanabalint1612/roxanabalint161200120/67233292-naughty-grunge-rubber-stamp-on-white-background-vector-illustration.jpg"
}

Languages = {
        commandName = "me",
        commandDescription = "Display an action above your head.",
        commandSuggestion = {{name = "action", help = '"scratch his nose" for example.'}},
        prefix = "says: "
}

SChat = {
    CommandName = "staffchat",
    AcePerm = "admin.permission",
    RefreshTime = 60 -- In Seconds
}

Config.LegalItems = {
    "Flashlight",
    "First Aid Kit",
    "Bottled Water",
    "Notebook",
    "Pen",
    -- Add more legal items as needed
}

Config.IllegalItems = {
    "Firearm",
    "Illegal Substance",
    "Lockpicking Tools",
    "Stolen Goods",
    -- Add more illegal items as needed
}

Jailer = {
    discordWebhook = "YOUR_DISCORD_WEBHOOK",
    maxJailTime = 300, -- Max time in seconds that someone can jail another player.
    jailDistance = 90.0, -- How far can the player go from the Jail coordinates. If the player is further than the set amount they will be teleported back.
    jailCoords = {x = 1680.21, y = 2513.25, z = 44.56, h = 6.53},
    releaseCoords = {x = 1840.22, y = 2608.42, z = 45.58, h = 270.09},
    accessDepartments = {
        "LSCSO",
        "SASP",
        "SAFR",
        "DOA"
    },
}