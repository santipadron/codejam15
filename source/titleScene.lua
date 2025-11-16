local pd = playdate
local gfx = pd.graphics


class('TitleScene').extends(gfx.sprite)
function TitleScene:init()
    local bg = gfx.image.new("images/title-screen")
    local text = gfx.image.new(200, 30)
    gfx.pushContext(text)
        gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        gfx.drawText("PRESS Ⓐ TO START", 0, 0)
    gfx.popContext()
    local textSprite = gfx.sprite.new(text)
    textSprite:moveTo(200, 215)
    textSprite:setZIndex(999)
    textSprite:add()
    self.titleScreen = gfx.sprite.new(bg)
    self.titleScreen:moveTo(200,120)
    self.titleScreen:add()
    self:add()
end

function TitleScene:update()
    if pd.buttonIsPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(ForestScene)
    end
end
