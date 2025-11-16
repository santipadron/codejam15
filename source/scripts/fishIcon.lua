import "CoreLibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('FishIcon').extends(gfx.sprite)

function FishIcon:init(x,y,image)
    self.x = x
    self.y = y
    self.speed = 0
    self:moveTo(x,y)
    self:setImage(image)
    self:setCollideRect(0,0,self:getSize())
end

function FishIcon:updatePos()
    self.speed += math.random(-2,2)
    if self.speed > 4 then
        self.speed = 4
    end
    if self.speed < -4 then
        self.speed = -4
    end
    self.x += self.speed
    self.x = math.max(50, math.min(350, self.x))
    self:moveTo(self.x, self.y)
end