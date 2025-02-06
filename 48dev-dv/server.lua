RegisterNetEvent('deletevehicle:logToDiscord')
AddEventHandler('deletevehicle:logToDiscord', function(vehicleName)
    local webhookUrl = 'https://discord.com/api/webhooks/1336448357249323018/b_uxNRIdyIrxKse4fpHpCvJ0WFCMRcu3gyurVOzBNb0-kbLVsmSWAXa2CzuHjUsePUrF' -- Replace with your Discord webhook

    -- Log the vehicle deletion to Discord
    PerformHttpRequest(webhookUrl, function(err, text, headers) end, 'POST', json.encode({
        username = "Vehicle Deletion",
        content = "",
        embeds = {
            {
                title = "Vehicle Deleted",
                description = "A vehicle was deleted by a player.",
                color = 14177041,
                fields = {
                    {
                        name = "Vehicle Model",
                        value = vehicleName,
                        inline = true
                    },
                    {
                        name = "Player Name",
                        value = GetPlayerName(source),
                        inline = true
                    }
                }
            }
        }
    }), { ['Content-Type'] = 'application/json' })
end)
