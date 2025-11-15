-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

--catching white rectangle
catchingRectangle = gfx.image.new(60, 20)
gfx.pushContext(catchingRectangle)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(0, 0, 60, 20, 3)
gfx.popContext()

catchingRectangleSprite = gfx.sprite.new(catchingRectangle)
catchingRectangleSprite:setCollideRect(0,0,60,20)

--fish to catch
fishToCatch = gfx.image.new("images/fish2")
fishToCatchSprite = gfx.sprite.new(fishToCatch)
fishToCatchSprite:setCollideRect(0,0,16,16)