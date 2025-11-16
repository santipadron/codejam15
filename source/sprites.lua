-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

--catching white rectangle
local x = 60*(1 + 0.25* PLAYER.fishingRodLevel)
catchingRectangle = gfx.image.new(x, 20)
gfx.pushContext(catchingRectangle)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(0, 0, x, 20, 3)
gfx.popContext()

function updateRectangle()
    x = 60*(1+ 0.25*PLAYER.fishingRodLevel)
    catchingRectangle = gfx.image.new(x, 20)
    gfx.pushContext(catchingRectangle)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRoundRect(0, 0, x, 20, 3)
    gfx.popContext()
end

catchingRectangleSprite = gfx.sprite.new(catchingRectangle)
catchingRectangleSprite:setCollideRect(0,0,x,20)

--fish to catch
fishToCatch = gfx.image.new("images/fish2")
fishToCatchSprite = gfx.sprite.new(fishToCatch)
fishToCatchSprite:setCollideRect(0,0,16,16)