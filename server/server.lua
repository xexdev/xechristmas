if not Config.ESXLegacy then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

local activePresent = nil

RegisterCommand(Config.commandName, function(source, args, rawCommand)
    if activePresent then
        chatMessage(source, 'There is already a present on the ground!')
        return
    end

    math.randomseed(GetGameTimer())
    local coords = GetEntityCoords(GetPlayerPed(source))
    local present = Config.presentItems[math.random(1, #Config.presentItems)]
    activePresent = {coords = coords, present = present}
    TriggerClientEvent('xechristmas:createPresent', -1, activePresent)
    chatMessage(-1, 'A wild present has appeared on the map!')
end, true)

RegisterServerEvent('xechristmas:openPresent', function()
    if activePresent then
        local item = activePresent.present.item
        local amount = activePresent.present.amount
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addInventoryItem(item, amount)
        activePresent = nil
        TriggerClientEvent('xechristmas:removePresent', -1)
        chatMessage(-1, GetPlayerName(source) .. ' opened the present and got ' .. item .. '\'s!')
    end
end)

function chatMessage(target, msg)
    TriggerClientEvent('chat:addMessage', target, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.5); border-radius: 3px;">{0}: {1}</div>',
        args = { 'Santa Claus 🎅', msg }
    })
end