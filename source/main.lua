-- Importing libraries used for drawCircleAtPoint and crankIndicator
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


-- playdate.update function is required in every project!
function playdate.update()
    --gfx.clear()
    gfx.sprite.update()
    fishBar:updateBar()
    fishIcon:updatePos()

    -- Handle button input
    if fishBar:checkCollisions() then
        lastCollision = pd.getCurrentTimeMilliseconds()
        score = score_up(score)
    else
        if pd.getCurrentTimeMilliseconds() - lastCollision > 250 then
            score = score_down(score)
        end
    end
    
    -- Update the progress bar based on score
    updateProgressBar(score)
end

