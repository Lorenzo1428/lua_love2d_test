local map = require("Map") 
local rayCast = require("raycast")
map = Map:new()
rayCast = Raycast:new()

local arr  = map:Readfile("matrix.txt")

local pos = {
    x = 3.5,
    y = 1.5
}
local alpha = 20
local ray = rayCast:Cast_complete(arr,pos,alpha,50, 100)

--print(ray[1].x )