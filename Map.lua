Map = {
    size = 0,
    name = ""
}

--Constructor
function Map:new (t)
    t = t or {}
    setmetatable(t,self)
    self.__index = self
    return t
end

--Methods
function Map:method()

end

