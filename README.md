# Stoic Chat Resource

![Untitled (250 × 250 px)](https://dunb17ur4ymx4.cloudfront.net/packages/images/5d4530946e2d881948ab5f97de5e2101aa428679.png)


Thank you for choosing 5M-CodeX Chat Resource! This README.md document provides detailed instructions on how to edit the configuration file to tailor the chat experience to your preferences and requirements.

## Table of Contents

- [Introduction](#introduction)
- [Configuration Overview](#configuration-overview)
- [Editing Configuration](#editing-configuration)
- [Languages](#languages)
- [Settings](#settings)
- [Installation](#Installation)
- [Additional Information](#Notes)

- Note this is a Project.
This is still being developed, fixed, and optimized, yet I do need some input from the community / people to test, therefore I would greatly appreciate any feedback :slight_smile: 

### ND-Framework is required for some resource to work right as of now.

--------------------------------

## Configuration Overview

The configuration file, named `config.lua`, includes various customizable sections:

- General settings such as language, text color, font, and display duration.
- Customization for specific chat commands like `/darkweb`, `/rto`, `/911`, and `/panic`.
- Configuration for chat tags, staff chat, and toggling specific commands.
- Custom URLs for commands and default tags for players without permissions.
- In-game chat settings and Discord webhook settings.

--------------------------

## Editing Configuration

| **Section**                  | **Description and Instructions**                                                                                            |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **General Settings**         | - `language`: Choose the language for chat messages.                                                                       |
|                              | - `color`: Set the text color using RGBA values.                                                                          |
|                              | - `font`: Choose the text font.                                                                                           |
|                              | - `time`: Duration to display the text (in ms).                                                                          |
|                              | - `scale`: Set the text scale.                                                                                            |
|                              | - `dist`: Minimum distance to draw text.                                                                                 |
| **/darkweb Command**         | - `canNotSee`: Specify departments that can't see the /darkweb command.                                                  |
| **/rto Command**             | - `canNotSee`: Specify departments that can't see the /rto command.                                                      |
| **/911 Command**             | - `callTo`: Specify departments that can see the /911 command.                                                            |
| **/panic Command**           | - `ignoreDepartments`: Ignore departments for the /panic command. Set to `true` or `false`.                               |
|                              | - `callTo`: Specify departments that can see the /panic command.                                                          |
| **Chat Tags**                | - Configure different tags with permissions and image URLs.                                                              |
| **Staff Chat**               | - `StaffChat`: Set the permission required for staff chat.                                                                |
|                              | - `ProxDist`: Set the proximity distance for staff chat.                                                                 |
| **Custom URLs for Commands**  | - Add URLs for different commands (e.g., Dispatch, Me, Do).                                                               |
| **Default Tag**              | - Set a default tag for players without permissions.                                                                     |
| **Enable/Disable Commands**   | - Toggle commands on/off by setting `true` or `false`.                                                                    |
| **Ingame Chat Settings**     | - Customize chat formats for different commands.                                                                         |
| **Discord Webhook Settings**  | - Set the Discord webhook link and server name.                                                                          |

--------------------------

### Chat Commands

- `/fine <id> <amount> <reason>`: Deducts money from the targeted player for the specified fine amount.
- `/ticket <id> <amount> <reason>`: Deducts money from the targeted player for the specified ticket amount.
- `/parking <id> <amount> <reason>`: Deducts money from the targeted player for the specified parking ticket amount.
- `/impound`: Impounds the closest vehicle in front of you. Requires appropriate permission.
- `/911`: Only LEO & SAFR/LSFD departments can see this command after being inputted.
- `/me`: It says your character name and job in the chat.
- `/do`: It says your character name and job in the chat.
- `/gme`: It says your character name and job in the chat.
- `/twt`: It says your chosen twitter name in the chat.
- `/darkweb`: No Departments (LEO & LSFD can see this nor do the command.
- `/rto`: Only LEO & SAFR/LSFD departments can see this command. It is used for less important transmissions.
- `/panic`: This will broadcast a Blip on every Department you set, flash for 60 seconds, and play a sound for 10 seconds, and you can press [Y] to add a waypoint to them.
- `/x`: Tweet in-Game and on Discord.
- `/dispatch [message]`: Send a message to the dispatch channel.

### Social Media Commands

These commands send messages with specific styles:

- `/x Post Details`: Send a tweet-like message.
- `/fbmarket [message]`: Send a message to the FB Market.
- `/news [message]`: Send a news headline.
- `/insta [message]`: Post an Instagram-style message.
- `/dot [message]`: Post a dot message.

--------------------------

### AcePermissions [SOON]

These commands send messages with specific styles:

- `CXJail.Allow`: Allows /
- `CX911.Allow`: Allows /
- `CXTow.Allow`: Allows /
- `CXPanic.Allow`: Allows /
- `CXFine.Allow`: Allows /
- `CXParking.Allow`:Allows /
- `CXImpound.Allow`:Allows /
- `CXPanic.Allow`: Allows /
- ``: Allows /
--------------------------


## Installation

1. **Download the Resource:**
   - Download the Stoic-Chat Chat Resource from the provided source.

2. **Install the Resource:**
   - Place the resource `Stoic-Chat` into your resources folder..

3. **Configure to your hearts desire:**

Installation is complete! Restart or refresh your FiveM server to apply changes and enjoy the enhanced communication experience with the 5M-CodeX Chat Resource.


## Requirments
- [oxlib](https://github.com/overextended/ox_lib)
- [ND_Core](https://github.com/ND-Framework/ND_Core)
  - [ND_Characters](https://github.com/ND-Framework/ND_Characters)
- [Stoic-IDHandler](https://github.com/TheStoicBear/Stoic-IDHandler)

--------------------------

### Notes
If you wish to have Department checks work, and money deduction work please use the following below.

All chat Bubbles are HTML templates therefore are extremely customizable.
All tags are capable of supporting GIF, PNGs, JPG.

## If you want to block Chat Images, add `<img` to profanity filter.



-------


### Which also has everything from 
- CodeX Feed 
 - https://forum.cfx.re/t/free-5m-codex-feed

------------

https://www.youtube.com/watch?v=yS4r13MCwYg

------------

- Copy YouTube Link If link above doesn't work.
`https://www.youtube.com/watch?v=yS4r13MCwYg`
# Project.
https://github.com/5M-CodeX/codex-chat/






