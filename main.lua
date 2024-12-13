function love.load()
    _G.map = require("Map") 
    _G.a = 10
    _G.map = Map:new({size = 10, name = "colle"})
    
end

function love.update(dt)
    _G.a = a+1
end

function love.draw()
    love.graphics.print(map.size)
    --love.graphics.print(a)
    love.graphics.print("porco dio", 300,300)
end

