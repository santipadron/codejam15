import "background"
import "storeScene"

local pd = playdate
local gfx = pd.graphics


class('ForestScene').extends(gfx.sprite)
 function ForestScene:init()
    -- load background grass
    setupGrass()
    -- Load player sprite images for each direction
    self.playerImages = {
        right = {
            gfx.image.new("images/guyright1"),
            gfx.image.new("images/guyright2")
        },
        left = {
            gfx.image.new("images/guyleft1"),
            gfx.image.new("images/guyleft2")
        },
        up = {
            gfx.image.new("images/guyup1"),
            gfx.image.new("images/guyup2")
        },
        down = {
            gfx.image.new("images/guydown1"),
            gfx.image.new("images/guydown2")
        }
    }
    
    -- Animation state
    self.currentDirection = "down"  -- default direction
    self.currentFrame = 1
    self.animationTimer = 0
    self.animationSpeed = 8  -- frames between sprite change
    
    -- Player setup
    local startingX = 50
    local startingY = 160
    moveSpeed = 5
    
    local frame = gfx.image.new("images/coin.png")
    self.coinSprite = gfx.sprite.new(frame)
    self.coinSprite:moveTo(30, 220) -- coin position
    self.coinSprite:setZIndex(100)
    self.coinSprite:add()

    self.playerSprite = gfx.sprite.new(self.playerImages[self.currentDirection][1])
    self.playerSprite:setCollideRect(30,50,35,50)
    self.playerSprite:moveTo(startingX,startingY)
    self.playerSprite:setZIndex(99)
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

    --leftWall
    local leftWallX = 0
    local leftWallY = 0
    self.leftWallSprite = gfx.sprite.new()
    self.leftWallSprite:setCollideRect(0,0,10,240)
    self.leftWallSprite:add()
    
    --botttomWall
    local bottomWallX = 0
    local bottomWallY = 240
    self.bottomWallSprite = gfx.sprite.new()
    self.bottomWallSprite:setCollideRect(0,0,400,10)
    self.bottomWallSprite:moveTo(bottomWallX, bottomWallY)
    self.bottomWallSprite:add()

    --Store
    local buildingX = 200
    local buildingY = 50
    local storeFront = gfx.image.new("images/House_1_Wood_Base_Blue")
    self.storeFrontSprite = gfx.sprite.new(storeFront)
    self.storeFrontSprite:setCollideRect(0,0,90,120)
    self.storeFrontSprite:moveTo(buildingX,buildingY)
    self.storeFrontSprite:add()

    --sign
    local sign = gfx.image.new("images/sign")
    local signspr = gfx.sprite.new(sign)
    signspr:setZIndex(1001)
    signspr:moveTo(350, 200)
    signspr:add()

    --shop-sign
    local shopsign = gfx.image.new("images/sign-shop")
    local shopsignspr = gfx.sprite.new(shopsign)
    shopsignspr:setZIndex(1001)
    shopsignspr:moveTo(130, 80)
    shopsignspr:add()


    
    self:add()
end

function ForestScene:coinUpdate()
    local frame = gfx.image.new(100, 40)
    local coin = gfx.image.new("images/coin.png")
    local coinH, coinW = coin:getSize()
    gfx.pushContext(frame)
        -- Draw coin image
        gfx.setColor(gfx.kColorWhite)
        coin:draw(20, 0)

        -- Set text color explicitly
        gfx.setImageDrawMode(gfx.kDrawModeFillBlack)  -- This is KEY!
        gfx.drawText("X" .. tostring(PLAYER.currentBalance), coinW + 20, 8)
    gfx.popContext()
    if not self.coinSprite then
        self.coinSprite = gfx.sprite.new(frame)
        self.coinSprite:moveTo(20, 200)
        self.coinSprite:add()
    else
        self.coinSprite:setImage(frame)
    end
end

function ForestScene:update()
    local actualX, actualY, collision, length=self.playerSprite:moveWithCollisions(self.playerSprite.x, self.playerSprite.y)
    self:coinUpdate()
    local isMoving = false

     -- Handle movement input
    if self.playerSprite.x>150 and self.playerSprite.x<250  and self.playerSprite.y == 126 then
        SCENE_MANAGER:switchScene(StoreScene)
    end
    if self.playerSprite.x>400 then
        SCENE_MANAGER:switchScene(FishingScene)
    end

    if pd.buttonIsPressed(pd.kButtonRight) then
        self.currentDirection = "right"
        self.playerSprite:moveBy(moveSpeed, 0)
        isMoving = true
    end
    if pd.buttonIsPressed(pd.kButtonLeft) then
        self.currentDirection = "left"
        self.playerSprite:moveBy(-moveSpeed, 0)
        isMoving = true
    end
    if pd.buttonIsPressed(pd.kButtonUp) then
        self.currentDirection = "up"
        self.playerSprite:moveBy(0, -moveSpeed)
        isMoving = true
    end
    if pd.buttonIsPressed(pd.kButtonDown) then
        self.currentDirection = "down"
        self.playerSprite:moveBy(0, moveSpeed)
        isMoving = true
    end

    -- Animate sprite when moving
    if isMoving then
        self.animationTimer += 1
        if self.animationTimer >= self.animationSpeed then
            self.animationTimer = 0
            -- Toggle between frame 1 and 2
            self.currentFrame = (self.currentFrame == 1) and 2 or 1
            self.playerSprite:setImage(self.playerImages[self.currentDirection][self.currentFrame])
        end
    else
        -- Reset to frame 1 when idle
        self.currentFrame = 1
        self.playerSprite:setImage(self.playerImages[self.currentDirection][1])
    end

    -- Scene transitions


    if self.playerSprite.x > 155 and self.playerSprite.x < 245 and self.playerSprite.y < 100 then
        SCENE_MANAGER:switchScene(StoreScene)
    end
    if self.playerSprite.x > 400 then
        SCENE_MANAGER:switchScene(FishingScene)
    end
end 