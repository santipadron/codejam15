
import "forestScene"

local pd = playdate
local gfx = pd.graphics


class('StoreScene').extends(gfx.sprite)

function StoreScene:init()
    -- Button right
    local startingRightX = 300
    local startingRightY = 180
    local buttonRight = gfx.image.new("images/ButtonRight")
    self.buttonRightSprite = gfx.sprite.new(buttonRight)
    self.buttonRightSprite:moveTo(startingRightX,startingRightY)
    self.buttonRightSprite:add()    

    -- Button left
    local startingLeftX = 100
    local startingLeftY = 180
    local buttonLeft = gfx.image.new("images/ButtonLeft")
    self.buttonLeftSprite = gfx.sprite.new(buttonLeft)
    self.buttonLeftSprite:moveTo(startingLeftX,startingLeftY)
    self.buttonLeftSprite:add()  

    -- Button1
    local startingX = 200
    local startingY = 60
    local button1 = gfx.image.new("images/Button")
    self.button1Sprite = gfx.sprite.new(button1)
    self.button1Sprite:moveTo(startingX,startingY)
    self.button1Sprite:add()

    -- Button2
    local button2 = gfx.image.new("images/ButtonLeft")
    self.button2Sprite = gfx.sprite.new(button2)
    self.button2Sprite:moveTo(startingX,startingY)

    -- Button3
    local button3 = gfx.image.new("images/Button")
    self.button3Sprite = gfx.sprite.new(button3)
    self.button3Sprite:moveTo(startingX,startingY)
    
    -- Button4
    local button4 = gfx.image.new("images/Button")
    self.button4Sprite = gfx.sprite.new(button4)
    self.button4Sprite:moveTo(startingX,startingY)

    self.catalog = {
            -- item/quantity
            ["Fishing Rod"]=9,
            ["bait"]=9,
            ["Glasses"]=9,
            ["Hat"]=9
        }
    self.buttonKeys = {self.button1Sprite, self.button2Sprite, self.button3Sprite, self.button4Sprite}
    self.itemKeys = {"Fishing Rod", "Bait", "Glasses", "Hat"}
    self.currentItem=1

    self:add()
end

function StoreScene:buy(item)
    if self.catalog[item] == 0 then
        print("No stock!")
    else
        self.catalog[self.itemKeys[self.currentItem]] =self.catalog[self.itemKeys[self.currentItem]]-1

        if item == "Fishing Rod" then
            PLAYER.fishingRodLevel = PLAYER.fishingRodLevel + 1
            print(PLAYER.fishingRodLevel)
        elseif item == "Bait" then
            PLAYER.bait = PLAYER.bait + 1
            print(PLAYER.bait)
        elseif item == "Glasses" then
            PLAYER.fishingPrecision = PLAYER.fishingPrecision + 1
            print(PLAYER.fishingPrecision)
        elseif item == "Hat" then
            PLAYER.skill = PLAYER.skill + 1
            print(PLAYER.skill)
        end
    end
end


function StoreScene:update()
    if pd.buttonIsPressed(pd.kButtonLeft) then
        if self.currentItem>1 then
            self.buttonKeys[self.currentItem]:remove()
            self.currentItem = self.currentItem-1
            self.buttonKeys[self.currentItem]:add()
        end
    end
    if pd.buttonIsPressed(pd.kButtonRight) then
        if self.currentItem<#self.itemKeys then
            self.buttonKeys[self.currentItem]:remove()
            self.currentItem = self.currentItem+1
            self.buttonKeys[self.currentItem]:add()
        end
    end

    if pd.buttonIsPressed(pd.kButtonA) then
        self:buy(self.itemKeys[self.currentItem])
    end
    if pd.buttonIsPressed(pd.kButtonB) then
        print(PLAYER.bait)
        SCENE_MANAGER:switchScene(ForestScene)
    end
end