Player = Class {__includes = Entity}

-- INIT
function Player:init(params)
    Entity.init(self, params)
end

-- UPDATE
function Player:update(dt)
    Entity.update(self,dt);
end

-- RENDER
function Player:render()
    Entity.render(self)
end


-- CHECK FOR LEFT SIDE COLLISION
function Player:checkLeftCollision()

    local top_Left_Tile = self.tile_Map:pointToMap(self.x, self.y +1);
    local bottom_Left_Tile = self.tile_Map:pointToMap(self.x,self.y + self.height - 1);

    if (top_Left_Tile and bottom_Left_Tile) and (top_Left_Tile:collidable() or bottom_Left_Tile:collidable()) then 
        self.x = (top_Left_Tile.x - 1) * TILE_SIZE + TILE_SIZE;
    end
end


-- CHECK FOR RIGHT SIDE COLLISION
function Player:checkRightCollision()

    local top_Right_Tile = self.tile_Map:pointToMap(self.x + self.width - 1, self.y + 1);
    local bottom_Right_Tile = self.tile_Map:pointToMap(self.x + self.width -1, self.y + self.height - 1);

    if (top_Right_Tile and bottom_Right_Tile) and (top_Right_Tile:collidable() or bottom_Right_Tile:collidable()) then 
        self.x = (top_Right_Tile.x - 1) * TILE_SIZE - self.width;
    end
end