ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

car1,price1 = 'panto',12000
car2,price2 = 't20',18000
car3,price3 = 'akuma',18000
car4,price4 = 'bati2',180001
car5,price5 = 'bati',180002
car6,price6 = 'reaper',180002
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            Citizen.Wait(500)
            FirstSpawnVehicles()
            return 
        end
    end
end)
function spawncarsatstart(x,y,z,h,vehicle)
    ESX.Game.SpawnLocalVehicle(vehicle, vector3(x, y,z), h*1.0, function(veh)
        SetVehicleDoorsLocked(veh, 2)
        SetEntityAsMissionEntity(veh, true, true)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh, true)
        SetVehicleUndriveable(veh, true)
        SetEntityMaxSpeed(veh, 0.0)
    end)
end
function FirstSpawnVehicles()
    local range = 20
    SetAllVehicleGeneratorsActiveInArea(vector3(-43.763 - range, -1097.911 - range, 26.422 - range), vector3(-43.763 + range, -1097.911 + range, 26.422 + range), false, false);
    spawncarsatstart(-49.05, -1100.63, 25.81,40.00,car1)
    spawncarsatstart(-43.58, -1098.32, 25.98,237.50,car2)
    spawncarsatstart(-46.05, -1093.03, 25.82, 82.80,car3)
    spawncarsatstart(-40.04, -1094.94, 25.95, 187.00,car4)
    spawncarsatstart(-44.65, -1103.22, 25.93, 346.12,car5)
    spawncarsatstart(-52.08, -1095.08, 25.98, 203.66,car6)
end
function BuyVehicle(vehicle)
    local vehProps = ESX.Game.GetVehicleProperties(vehicle)
    TriggerServerEvent('gcrp:setownedvehicle', vehProps)
end
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -49.05, -1100.63, 25.81, true) < 4.5 then----------CAR1
            DrawText3D(-49.05, -1100.63, 25.98+0.75,"Press [~g~E~w~] To Buy")
            nearveh = car1
            x,y,z = -49.05, -1100.63, 25.81
            price = price1
            DrawText3D(-49.05, -1100.63, 25.98+0.9,"Price:"..price)
        elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -43.58, -1098.32, 25.98, true) < 4.5 then----------CAR2
            nearveh = car2
            DrawText3D(-43.58, -1098.32, 25.98+0.75,"Press [~g~E~w~] To Buy")
            x,y,z = -43.58, -1098.32, 25.98
            price = price2
            DrawText3D(-43.58, -1098.32, 25.98+0.9,"Price:"..price)
        elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-46.05, -1093.03, 25.82, true) < 4.5 then----------CAR3
            nearveh = car3
            DrawText3D(-46.05, -1093.03, 25.82+0.75,"Press [~g~E~w~] To Buy")
            x,y,z = -46.05, -1093.03, 25.82
            price = price3
            DrawText3D(-46.05, -1093.03, 25.82+0.9,"Price:"..price)
        elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-40.04, -1094.94, 25.95, true) < 4.5 then----------CAR4
            nearveh = car4
            DrawText3D(-40.04, -1094.94, 25.95+0.75,"Press [~g~E~w~] To Buy")
            x,y,z = -40.04, -1094.94, 25.95
            price = price4
            DrawText3D(-40.04, -1094.94, 25.95+0.9,"Price:"..price)
        elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-44.65, -1103.22, 25.93, true) < 4.5 then----------CAR5
            nearveh = car5
            DrawText3D(-44.65, -1103.22, 25.93+0.75,"Press [~g~E~w~] To Buy")
            x,y,z = -44.65, -1103.22, 25.93
            price = price5
            DrawText3D(-44.65, -1103.22, 25.93+0.9,"Price:"..price)
        elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-52.08, -1095.08, 25.98, true) < 4.5 then----------CAR6
            nearveh = car6
            DrawText3D(-52.08, -1095.08, 25.98+0.75,"Press [~g~E~w~] To Buy")
            x,y,z = -52.08, -1095.08, 25.98
            price = price6
            DrawText3D(-52.08, -1095.08, 25.98+0.9,"Price:"..price)
        end
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), x,y,z+0.2, true) < 4.5 then
            if (IsControlJustReleased(1, 51)) then
                ESX.TriggerServerCallback('gc_vehicleshop:buy', function(canbuy)
                    if canbuy then
			plate = exports['gc_vehicleshop']:GeneratePlate()					
                        ESX.Game.SpawnVehicle(nearveh,vector3(-48.6258, -1076.00, 26.10), 60*1.0, function(vehicle)
                            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
			SetVehicleNumberPlateText(vehicle,plate)
                            TriggerServerEvent('garage:addKeys', GetVehicleNumberPlateText(vehicle))
                            BuyVehicle(vehicle)
                        end)
                    end
                end,price)
            end
        end
	end
end)

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
