-- utils.lua
local utils = {}

-- Function to check if two rectangles overlap
--gpt this worked out of the box i was quite happy
function utils.rectCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x1 + w1 > x2 and
           y1 < y2 + h2 and
           y1 + h1 > y2
end

return utils
