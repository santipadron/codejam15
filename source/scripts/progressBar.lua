local pd = playdate
local gfx = pd.graphics

function score_up(score)
    if score < 140 then
            score = score + 1
    end
    return score
end

function score_down(score)
    if score > 0 then
            score = score - 0.5
    end
    return score
end