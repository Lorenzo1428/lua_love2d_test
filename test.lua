local map = require("Map") 
local rayCast = require("raycast")
map = Map:new()
rayCast = Raycast:new()

local arr  = map:Readfile("matrix.txt")

local pos = {
    x = 2.5,
    y = 1.5
}
local alpha = 30
--print(#arr[1])
local ray = rayCast:Cast_complete(arr,pos,alpha,20, 100)

--print(ray[1].x )