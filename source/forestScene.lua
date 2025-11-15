
import "storeScene"

local pd = playdate
local gfx = pd.graphics

class('ForestScene').extends(gfx.sprite)

function ForestScene:init()
    -- player
    local startingX = 100
    local startingY = 120
    moveSpeed = 20
    local playerCharacter = gfx.image.new("images/Oak_Tree")
    self.playerSprite = gfx.sprite.new(playerCharacter)
    self.playerSprite:setCollideRect(0,0,self.playerSprite:getSize())
    self.playerSprite:moveTo(startingX,startingY)
    self.playerSprite:add()


    -- top treeline
    local topTreeLineX = 30
    local topTreeLineY = 50
    local treeLine = gfx.image.new("images/Oak_Tree")
    local treelineSprite = gfx.sprite.new(treeLine)
    treelineSprite:setCollideRect(0,0,400,65)
    treelineSprite:moveTo(topTreeLineX,topTreeLineY)
    treelineSprite:add()


    --Store
    local buildingX = 200
    local buildingY = 50
    local storeFront = gfx.image.new("images/House_1_Wood_Base_Blue")
    local storeFrontSprite = gfx.sprite.new(storeFront)
    storeFrontSprite:setCollideRect(0,0,95,120)
    storeFrontSprite:moveTo(buildingX,buildingY)
    storeFrontSprite:add()

    self:add()
end

function ForestScene:update()
    if pd.buttonIsPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(StoreScene)
    end
    if pd.buttonIsPressed(pd.kButtonRight) then
        self.playerSprite:moveBy(moveSpeed,0)
    end
   
end