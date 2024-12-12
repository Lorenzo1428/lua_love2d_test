function love.load()
    _G.a = 10
    
end

function love.update(dt)
    _G.a = a+1
end

function love.draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    love.graphics.circle("fill",w/2,h/2,40)
    love.graphics.print(a)
end