--Popup that happens when you get a catch

local pd <const> = playdate
local gfx <const> = pd.graphics

local font = gfx.font.new("assets/Legend")
gfx.setFont(font)

local frame = gfx.image.new(300, 150)
gfx.pushContext(frame)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(0, 0, 300, 150, 5)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRoundRect(5, 5, 290, 140, 5)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(10, 10, 280, 130, 5)
    gfx.drawText("GOOOOOT A CATCH", 80, 20)
gfx.popContext()

function drawCatchPopup(fish)
    frame:draw(25, 25)
end


local state = "fishing"


-- playdate.update function is required in every project!
function playdate.update()
    if state == "fishing" then
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
        if score >= 150 then
            state = "catch"
        end
    elseif state == "catch" then
        drawCatchPopup(nil)
        pd.timer.new(50000)
        score = 0
        state = "fishing"
    end 

end

