ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("gc_vehicleshop:buy", function(source,cb,price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney()>=price then
        cb(true)
        xPlayer.removeMoney(price)
    else
        cb(false)
        TriggerClientEvent("esx:showNotification",_source,"You don't have enough money!")
    end
end)
RegisterServerEvent('gcrp:setownedvehicle')
AddEventHandler('gcrp:setownedvehicle', function(vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function(rowsChanged)
		xPlayer.showNotification('U Bought A New Vehicle', vehicleProps.plate)
	end)
end)