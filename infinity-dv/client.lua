local webhookUrl = 'https://discord.com/api/webhooks/1336448357249323018/b_uxNRIdyIrxKse4fpHpCvJ0WFCMRcu3gyurVOzBNb0-kbLVsmSWAXa2CzuHjUsePUrF' -- Replace with your Discord webhook

-- Register the command to delete the vehicle as "dv"
RegisterCommand('dv', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    -- Check if the player is inside a vehicle
    if vehicle == 0 then
        -- Player is not in a vehicle, try to check for a nearby vehicle
        vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 5.0, 0, 70)
        
        if vehicle == 0 then
            -- No vehicle found nearby
            TriggerEvent('ox_lib:notify', {
                title = 'Error',
                description = 'You are not near any vehicle!',
                type = 'error'
            })
            return
        end
    end

    -- If a vehicle is found, delete it
    local vehicleModel = GetEntityModel(vehicle)
    local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
    
    -- Log the vehicle deletion to Discord (send to server for logging)
    TriggerServerEvent('deletevehicle:logToDiscord', vehicleName)

    -- Delete the vehicle
    DeleteEntity(vehicle)

    -- Notify the player
    TriggerEvent('ox_lib:notify', {
        title = 'Success',
        description = 'The vehicle has been deleted!',
        type = 'success'
    })
end, false)
