-- camera.lu
-- this code i found online in the love2d forum pages
local camera = {}

-- Camera position
camera.x = 0
camera.y = 0

-- Update the camera position to follow the player
function camera.update(player)
    -- Center the camera on the player
    camera.x = player.x - love.graphics.getWidth() / 2
    camera.y = player.y - love.graphics.getHeight() / 2
end

-- Apply camera transformations
function camera.apply()
    love.graphics.push()  -- Save the current coordinate system
    love.graphics.translate(-camera.x, -camera.y)  -- Move the world in the opposite direction of the camera
end

-- Reset camera transformations after drawing
function camera.reset()
    love.graphics.pop()  -- Restore the previous coordinate system
end

return camera
