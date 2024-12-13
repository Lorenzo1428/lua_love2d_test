Map = {}

--Constructor
function Map:new (t)
    t = t or {}
    setmetatable(t,self)
    self.__index = self
    return t
end

--Methods
function Map:Readfile(filename)
    local file = io.open(filename,"r")
    local arr = {}
    if file then
        --local data = file:read("*a")
        for line in file:lines() do
            local t = {}
            for num in string.gmatch(line, "(%d+)") do
                table.insert(t,num)
            end
            table.insert(arr,t)
        end
    end
    return arr
end

