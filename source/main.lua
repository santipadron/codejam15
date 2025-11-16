import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/timer"
import "CoreLibs/sprites"
import "player"

PLAYER = Player()

import "sceneManager"
import "forestScene"

import "storeScene"
import "fishingScene"
import "catchScene"
import "catchScene"
import "titleScene"

local pd = playdate
local gfx = pd.graphics


SCENE_MANAGER = SceneManager()

SCENE_MANAGER:switchScene(TitleScene)

 local ost = pd.sound.fileplayer.new("sounds/ost")
ost:setLoopRange(8)
ost:play(0)

-- playdate.update function is required in every project!
function playdate.update()
    gfx.sprite.update()
    if pd.isCrankDocked() then
        pd.ui.crankIndicator:draw()
    end
end