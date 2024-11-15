-- player.lua
local player = {}
local utils = require("utils")  -- Import utils for collision checks

function player.load()
    -- Initialize player properties
    player.x = 100          -- Starting x position
    player.y = 100          -- Starting y position
    player.speed = 250      -- Speed of the player
    player.width = 50       -- Width of the player
    player.height = 50      -- Height of the player
    player.keys = {}        -- Table to store collected keys
    player.dead = false     -- Player starts alive
    player.won = false      -- Add this to track if the player has won

    overlayImage = love.graphics.newImage("overlay.png")
    overlayImage_two = love.graphics.newImage("overlay2.png")
    overlayScale = 10
    overlayRotation = 0
    baseOverlayRotationSpeed = 0.01  -- Base rotation speed
    baseOverlayScale = 50            -- Base overlay scale
end

function player.checkWinCondition()
    local requiredKeys = {"red_key", "blue_key", "green_key", "win"}
    for _, keyID in ipairs(requiredKeys) do
        if not player.keys[keyID] then
            return false
        end
    end
    player.won = true  -- Set the win flag when all keys are collected
    return true
end

function player.update(dt, map, ghost)

    if player.dead or player.won then return end  -- Stop movement if dead

    -- Basic player movement with collision checks
    local moveX, moveY = 0, 0

    if love.keyboard.isDown("right") then
        moveX = player.speed * dt
    elseif love.keyboard.isDown("left") then
        moveX = -player.speed * dt
    end

    if love.keyboard.isDown("down") then
        moveY = player.speed * dt
    elseif love.keyboard.isDown("up") then
        moveY = -player.speed * dt
    end

    -- Check for collision in the x-direction
    local newX = player.x + moveX
    local canMoveX = true
    for _, obstacle in ipairs(map.obstacles) do  -- Access map.obstacles here
        if utils.rectCollision(newX, player.y, player.width, player.height, obstacle.x, obstacle.y, obstacle.width, obstacle.height) then
            canMoveX = false
            break
        end
    end
    if canMoveX then
        player.x = newX
    end

    -- Check for collision in the y-direction
    local newY = player.y + moveY
    local canMoveY = true
    for _, obstacle in ipairs(map.obstacles) do  -- Access map.obstacles here
        if utils.rectCollision(player.x, newY, player.width, player.height, obstacle.x, obstacle.y, obstacle.width, obstacle.height) then
            canMoveY = false
            break
        end
    end
    if canMoveY then
        player.y = newY
    end

    -- Adjust overlay rotation speed and scale based on distance to ghost
    local dx = player.x - ghost.x
    local dy = player.y - ghost.y
    local distance = math.sqrt(dx * dx + dy * dy)

    -- Set limits for min and max scaling effects
    local minScale = 3
    local maxScale = baseOverlayScale
    local minRotationSpeed = 0.05
    local maxRotationSpeed = 1

    -- Map distance to scale and rotation speed
    overlayScale = math.max(minScale, maxScale - (maxScale - minScale) * (1 / (distance / 100)))
    overlayRotationSpeed = math.min(maxRotationSpeed, baseOverlayRotationSpeed + (maxRotationSpeed - baseOverlayRotationSpeed) * (1 / (distance / 100)))


    -- Rotate the overlay over time
    overlayRotation = overlayRotation + overlayRotationSpeed * dt
end

function player.draw()
    -- Get the center of the overlay image
    local originX = overlayImage:getWidth() / 2
    local originY = overlayImage:getHeight() / 2

    function player.draw()
        if player.dead then
            love.graphics.setColor(1, 0, 0)
            love.graphics.print("Game Over", player.x - 20, player.y - 20)
        elseif player.won then
            love.graphics.setColor(0, 1, 0)
            love.graphics.print("You Win!", player.x - 20, player.y - 20)
        else
            -- Draw player as usual
            love.graphics.draw(overlayImage, player.x + 25, player.y + 25, (overlayRotation * 1), overlayScale, overlayScale, originX, originY)
            love.graphics.draw(overlayImage_two, player.x + 25, player.y + 25, (overlayRotation * -1), overlayScale, overlayScale, originX, originY)
            love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
        end
    end
    
end

return player
