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


class("FishingScene").extends(gfx.sprite)
--set fish bar
function FishingScene:init()
    setupGameBackground()

    self.currBG = 0
    
    self.fishBar = FishBar(75, 215, 300, catchingRectangle)
    self.fishBar:add()

    --set fish icon
    self.fishIcon = FishIcon(200, 215,fishToCatch)
    self.fishIcon:add()

    --set progress bar
    self.progressBar = ProgressBar(360, 20, 20, 140)
    self.progressBar:add()

    self.score = 0
    self.lastCollision = pd.getCurrentTimeMilliseconds()
    self:add()
end

local function score_up(currentScore)
    return math.min(150, currentScore + 2)
end
local function score_down(currentScore)
    return math.max(0, currentScore - 2)
end

-- playdate.update function is required in every project!
function FishingScene:update()
    if self.currBG < 15 then
        setupGameBackground()
        self.currBG += 1
    elseif self.currBG >= 15 and self.currBG < 30 then
        setupBGtwo()
        self.currBG += 1
    elseif self.currBG >= 30 then
        self.currBG = 0
    end
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
    self.progressBar:setScore(self.score)
    if pd.buttonIsPressed(pd.kButtonB) then
        SCENE_MANAGER:switchScene(ForestScene)
    end

    if self.score >= 150 then
        SCENE_MANAGER:switchScene(CatchScene)
    end
end

