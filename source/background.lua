import 'LDtk'
import "CoreLibs/sprites"

-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

--fishing rectangle
fishingRectangle = gfx.image.new(380, 30)
gfx.pushContext(fishingRectangle)
    gfx.setLineWidth(3)
    gfx.setColor(gfx.kColorWhite)
    gfx.drawRoundRect(0, 0, 380, 30, 2)
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRoundRect(2, 2, 376, 26, 2)
gfx.popContext()

--background sea
LDtk.load("background.ldtk")
bgmap0 = LDtk.create_tilemap("Level_0")
bgmap1 = LDtk.create_tilemap("Level_1")
bgdock = LDtk.create_tilemap("Level_2")


--setup background helper function
function setupGameBackground()
    gfx.sprite.setBackgroundDrawingCallback(
    function (x, y, width, height)
        bgmap0:draw(0,0)
        bgdock:draw(0,0)
        fishingRectangle:draw(10, 200)
    end)
end
