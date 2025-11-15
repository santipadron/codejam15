-- Below is a small example program where you can move a circle
-- around with the crank. You can delete everything in this file,
-- but make sure to add back in a playdate.update function since
-- one is required for every Playdate game!
-- =============================================================

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

--set fish bar
local fishBar = FishBar(75, 215, 300, catchingRectangle )
fishBar:add()

--set fish icon
local fishIcon = FishIcon(200, 215,fishToCatch)
fishIcon:add()

local score = 0
local lastCollision = pd.getCurrentTimeMilliseconds()

--init sprites
--catchingRectangleSprite:moveTo(75, 215)
--catchingRectangleSprite:add()

--fishToCatchSprite:moveTo(200, 215)
--fishToCatchSprite:add()

-- playdate.update function is required in every project!
function playdate.update()
    -- Clear screen
    -- Draw crank indicator if crank is docked
    gfx.clear()
    gfx.sprite.update()
    fishBar:updateBar()
    -- Handle button input
    if fishBar:checkCollisions() then
        lastCollision = pd.getCurrentTimeMilliseconds()
        score = score_up(score)
    else
        if pd.getCurrentTimeMilliseconds() - lastCollision > 250 then
            score = score_down(score)
        end
    end
    
    --Outline of progress bar
    gfx.drawRect(360, 20, 20, 140)
    
    -- Fill the progress bar based on score
    -- playdate.graphics.drawRect(x, y, w, h)
    if score > 0 then
        gfx.fillRect(360, 160 - score, 20, score)
    end
end

