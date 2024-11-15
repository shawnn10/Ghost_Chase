-- ghost.lua
local ghost = {}

function ghost.load()
    -- Initialize ghost properties
    ghost.x = 600              -- Starting x position
    ghost.y = 400              -- Starting y position
    ghost.speed = 100          -- Speed of the ghost
    ghost.width = 40           -- Width of the ghost
    ghost.height = 40          -- Height of the ghost
end

function ghost.update(dt, player)
    -- stops ghost ai if player already won
    if player.won then return end

    -- Calculate direction vector towards the player
    local dx = player.x - ghost.x
    local dy = player.y - ghost.y
    local distance = math.sqrt(dx * dx + dy * dy)

    -- Normalize direction and move towards the player
    if distance > 0 then
        dx = dx / distance
        dy = dy / distance

        -- Move ghost towards the player
        ghost.x = ghost.x + dx * ghost.speed * dt
        ghost.y = ghost.y + dy * ghost.speed * dt
    end

    -- Check for collision with the player
    if ghost.checkCollision(player) then
        player.dead = true  -- Mark the player as dead on collision
    end
end

-- Check for collision with the player
function ghost.checkCollision(player)
    return player.x < ghost.x + ghost.width and
           player.x + player.width > ghost.x and
           player.y < ghost.y + ghost.height and
           player.y + player.height > ghost.y
end

function ghost.draw()
    love.graphics.setColor(0.5, 0.5, 1, 0.7)  -- Light blue and semi-transparent
    love.graphics.rectangle("fill", ghost.x, ghost.y, ghost.width, ghost.height)
    love.graphics.setColor(1, 1, 1)           -- Reset color
end

return ghost
