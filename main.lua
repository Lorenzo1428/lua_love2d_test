function love.load()
    _G.map = require("Map") 
    _G.raycast = require("raycast")

    _G.map = Map:new({size = 10, name = "colle"})
    _G.raycast = Raycast:new()

    _G.arr  = map:Readfile("matrix.txt")
    _G.pos = {
        x = 3.5,
        y = 2.5
    }
    _G.alpha =20
    _G.height = love.graphics.getHeight()
    _G.width = love.graphics.getWidth()
    _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
end

function love.update(dt)
end

function love.draw()
    local pos1, pos2 = {},{}
    love.graphics.points(100.3,100)
    love.graphics.points(100.3,101)
    for i = 0, #ray do
        if ray[#ray-i] ~= -1 then
            pos1.x = (height - ray[#ray - i])/2
            pos2.x = (height + ray[#ray - i])/2
            pos1.y, pos2.y = i ,i 
            love.graphics.setColor(0,0,1)
            love.graphics.line(pos1.y,pos1.x,pos2.y,pos2.x)
            --love.graphics.print(pos.x)
        end
    end
end

function love.keypressed(key, isrepeat)
    if key == "left" then
        if pos.x + 0.1 < #arr then
            pos.x = pos.x - 0.1
            _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
        end
    end
    if key == "right" then
        if pos.x - 0.1 > 1 then 
            pos.x = pos.x + 0.1
            _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
        end
    end
    if key == "up" then
        if pos.y + 0.1 < #arr[1] then
            pos.y = pos.y + 0.1
            _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
        end
    end
    if key == "down" then
        if pos.y - 0.1 > 1 then
            pos.y = pos.y - 0.1
            _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
        end
    end
    if key == "a" then
        if alpha < 360 and alpha > 0 then
            _G.alpha = alpha + 10
        end
        _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
    end

    if key == "d" then
        if alpha < 360 and alpha > 0 then
            _G.alpha = alpha - 10
        end
        _G.ray = raycast:Cast_complete(arr,pos,alpha,width,height)
    end    
end

