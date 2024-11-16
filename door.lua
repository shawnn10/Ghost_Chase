-- door.lua
--gpt help with door and from this i made keys and boxes
local door = {}
local utils = require("utils")  -- Require the utils module for collision detection

-- Define doors in the game
door.list = {
    { id = "red_key", x = 350, y = 400, width = 50, height = 75, locked = true },
    { id = "blue_key", x = 500, y = 50, width = 50, height = 75, locked = true },
    { id = "green_key", x = 400, y = 750, width = 100, height = 50, locked = true},
}

-- Draw doors, coloring locked doors differently
function door.draw()
    for _, d in ipairs(door.list) do
        if d.locked then
            love.graphics.setColor(0.5, 0, 0)  -- Dark red for locked doors
        else
            love.graphics.setColor(0, 0.5, 0)  -- Green for unlocked doors
        end
        love.graphics.rectangle("fill", d.x, d.y, d.width, d.height)
    end
    love.graphics.setColor(1, 1, 1)  -- Reset color
end

-- Check for door unlocking
function door.unlock(player)
    for _, d in ipairs(door.list) do
        if d.locked and player.keys[d.id] then
            if utils.rectCollision(player.x, player.y, player.width, player.height, d.x, d.y, d.width, d.height) then
                d.locked = false  -- Unlock the door if the player has the key
            end
        end
    end
end

-- Check if player can pass through unlocked doors
function door.checkCollision(player)
    for _, d in ipairs(door.list) do
        if d.locked and utils.rectCollision(player.x, player.y, player.width, player.height, d.x, d.y, d.width, d.height) then
            return false  -- Player can't pass through a locked door
        end
    end
    return true
end

return door
