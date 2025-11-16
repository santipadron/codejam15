-- Importing libraries used for drawCircleAtPoint and crankIndicator
import "CoreLibs/object"
import "background"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics


class("DockScene").extends(gfx.sprite)

function DockScene:init()
    setupGameBackground()
    self:add()
end