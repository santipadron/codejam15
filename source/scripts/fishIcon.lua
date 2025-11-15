import "CoreLibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('FishIcon').extends(gfx.sprite)

function FishIcon:init(x,y,image)
    self.x = x
    self.y = y
    self:moveTo(x,y)
    self:setImage(image)
    self:setCollideRect(0,0,self:getSize())
end