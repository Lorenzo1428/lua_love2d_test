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
    
    function Raycast:Cast_complete(map_table,pos,alpha,screen_width,screen_height)
        local ray = Raycast:Cast(map_table,pos,alpha,screen_width)
        local dist = Raycast:GetDist(pos,ray,screen_height)
        return dist
    end

    function Raycast:GetDist(pos,rays,screen_height)
        local dist = {}
        local h = 0
        for i = 0, #rays do
            h = self:dist(rays[i],pos)
            dist[i] = h * math.cos(rays[i].z)
            dist[i] = screen_height/dist[i]
            --print(dist[i])
        end
        return dist
    end

    function Raycast:dist(pos1,pos2)
        if pos1.x == -1 or pos2.x == -1 then
            return 1e13
        end
        local q1 = (pos1.x - pos2.x)^2
        local q2 = (pos1.y - pos2.y)^2
        local dist  = math.sqrt(q1 + q2)
        return dist
    end

    function Raycast:Cast(map_table, pos, alpha, screen_width)
        local rate = self.fov/screen_width
        local alpha_i = 0
        local rays_h = {}
        local rays_v = {}
        local rays = {}
        for i = 0,screen_width do
            alpha_i = alpha + i*rate
            rays_h[i] = self:Horizontal_Cast(map_table,pos,alpha_i)
            rays_v[i] = self:Vertical_Cast(map_table,pos,alpha_i)

            if Raycast:dist(rays_h[i],pos) < Raycast:dist(rays_v[i],pos) then
                rays[i] = rays_h[i]
            else
                rays[i] = rays_v[i]
            end
            --print("Horiziontal: " .. rays_h[i].x,rays_h[i].y,"Vertical: " .. rays_v[i].x, rays_v[i].y)
            print(rays[i].x,rays[i].y)
        end
        return rays
    end

    function Raycast:Horizontal_Cast(map_table,pos,alpha)
        local ray = {}
        local x0,y0 = 0 , 0
        local tg, alpha_deg = 0, 0
        local ceil_x , floor_x = 0 , 0
        if alpha > 0 and alpha < 90 then
            alpha_deg = math.rad(alpha)
            tg = math.tan(alpha_deg)
            ray.z = alpha_deg
            floor_x = math.floor(pos.x)
            x0 = pos.x - floor_x
            y0 = x0/tg + pos.y
            if math.floor(y0) < #map_table[1] and map_table[floor_x][math.floor(y0)] == "1" then
                ray.x = floor_x
                ray.y = y0
                return ray
            elseif floor_x ~= 1 then
                local yn = y0
                for i = floor_x - 1 , 1, -1 do
                    yn = 1/tg + yn
                    --print(i,yn)
                    if math.floor(yn) < #map_table[1] and map_table[i][math.floor(yn)] == "1" then
                        ray.x = i
                        ray.y = yn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        elseif alpha > 90 and alpha < 180 then
            alpha_deg = math.rad(180 - alpha)
            tg = math.tan(alpha_deg)
            ray.z = alpha_deg
            floor_x = math.floor(pos.x)
            x0 = pos.x - floor_x
            y0 = pos.y - x0/tg

            if math.floor(y0) > 1 and map_table[floor_x][math.floor(y0)] == "1" then
                ray.x = floor_x
                ray.y = y0
                return ray
            elseif floor_x ~= 1 then
                local yn = y0
                for i = floor_x - 1, 1, -1 do 
                    yn = yn - 1/tg
                    if math.floor(yn) > 1 and map_table[i][math.floor(yn)] == "1" then
                        ray.x = i
                        ray.y = yn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        elseif alpha > 180 and alpha < 270 then
            alpha_deg = math.rad(alpha - 180)
            tg = math.tan(alpha_deg)
            ray.z = alpha_deg
            ceil_x = math.ceil(pos.x)
            x0 = ceil_x - pos.x
            y0 = pos.y - x0/ tg

            if math.floor(y0) > 1 and map_table[ceil_x][math.floor(y0)] == "1" then
                ray.x = ceil_x
                ray.y = y0
                return ray
            elseif ceil_x ~= #map_table  then
                local yn = y0
                for i = ceil_x + 1, #map_table do
                    yn = yn - 1/tg
                    if math.floor(yn) > 1 and map_table[i][math.floor(yn)]== "1" then
                        ray.x = i
                        ray.y = yn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        elseif alpha > 270 and alpha < 360 then
            alpha_deg = math.rad(360 - alpha)
            tg = math.tan(alpha_deg)
            ray.z = alpha_deg
            ceil_x = math.ceil(pos.x)
            x0 = ceil_x - pos.x
            y0 = x0/tg + pos.y
            
            if math.floor(y0) < #map_table[1] and map_table[ceil_x][math.floor(y0)] == "1" then
                ray.x = ceil_x
                ray.y = y0
                return ray
            elseif ceil_x ~= map_table then
                local yn = x0
                for i = ceil_x + 1, #map_table do
                    yn = yn + 1/tg
                    if math.floor(yn) < #map_table[1] and map_table[i][math.floor(yn)] == "1" then
                        ray.x = i
                        ray.y = yn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        else 
            ray.x = -1
            ray.y = -1
        end
    end

    function Raycast:Vertical_Cast(map_table,pos,alpha)
        local ray = {}
        local x0,y0 = 0 , 0
        local tg, alpha_deg = 0,0
        local ceil_y, floor_y = 0,0
        if alpha > 0 and alpha < 90 then
            alpha_deg = math.rad(alpha)
            tg = math.tan(alpha_deg)
            ray.z = alpha_deg
            ceil_y = math.ceil(pos.y)
            y0 = ceil_y - pos.y
            x0 = pos.x - y0*tg
            if math.floor(x0) > 1 and map_table[math.floor(x0)][ceil_y] == "1" then
                ray.y = ceil_y
                ray.x = x0
                return ray
            elseif ceil_y ~= #map_table[1] then
                local xn = x0
                for i = ceil_y + 1 , #map_table[1] do
                    xn = xn - tg
                    if math.floor(xn) > 1 and map_table[math.floor(xn)][i] == "1" then
                        ray.y = i
                        ray.x = xn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        elseif alpha > 90 and alpha < 180 then
            alpha_deg = math.rad(180 - alpha)
            tg = math.tan(math.rad(180 - alpha))
            ray.z = alpha_deg
            floor_y = math.floor(pos.y)
            y0 = pos.y - floor_y
            x0 = pos.x - y0*tg

            if math.floor(x0) > 1 and map_table[math.floor(x0)][floor_y] == "1" then
                ray.y = floor_y
                ray.x = x0
                return ray
            elseif floor_y ~= 1 then
                local xn = x0
                for i = floor_y - 1, 1, -1 do 
                    xn = xn - 1*tg
                    if math.floor(xn) > 1 and map_table[math.floor(xn)][i] == "1" then
                        ray.y = i
                        ray.x = xn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        elseif alpha > 180 and alpha < 270 then
            alpha_deg = math.rad(alpha - 180)
            tg = math.tan(alpha_deg)
            ray.z = alpha_deg
            floor_y = math.floor(pos.y)
            y0 = pos.y - floor_y 
            x0 = pos.y + y0*tg

            if math.floor(x0) < #map_table and map_table[math.floor(x0)][floor_y] == "1" then
                ray.y = floor_y
                ray.x = x0
                return ray
            elseif floor_y ~= 1  then
                local xn = x0
                for i = floor_y - 1, 1, -1 do
                    xn = xn + 1*tg
                    if math.floor(xn) < map_table and map_table[math.floor(xn)][i] == "1" then
                        ray.y = i
                        ray.x = xn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        elseif alpha > 270 and alpha < 360 then
            alpha_deg = math.rad(360 - alpha)
            tg = math.tan(alpha_deg)
            ray.z = alpha_deg
            ceil_y = math.ceil(pos.y)
            y0 = ceil_y - pos.y
            x0 = y0*tg + pos.x
            
            if math.floor(x0) < #map_table and map_table[math.floor(x0)][ceil_y] == "1" then
                ray.y = ceil_y
                ray.x = x0
                return ray
            elseif ceil_y ~= map_table[1] then
                local xn = x0
                for i = ceil_y + 1, #map_table[1] do
                    xn = xn + 1/tg
                    if math.floor(xn) < #map_table and map_table[math.floor(xn)][i] == "1" then
                        ray.y = i
                        ray.x = xn
                        return ray
                    end
                end
            end
            ray.x = -1
            ray.y = -1
            return ray
        else
            ray.x = -1
            ray.y = -1
            return ray
        end
    end    