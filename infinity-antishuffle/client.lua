local disallowed = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle ~= 0 and GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
            local seatIndex = GetVehiclePedIsTryingToEnter(playerPed)

            if seatIndex ~= -1 and seatIndex ~= 0 then
                disallowed = true
                ClearPedTasksImmediately(playerPed)
            end
        else
            disallowed = false
        end
    end
end)
