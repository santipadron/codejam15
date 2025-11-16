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

local catchsfx = pd.sound.sampleplayer.new("sounds/catch")

--set background


class("FishingScene").extends(gfx.sprite)
--set fish bar
function FishingScene:init()
    setupGameBackground()

    self.currBG = 0
    
    updateRectangle()
    self.fishBar = FishBar(75, 215, 300, catchingRectangle)
    self.fishBar:add()

    --set fish icon
    self.fishIcon = FishIcon(200, 215,fishToCatch)
    self.fishIcon:add()

    --set progress bar
    self.progressBar = ProgressBar(360, 20, 20, 140)
    self.progressBar:add()

    --set player
    self.player = gfx.sprite.new(PLAYER.playerCharacter)
    self.player:setImage(PLAYER.playerCharacter)
    self.player:moveTo(220, 100)
    self.player:add()

    --Coin display
    local frame = gfx.image.new("images/coin.png")
    self.coinSprite = nil
    self:coinUpdate()

    self.score = 0
    self.lastCollision = pd.getCurrentTimeMilliseconds()
    self:add()
end

local function score_up(currentScore)
    return math.min(150, currentScore + 1 + PLAYER.skill)
end
local function score_down(currentScore)
    return math.max(0, currentScore - 3)
end


function FishingScene:coinUpdate()
    local frame = gfx.image.new(120, 30)
    local coin = gfx.image.new("images/coin.png")
    local coinH, coinW = coin:getSize()
    gfx.pushContext(frame)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(30, 0, 120, 30, 3)
        -- Draw coin image
        gfx.setColor(gfx.kColorBlack)
        coin:draw(35,0)
        -- Set text color explicitly
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)  -- This is KEY!
        gfx.drawText("X" .. tostring(PLAYER.currentBalance), coinW + 35, 8)
        

    gfx.popContext()
    if not self.coinSprite then
        self.coinSprite = gfx.sprite.new(frame)
        self.coinSprite:moveTo(40, 20)
        self.coinSprite:add()
    else
        self.coinSprite:setImage(frame)
    end
end

-- playdate.update function is required in every project!
function FishingScene:update()
    if pd.isCrankDocked() then
        return
    end

    self:coinUpdate()

    if self.currBG < 60 then
        self.currBG += 1
    elseif self.currBG == 60 then
        setupGameBackground()
        self.currBG += 1
    elseif self.currBG > 60 and self.currBG < 120 then
        self.currBG += 1
    elseif self.currBG == 120 then
        setupBGtwo()
        self.currBG += 1
    elseif self.currBG > 120 then
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
        catchsfx:play()
        SCENE_MANAGER:switchScene(CatchScene)
    end
end

