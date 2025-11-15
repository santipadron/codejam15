local pd = playdate
local gfx = pd.graphics

--progress bar rectangle outline
progressBar = gfx.image.new(20, 150)
gfx.pushContext(progressBar)
    gfx.setLineWidth(2)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawRoundRect(0, 0, 20, 150, 3)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRoundRect(1, 1, 18, 148, 3)
gfx.popContext()

function updateProgressBar(score)
    progressBar:draw(360, 20)
    if score > 0 then
        insideBar = gfx.image.new(20, score)
        gfx.pushContext(insideBar)
            gfx.setColor(gfx.kColorWhite)
            gfx.fillRoundRect(0, 0, 20, score, 3)
        gfx.popContext()
        insideBar:draw(360, 170-score)
    end
end

function score_up(score)
    if score < 150 then
            score = score + 2
    end
    return score
end

function score_down(score)
    if score > 0 then
            score = score - 2
    end
    return score
end