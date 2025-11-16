import "background"
import "fishesClass"




-- Localizing commonly used globals
local pd <const> = playdate
local gfx <const> = playdate.graphics

class("CatchScene").extends(gfx.sprite)
function CatchScene:init()
    local default_font = gfx.getFont()
    local small_font = gfx.font.new("assets/robkohr-mono-5x8")

    local fishTypes = {Frog, Moonfish, Omgfish, Dumbfish, Shrimp}
    local randomFish = fishTypes[math.random(#fishTypes)]
    local caughtFish = randomFish()
    caughtFish:setScale(2)
    caughtFish:setZIndex(100) -- ensure fish is on top  
    caughtFish: moveTo(200, 135)
    caughtFish: add() 

    gfx.setFont(default_font, gfx.font.kVariantBold)

    setupGameBackground()

    local frame = gfx.image.new(300, 150)
    gfx.pushContext(frame)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRoundRect(0, 0, 300, 150, 5)
        gfx.setColor(gfx.kColorBlack)
        gfx.fillRoundRect(5, 5, 290, 140, 5)
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRoundRect(10, 10, 280, 130, 5)
        gfx.drawText("GOOOOOT A CATCH !!", 80, 20)
        gfx.drawText("You caught a " .. caughtFish.name, 70, 55)
        gfx.setFont(small_font)
        gfx.drawText("➀➁ FISH AGAIN", 210, 115)
        gfx.drawText("➂➃ GO HOME", 227, 125)
    gfx.popContext()
    self.gotCatchSprite = gfx.sprite.new(frame)
    self.gotCatchSprite:moveTo(200, 100) -- got catch frame
    self.gotCatchSprite:add()
    self:add()
end

function CatchScene.update()
    if pd.buttonIsPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(FishingScene)
    end

    if pd.buttonIsPressed(pd.kButtonB) then
        SCENE_MANAGER:switchScene(ForestScene)
    end
end

