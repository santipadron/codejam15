import "CoreLibs/graphics"
import "CoreLibs/sprites"

local gfx <const> = playdate.graphics

local Rarities = {
    COMMON = 60,
    UNCOMMON = 75,
    RARE = 85,
    EPIC = 95,
    LEGENDARY = 99
}
class('Fish').extends(gfx.sprite)

function Fish:init(name, points, image)
    Fish.super.init(self)
    
    self.name = name
    self.points = points

    local fishImage = gfx.image.new(imagePath)
    
    self:setImage(image)
    self:setRarity(points)
end
    

function Fish:setRarity(points)
    if points <= Rarities.COMMON then
        self.rarity = "Common"
    elseif points <= Rarities.UNCOMMON then
        self.rarity = "Uncommon"
    elseif points <= Rarities.RARE then
        self.rarity = "Rare"
    elseif points <= Rarities.EPIC then
        self.rarity = "Epic"
    else
        self.rarity = "Legendary"
    end
end


-- Now create specific fish types
class('Frog').extends(Fish)
function Frog:init()
    Frog.super.init(self, "Frog", 20, "images/frog")
end

class('Moonfish').extends(Fish)
function Moonfish:init()
    Moonfish.super.init(self, "Moonfish", 30, "images/moonfish")
end

class('Omgfish').extends(Fish)
function Omgfish:init()
    Omgfish.super.init(self, "Omgfish", 50, "images/omgfish")
end

class('Dumbfish').extends(Fish)
function Dumbfish:init()
    Dumbfish.super.init(self, "Dumbfish", 70, "images/dumbfish")
end

class('Shrimp').extends(Fish)
function Shrimp:init()
    Shrimp.super.init(self, "Shrimp", 90, "images/shrimp")
    
end