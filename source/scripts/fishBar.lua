import "CoreLibs/sprites"
import "fishIcon"
local pd <const> = playdate
local gfx <const> = pd.graphics

local reelSound = pd.sound.sampleplayer.new("sounds/reeling")

class('FishBar').extends(gfx.sprite)

function FishBar:init(x, y, len, image)
    self:setImage(image)
    self:moveTo(x,y)
    self:setCollideRect(0,0,self:getSize())
    self.len = len
    self.x = x
    self.y = y
    self.maxSpeed = 4
    self.velocity = 0
    self.acc = 1
    self.point = 0
end

function FishBar:printVal()
    print("x coor:", self.x)
    print("y coor:", self.y)
    print("points:", self.point)
end

function FishBar:getAccerletion(acc)
    if acc > 5 then
        self.acc = 2
    elseif acc > 10 then
        self.acc = 4
    elseif acc < -10 then
        self.acc = -4
    elseif acc < -5 then
        self.acc = -2
    end
end

function FishBar:updateBar()
    local change= pd.getCrankChange()
    --self:getAccerletion(acc)
    if change > 0 then
        self.velocity += self.acc
        if self.velocity > self.maxSpeed then
            self.velocity = self.maxSpeed
        end
    elseif change < 0 then
        self.velocity -= self.acc
        if self.velocity < -self.maxSpeed then
            self.velocity = -self.maxSpeed
        end
    else
        if self.velocity > 0 then
            self.velocity -= (self.acc/5)
        elseif self.velocity < 0 then
            self.velocity += (self.acc/5)
        end
    end

    self.x += self.velocity
    self.x = math.max(50, math.min(350, self.x))
    self:moveTo(self.x, self.y)
end

function FishBar:checkCollisions()
    local overlaps = self:overlappingSprites()
    for i = 1, #overlaps do
        if overlaps[i]:isa(FishIcon) then
            reelSound:play()
            return true
        end
    end
    return false
end

function FishBar:gainPoint()
    if(self:checkCollisions()) then
        self.point +=1
    end
end