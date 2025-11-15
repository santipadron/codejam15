local pd = playdate
local gfx = pd.graphics
local score = 0


function score_up()
    if score < 140 then
            score = score + 5
    end
end

function score_down()
    if score > 0 then
            score = score - 5
    end
end

function playdate.update()
    
    -- Clear the screen
    gfx.clear()
    
    -- Handle button input
    if playdate.buttonIsPressed(playdate.kButtonA) then
        score_up()
    else 
        score_down()
    end
    
    --Outline of progress bar
    gfx.drawRect(360, 20, 20, 140)
    
    
    -- Fill the progress bar based on score
    -- playdate.graphics.drawRect(x, y, w, h)
    if score > 0 then
        gfx.fillRect(360, 160 - score, 20, score)
    end
    
end