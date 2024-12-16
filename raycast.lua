Raycast = {
    fov = 60
}

    --Constructor
    function Raycast:new (t)
        t = t or {}
        setmetatable(t,self)
        self.__index = self
        return t
    end

    function Raycast:Cast(map_table, pos, alpha, screen_width)
        local rate = self.fov/screen_width
        local alpha_i = 0
        local rays = {}
        for i = 0,screen_width do
            alpha_i = alpha + i*rate
            rays[i] = self:Horizontal_Cast(map_table,pos,alpha_i)
            print(rays[i].x,rays[i].y)
        end
        return rays
    end

    function Raycast:Horizontal_Cast(map_table,pos,alpha)
        local ray = {}
        local x0,y0 = 0 , 0
        if alpha >= 0 and alpha < 90 then
            local tg = math.tan(math.rad(alpha))
            local floor_x = math.floor(pos.x)
            x0 = pos.x - floor_x
            y0 = x0/tg + pos.y
            if map_table[floor_x][math.floor(y0)] == "1" then
                ray.x = floor_x
                ray.y = y0
            elseif floor_x ~= 1 then
                local yn = y0
                for i = floor_x - 1 , 1, -1 do
                    yn = 1/tg + yn
                    --print(i,yn)
                    if map_table[i][math.floor(yn)] == "1" then
                        ray.x = i
                        ray.y = yn
                        return ray
                    else
                        ray.x = -1
                        ray.y = -1
                    end
                end
            end
            return ray
        elseif alpha > 90 and alpha < 180 then
            local tg = math.tan(math.rad(180 - alpha))
            local floor_x = math.floor(pos.x)
            x0 = pos.x - floor_x
            y0 = pos.y - x0/tg

            if map_table[floor_x][math.floor(y0)] == "1" then
                ray.x = floor_x
                ray.y = y0
                
            elseif floor_x ~= 1 then
                local yn = y0
                for i = floor_x + 1, 1, -1 do 
                    yn = yn - 1/tg
                    if map_table[i][math.floor(yn)] == "1" then
                        ray.x = i
                        ray.y = yn
                    end
                end
            end
            return ray
        elseif alpha > 180 and alpha < 270 then
            local tg = math.tan(math.rad(alpha - 180))
            local ceil_x = math.ceil(pos.x)
            x0 = ceil_x - pos.x
            y0 = pos.y - x0/ tg

            if map_table[ceil_x][math.ceil(y0)] == "1" then
                ray.x = ceil_x
                ray.y = y0
            elseif ceil_x ~= #map_table  then
                local yn = y0
                for i = ceil_x + 1, #map_table do
                    yn = yn - 1/tg
                    if map_table[i][math.ceil(yn)]== "1" then
                        ray.x = i
                        ray.y = yn
                    end
                end
            end    
            return ray
        else
            local tg = math.tan(math.rad(360 - alpha))
            local ceil_x = math.ceil(pos.x)
            x0 = ceil_x - pos.x
            y0 = x0/tg + pos.y
            
            if map_table[ceil_x][math.ceil(y0)] == "1" then
                ray.x = ceil_x
                ray.y = y0
            elseif ceil_x ~= map_table then
                local yn = 0
                for i = ceil_x + 1, #map_table do
                    yn = yn + 1/tg
                    if map_table[i][math.ceil(yn)] == "1" then
                        ray.x = i
                        ray.y = yn
                    end
                end
            end
            return ray
        end
    end