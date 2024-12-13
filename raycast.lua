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

    function Raycast: Cast(map_table, pos, alpha, screen_width)
        local rate = self.fov/screen_width
        local alpha_i = 0
        local rays = {}
        for i = 0,screen_width do
            alpha_i = alpha + i*rate
            rays[i] = self.Horizontal_Cast(map_table,pos,alpha_i)
            
        end
    end

    function Raycast:Horizontal_Cast(map_table,pos,alpha)
        local tg = math.tan(alpha)
        local floor_x = math.floor(pos.x)
        local ray = {}
        local x0,y0 = 0 , 0
        if alpha >= 0 and alpha < 45 then
            x0 = pos.x - floor_x
            y0 = x0 * tg + pos.y

            if map_table(floor_x,math.floor(y0)) == 1 then
                ray.x = x0
                ray.y = y0
                return ray
            
            else if floor_x ~= 0 then
                local yn = y0
                for i = floor_x +1 , 1, -1 do
                    yn = yn + tg
                    if map_table(i,math.floor(yn)) == 1 then
                        ray.x = i
                        ray.y = yn
                        return ray
                    end
                end
            end

            end
        end
    end
