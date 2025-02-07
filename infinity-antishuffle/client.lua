local disallowed = false

-- Call the function from functions.lua to handle seat shuffling prevention
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        -- Check if the player is in a vehicle and is not the driver
        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
            local seatIndex = GetVehiclePedIsTryingToEnter(playerPed)

            -- If the player is trying to swap seats, cancel the action
            if seatIndex ~= -1 and seatIndex ~= 0 then
                disallowed = true
                ClearPedTasksImmediately(playerPed)
            end
        else
            disallowed = false
        end
    end
end)
