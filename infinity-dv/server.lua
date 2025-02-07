RegisterNetEvent('deletevehicle:logToDiscord')
AddEventHandler('deletevehicle:logToDiscord', function(vehicleName)
    local webhookUrl = 'YOUR_WEBHOOK_GOES_HERE' 


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
