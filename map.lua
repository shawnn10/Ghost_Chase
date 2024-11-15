-- map.lua
local map = {}

-- Background image
local backgroundImage

-- Define a list of rectangles (obstacles) for the player to navigate
map.obstacles = {
    { x = 0, y = 0, width = 50, height = 800 },
    { x = 850, y = 0, width = 50, height = 800 },
    { x = 50, y = 0, width = 800, height = 50 },
    { x = 350, y = 125, width = 50, height = 275 },
    { x = 350, y = 475, width = 50, height = 275 },
    { x = 500, y = 475, width = 50, height = 275 },
    { x = 500, y = 125, width = 50, height = 275 },
    { x = 50, y = 350, width = 350, height = 50 },
    { x = 550, y = 350, width = 350, height = 50 },
    { x = 50, y = 750, width = 350, height = 50 },
    { x = 500, y = 750, width = 350, height = 50 },
}


-- Load resources for the map
function map.load()
    -- Load the background image
    backgroundImage = love.graphics.newImage("floor.png")
end

-- Draw the map, including a repeating background and obstacles
function map.draw(camera)
    -- Get the background image dimensions
    local bgWidth = backgroundImage:getWidth()
    local bgHeight = backgroundImage:getHeight()

    -- Calculate the starting x and y positions based on the camera position
    local startX = math.floor(camera.x / bgWidth) * bgWidth
    local startY = math.floor(camera.y / bgHeight) * bgHeight

    -- Draw the background in a grid to fill the visible screen area
    for x = startX, startX + love.graphics.getWidth() + bgWidth, bgWidth do
        for y = startY, startY + love.graphics.getHeight() + bgHeight, bgHeight do
            love.graphics.draw(backgroundImage, x, y)
        end
    end

    -- Draw obstacles
    for _, obstacle in ipairs(map.obstacles) do
        love.graphics.setColor(0.3, 0.3, 0.3)  -- Set color for obstacles
        love.graphics.rectangle("fill", obstacle.x, obstacle.y, obstacle.width, obstacle.height)
    end


    love.graphics.setColor(1, 1, 1)  -- Reset color to default
end

return map
