local webhookUrl = 'YOUR_WEBHOOK_GOES_HERE' 

RegisterCommand('dv', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 5.0, 0, 70)
        
        if vehicle == 0 then
            TriggerEvent('ox_lib:notify', {
                title = 'Error',
                description = 'You are not near any vehicle!',
                type = 'error'
            })
            return
        end
    end

    local vehicleModel = GetEntityModel(vehicle)
    local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
    
    TriggerServerEvent('deletevehicle:logToDiscord', vehicleName)

    DeleteEntity(vehicle)
        
    TriggerEvent('ox_lib:notify', {
        title = 'Success',
        description = 'The vehicle has been deleted!',
        type = 'success'
    })
end, false)
