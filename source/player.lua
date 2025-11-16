local pd = playdate
local gfx = pd.graphics

class('Player').extends(gfx.sprite)


function Player:init()
    -- stats are instance fields
    self.fishingRodLevel = 1          -- increases the window for catching fish
    self.fishingPrecision = 1         -- reduces variation in sensitivity
    self.bait = 1                     -- increases income and rare fish chance
    self.skill = 1                    -- reduces duration for each catch phase
    self.playerCharacter = gfx.image.new("images/guyfishing")
    
    self.currentBalance = 1000
end
