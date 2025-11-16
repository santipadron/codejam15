
import "storeScene"

local pd = playdate
local gfx = pd.graphics


class('ForestScene').extends(gfx.sprite)

function ForestScene:init()
    -- player
    local startingX = 100
    local startingY = 140
    moveSpeed = 5
    local playerCharacter = gfx.image.new("images/Oak_Tree")
    self.playerSprite = gfx.sprite.new(playerCharacter)
    self.playerSprite:setCollideRect(10,20,40,40)
    self.playerSprite:moveTo(startingX,startingY)
    self.playerSprite:add()


    -- top treeline
    local topTreeLineX = -35
    local topTreeLineY = 30
    local treeLine = gfx.image.new("images/Oak_Tree_Line")
    self.treelineSprite = gfx.sprite.new(treeLine)
    self.treelineSprite:setCollideRect(0,0,400,80)
    self.treelineSprite:moveTo(topTreeLineX,topTreeLineY)
    self.treelineSprite:add()

    -- top treeline rightside
    local topTreeLineRightX = 435
    local topTreeLineRightY = 30
    local treeLine2 = gfx.image.new("images/Oak_Tree_Line")
    self.treelineSprite2 = gfx.sprite.new(treeLine2)
    self.treelineSprite2:setCollideRect(0,0,400,80)
    self.treelineSprite2:moveTo(topTreeLineRightX,topTreeLineRightY)
    self.treelineSprite2:add()


    --Store
    local buildingX = 200
    local buildingY = 50
    local storeFront = gfx.image.new("images/House_1_Wood_Base_Blue")
    self.storeFrontSprite = gfx.sprite.new(storeFront)
    self.storeFrontSprite:setCollideRect(0,0,95,120)
    self.storeFrontSprite:moveTo(buildingX,buildingY)
    self.storeFrontSprite:add()

    
    self:add()
end

function ForestScene:update()
    local actualX, actualY, collision, length=self.playerSprite:moveWithCollisions(self.playerSprite.x, self.playerSprite.y)

    print(self.playerSprite.x)
    print(self.playerSprite.y)
    if self.playerSprite.x>150 and self.playerSprite.x<250  and self.playerSprite.y == 126 then
        SCENE_MANAGER:switchScene(StoreScene)
    end
    if self.playerSprite.x>400 then
        SCENE_MANAGER:switchScene(FishingScene)
    end

    if pd.buttonIsPressed(pd.kButtonRight) then
        self.playerSprite:moveBy(moveSpeed,0)
    end
    if pd.buttonIsPressed(pd.kButtonUp) then
        self.playerSprite:moveBy(0,-moveSpeed)
    end
    if pd.buttonIsPressed(pd.kButtonLeft) then
        self.playerSprite:moveBy(-moveSpeed,0)
    end
    if pd.buttonIsPressed(pd.kButtonDown) then
        self.playerSprite:moveBy(0,moveSpeed)
    end
end