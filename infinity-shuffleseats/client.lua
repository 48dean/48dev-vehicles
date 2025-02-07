RegisterCommand("seat", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if vehicle == 0 then
        TriggerEvent('ox_lib:notify', {
            title = 'Error',
            description = 'You must be in a vehicle to switch seats.',
            type = 'error'
        })
        return
    end

    if #args == 0 then
        TriggerEvent('ox_lib:notify', {
            title = 'Error',
            description = 'Please provide a seat index (e.g. /seat 1).',
            type = 'error'
        })
        return
    end

    local seatIndex = tonumber(args[1])

    if seatIndex < 1 or seatIndex > 4 then
        TriggerEvent('ox_lib:notify', {
            title = 'Error',
            description = 'Invalid seat index. Please choose a seat between 1 and 4.',
            type = 'error'
        })
        return
    end

    local gtaSeatIndex = seatIndex - 1 

    if seatIndex == 1 then
        gtaSeatIndex = -1
    else
        gtaSeatIndex = seatIndex - 2
    end

    TaskWarpPedIntoVehicle(playerPed, vehicle, gtaSeatIndex)

    TriggerEvent('ox_lib:notify', {
        title = 'Success',
        description = 'You have successfully switched to seat ' .. seatIndex,
        type = 'success'
    })
end, false)
