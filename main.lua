function love.load()
    _G.a = 10
end

function love.update()
    _G.a = a+1
end

function love.draw()
    --love.graphics.print("Porco dio", 300, 300)
    love.graphics.print(a)
end