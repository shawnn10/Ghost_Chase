-- key.lua
local key = {}
local utils = require("utils")  -- Require the utils module for collision detection

-- Define a list of keys in the game
key.list = {
    { id = "red_key", x = 615, y = 300, width = 20, height = 20, collected = false },
    { id = "blue_key", x = 753, y = 625, width = 20, height = 20, collected = false },
    { id = "green_key", x = 115, y = 700, width = 20, height = 20, collected = false },
    { id = "win", x = 450, y = 850, width = 10, height = 10, collected = false},
}

-- Draw keys that haven't been collected
function key.draw()
    for _, k in ipairs(key.list) do
        if not k.collected then
            love.graphics.setColor(1, 0, 0)  -- Red color for keys
            love.graphics.rectangle("fill", k.x, k.y, k.width, k.height)
        else
            love.graphics.setColor(1, 1, 1)  -- White color for key found text
            love.graphics.print("Key Found!", k.x - 20, k.y - 20)
        end
    end
    love.graphics.setColor(1, 1, 1)  -- Reset color
end

-- Check if the player has collided with a key to collect it
function key.checkCollision(player)
    for _, k in ipairs(key.list) do
        if not k.collected and utils.rectCollision(player.x, player.y, player.width, player.height, k.x, k.y, k.width, k.height) then
            k.collected = true
            player.keys[k.id] = true  -- Add key to player inventory
        end
    end
end


return key
