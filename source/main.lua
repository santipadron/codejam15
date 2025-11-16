import "CoreLibs/object"
import "CoreLibs/timer"
import "CoreLibs/sprites"
import "CoreLibs/graphics"
import "CoreLibs/ui"

import "sceneManager"
import "forestScene"
import "player"
import "storeScene"
import "fishingScene"
import "catchScene"
import "catchScene"

local pd = playdate
local gfx = pd.graphics


SCENE_MANAGER = SceneManager()
PLAYER = Player()
SCENE_MANAGER:switchScene(ForestScene)

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