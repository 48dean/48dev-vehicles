-- Listen for the /seat command
RegisterCommand("seat", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)

    -- Ensure the player is in a vehicle
    if vehicle == 0 then
        TriggerEvent('ox_lib:notify', {
            title = 'Error',
            description = 'You must be in a vehicle to switch seats.',
            type = 'error'
        })
        return
    end

    -- Check if seat index is provided
    if #args == 0 then
        TriggerEvent('ox_lib:notify', {
            title = 'Error',
            description = 'Please provide a seat index (e.g. /seat 1).',
            type = 'error'
        })
        return
    end

    local seatIndex = tonumber(args[1])

    -- Validate the seat index
    if seatIndex < 1 or seatIndex > 4 then
        TriggerEvent('ox_lib:notify', {
            title = 'Error',
            description = 'Invalid seat index. Please choose a seat between 1 and 4.',
            type = 'error'
        })
        return
    end

    -- Seat mapping based on user input
    local gtaSeatIndex = seatIndex - 1 -- Mapping 1 -> -1 (Driver), 2 -> 0 (Front passenger), etc.

    -- If seatIndex is 1 (driver), we want to map it to seat -1
    if seatIndex == 1 then
        gtaSeatIndex = -1
    else
        gtaSeatIndex = seatIndex - 2
    end

    -- Warp the player into the selected seat
    TaskWarpPedIntoVehicle(playerPed, vehicle, gtaSeatIndex)

    -- Check if the seat switch was successful
    TriggerEvent('ox_lib:notify', {
        title = 'Success',
        description = 'You have successfully switched to seat ' .. seatIndex,
        type = 'success'
    })
end, false)
