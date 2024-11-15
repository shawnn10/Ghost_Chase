-- box.lua
local box = {}
local utils = require("utils")  -- Require the utils module for collision detection

-- Define box in the game
box.list = {
    { x = 50, y = 300, width = 50, height = 50},
    { x = 125, y = 300, width = 50, height = 50},
    { x = 550, y = 300, width = 50, height = 50},
    { x = 601, y = 300, width = 50, height = 50},
    { x = 652, y = 300, width = 50, height = 50},
    { x = 703, y = 300, width = 50, height = 50},
    { x = 754, y = 300, width = 50, height = 50},
    { x = 800, y = 50, width = 50, height = 50},
    { x = 800, y = 105, width = 50, height = 50},
    { x = 800, y = 160, width = 50, height = 50},
    { x = 800, y = 215, width = 50, height = 50},
    { x = 100, y = 700, width = 50, height = 50},
    { x = 200, y = 700, width = 50, height = 50},
    { x = 300, y = 700, width = 50, height = 50},
    { x = 100, y = 600, width = 50, height = 50},
    { x = 200, y = 600, width = 50, height = 50},
    { x = 300, y = 600, width = 50, height = 50},
    { x = 100, y = 500, width = 50, height = 50},
    { x = 200, y = 500, width = 50, height = 50},
    { x = 300, y = 500, width = 50, height = 50},
}

-- Draw boxes
function box.draw()
    for _, b in ipairs(box.list) do
        love.graphics.setColor(0.3, 0.2, 0)  -- Dark red for boxes
        love.graphics.rectangle("fill", b.x, b.y, b.width, b.height)
    end
    love.graphics.setColor(1, 1, 1)  -- Reset color
end


return box
