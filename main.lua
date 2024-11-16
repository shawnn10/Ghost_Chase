-- main.lua
--gpt helped me error check main but honastly it mostly just help catch spelling errors
local player = require("player")
local map = require("map")
local camera = require("camera")
local key = require("key")
local door = require("door")
local box = require("box")
local ghost = require("ghost")

function love.load()
    player.load()
    map.load()
    ghost.load()
end

function love.update(dt)
    player.update(dt, map, ghost)  -- Pass map to player for collision detection and ghost for overlay
    ghost.update(dt, player)  -- Update ghost to chase the player
    camera.update(player)   -- Update camera based on player position (pass player, not dt)

    -- Check for key collisions to collect them
    key.checkCollision(player)
    
    -- Check if the player has won
    player.checkWinCondition()

    -- If the player has not won, proceed with other updates
    if not player.won then
        door.unlock(player)
        
        -- Check if player collides with locked doors
        if not door.checkCollision(player) then
            player.x = player.previousX
            player.y = player.previousY
        else
            player.previousX = player.x
            player.previousY = player.y
        end
    end
end

function love.draw()
    camera.apply()          -- Start camera transformation
    map.draw(camera)        -- Draw the map with the background and obstacles
    key.draw()              -- Draw keys
    box.draw()              -- Draw boxes
    door.draw()             -- Draw doors
    ghost.draw()            -- Draw ghost
    player.draw()           -- Draw the player
    camera.reset()          -- Reset camera transformation
end
