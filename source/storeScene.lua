
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

    -- Buy Button
    local startingLeftX = 200
    local startingLeftY = 200
    local buyButton = gfx.image.new("images/buyButton")
    self.buyButtonSprite = gfx.sprite.new(buyButton)
    self.buyButtonSprite:moveTo(startingLeftX,startingLeftY)
    self.buyButtonSprite:add() 

    -- Sold Out Button
    local soldOutButton = gfx.image.new("images/soldOutButton")
    self.soldOutButtonSprite = gfx.sprite.new(soldOutButton)
    self.soldOutButtonSprite:moveTo(startingLeftX,startingLeftY)


    -- fishingRodButton
    local startingX = 200
    local startingY = 60
    local fishingRodButton = gfx.image.new("images/fishingRodButton")
    self.fishingRodButtonSprite = gfx.sprite.new(fishingRodButton)
    self.fishingRodButtonSprite:moveTo(startingX,startingY)
    self.fishingRodButtonSprite:add()

    -- baitButton
    local baitButton = gfx.image.new("images/baitButton")
    self.baitButtonSprite = gfx.sprite.new(baitButton)
    self.baitButtonSprite:moveTo(startingX,startingY)

    -- glassesButton
    local glassesButton = gfx.image.new("images/glassesButton")
    self.glassesButtonSprite = gfx.sprite.new(glassesButton)
    self.glassesButtonSprite:moveTo(startingX,startingY)
    
    -- hatButton
    local hatButton = gfx.image.new("images/hatButton")
    self.hatButtonSprite = gfx.sprite.new(hatButton)
    self.hatButtonSprite:moveTo(startingX,startingY)

    --coin 
    self.coinSprite = nil
    self:coinUpdate()

    self.catalog = {
            -- item/quantity
            ["Fishing Rod"]=9,
            ["Bait"]=9,
            ["Glasses"]=9,
            ["Hat"]=9
        }

    self.buttonKeys = {self.fishingRodButtonSprite, self.baitButtonSprite, self.glassesButtonSprite, self.hatButtonSprite}
    self.itemKeys = {"Fishing Rod", "Bait", "Glasses", "Hat"}
    self.currentItem=1

    local frame = gfx.image.new(300, 150)
    self.itemInfo = gfx.sprite.new(frame)
    self.itemInfo:moveTo(0, 300)
    self.itemInfo:add()

    self:add()
end

function StoreScene:coinUpdate()
    local frame = gfx.image.new(100, 40)
    local coin = gfx.image.new("images/coin.png")
    local coinH, coinW = coin:getSize()
    gfx.pushContext(frame)
        -- Draw coin image
        gfx.setColor(gfx.kColorWhite)
        coin:draw(20, 0)

        -- Set text color explicitly
        gfx.setImageDrawMode(gfx.kDrawModeFillBlack)  -- This is KEY!
        gfx.drawText("X" .. tostring(PLAYER.currentBalance), coinW + 25, 8)
    gfx.popContext()
    if not self.coinSprite then
        self.coinSprite = gfx.sprite.new(frame)
        self.coinSprite:moveTo(30, 220)
        self.coinSprite:add()
    else
        self.coinSprite:setImage(frame)
    end
end

function StoreScene:updateText()
    local frame = gfx.image.new(300, 150)

    local small_font = gfx.font.new("assets/robkohr-mono-5x8")
    gfx.pushContext(frame)

        gfx.drawText("Quantity: " .. self.catalog[self.itemKeys[self.currentItem]], 5,0)
        
        gfx.drawText("Current lvl: " .. 10-self.catalog[self.itemKeys[self.currentItem]], 0,20)

        if  (10-self.catalog[self.itemKeys[self.currentItem]]<10)then
            gfx.drawText("Price: " .. (10-self.catalog[self.itemKeys[self.currentItem]])*100, 150,0)
        else
            gfx.drawText("SOLD OUT", 150,0)
        end

    gfx.popContext()
    self.itemInfo:setImage(frame)
    self.itemInfo:moveTo(304,200)
end

function StoreScene:buy(item)
    if self.catalog[item] <= 0 then
        print("No stock!")
    else
        if PLAYER.currentBalance>=((10-self.catalog[self.itemKeys[self.currentItem]])*100) then
            PLAYER.currentBalance = PLAYER.currentBalance-((10-self.catalog[self.itemKeys[self.currentItem]])*100)

            self.soldOutButtonSprite:remove()
            self.buyButtonSprite:add()

            self.catalog[item] =self.catalog[item]-1

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
        else
            self.buyButtonSprite:remove()
            self.soldOutButtonSprite:add()
        end
    end
end


function StoreScene:update()
    if pd.buttonJustReleased(pd.kButtonLeft) then
        if self.currentItem>1 then
            self.buttonKeys[self.currentItem]:remove()
            self.currentItem = self.currentItem-1
            self.buttonKeys[self.currentItem]:add()
        end
    end
    if pd.buttonJustReleased(pd.kButtonRight) then
        if self.currentItem<#self.itemKeys then
            self.buttonKeys[self.currentItem]:remove()
            self.currentItem = self.currentItem+1
            self.buttonKeys[self.currentItem]:add()
        end
    end

    if pd.buttonJustPressed(pd.kButtonA) then
        self:buy(self.itemKeys[self.currentItem])
    end
    if pd.buttonIsPressed(pd.kButtonB) then
        print(PLAYER.bait)
        SCENE_MANAGER:switchScene(ForestScene)
    end

    self:coinUpdate()
    self:updateText()
    
end