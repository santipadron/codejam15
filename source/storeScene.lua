
import "forestScene"

local pd = playdate
local gfx = pd.graphics


class('StoreScene').extends(gfx.sprite)

function StoreScene:init()
    self.catalog = {
            -- item/quantity
            ["Fishing Rod"]=9,
            ["bait"]=9,
            ["Glasses"]=9,
            ["Hat"]=9
        }
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
    if pd.buttonIsPressed(pd.kButtonUp) then
        if self.currentItem>1 then
            self.currentItem = self.currentItem-1
        end
    end
    if pd.buttonIsPressed(pd.kButtonDown) then
        if self.currentItem<#self.itemKeys then
            self.currentItem = self.currentItem+1
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