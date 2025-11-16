-- Importing libraries used for drawCircleAtPoint and crankIndicator
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/ui"
import "background"
import "sprites"

import "scripts/fishBar"
import "scripts/progressBar"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

--set background
setupGameBackground()

class("FishingScene").extends(gfx.sprite)
--set fish bar
function FishingScene:init(fishToCatch, catchingRectangle)
    self.fishBar = FishBar(75, 215, 300, catchingRectangle )
    self.fishBar:add()

    --set fish icon
    self.fishIcon = FishIcon(200, 215,fishToCatch)
    self.fishIcon:add()

    self.score = 0
    self.lastCollision = pd.getCurrentTimeMilliseconds()
end

-- playdate.update function is required in every project!
function FishingScene:update()
    gfx.clear()
    gfx.sprite.update()
    self.fishBar:updateBar()
    self.fishIcon:updatePos()
    -- Handle button input
    if self.fishBar:checkCollisions() then
        self.lastCollision = pd.getCurrentTimeMilliseconds()
        self.score = score_up(self.score)
    else
        if pd.getCurrentTimeMilliseconds() - self.lastCollision > 250 then
            self.score = score_down(self.score)
        end
    end
    
    -- Update the progress bar based on score
    updateProgressBar(self.score)
end

