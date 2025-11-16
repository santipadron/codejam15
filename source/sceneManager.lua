
local pd = playdate
local gfx = pd.graphics

class("SceneManager").extends()

function SceneManager:switchScene(scene)
    self.newScene = scene
    self:loadNewScene()
end

function SceneManager:loadNewScene()
    self:cleanupScene()
    self.newScene()
end

function SceneManager:cleanupScene()
    gfx.sprite.removeAll()
    -- no timers needed for now to remove
    gfx.setDrawOffset(0,0)
end

