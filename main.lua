function love.load()
    _G.map = require("Map") 
    _G.raycast = require("raycast")

    _G.map = Map:new({size = 10, name = "colle"})
    _G.raycast = Raycast:new()

    local arr  = map:Readfile("matrix.txt")
    _G.pos = {
        x = 4.5,
        y = 3.5
    }
    _G.alpha = 20
    _G.height = love.graphics.getHeight()
    _G.width = love.graphics.getWidth()
    _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
end

function love.update(dt)

end

function love.draw()
    local pos1, pos2 = {},{}
    for i = 0, #ray do
        pos1.x = (height - ray[i])/2
        pos2.x = (height + ray[i])/2
        pos1.y, pos2.y = i ,i 
        love.graphics.line(pos1.x,pos1.y,pos2.x,pos2.y)
    end
end

