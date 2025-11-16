local pd = playdate
local gfx = pd.graphics

class('ProgressBar').extends(gfx.sprite)

function ProgressBar:init(x, y, w, h)
    self.x = x or 360
    self.y = y or 20
    self.w = w or 20
    self.h = h or 150
    self.score = 0
    -- initial image
    local img = gfx.image.new(self.w, self.h)
    self:setImage(img)
    -- position: moveTo expects center coordinates
    self:moveTo(self.x + self.w/2, self.y + self.h/2)
    self:add()
    self:refreshImage()
end

function ProgressBar:refreshImage()
    local img = gfx.image.new(self.w, self.h)
    gfx.pushContext(img)
        gfx.setLineWidth(2)
        gfx.setColor(gfx.kColorWhite)
        gfx.drawRoundRect(0, 0, self.w, self.h, 3)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(1, 1, self.w - 2, self.h - 2, 3)
        if self.score > 0 then
            gfx.setColor(gfx.kColorWhite)
            local fillHeight = math.max(0, math.min(self.h, self.score))
            local drawY = self.h - fillHeight
            gfx.fillRoundRect(1, drawY, self.w - 2, fillHeight, 3)
        end
    gfx.popContext()
    self:setImage(img)
end

function ProgressBar:setScore(newScore)
    newScore = math.floor(newScore or 0)
    newScore = math.max(0, math.min(self.h, newScore)) -- clamp to [0, h]
    if newScore ~= self.score then
        self.score = newScore
        self:refreshImage()
    end
end