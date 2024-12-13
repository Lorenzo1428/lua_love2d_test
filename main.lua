function love.load()
    _G.map = require("Map") 
    _G.map = Map:new({size = 10, name = "colle"})
    
end

function love.update(dt)
end

function love.draw()
    love.graphics.print(map.size)
end

