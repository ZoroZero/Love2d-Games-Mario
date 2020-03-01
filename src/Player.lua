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
function Player:checkLeftCollision(dt)

    local top_Left_Tile = self.tile_Map:pointToMap(self.x, self.y +1);
    local bottom_Left_Tile = self.tile_Map:pointToMap(self.x,self.y + self.height - 1);

    if (top_Left_Tile and bottom_Left_Tile) and (top_Left_Tile:collidable() or bottom_Left_Tile:collidable()) then 
        self.x = (top_Left_Tile.x - 1) * TILE_SIZE + TILE_SIZE;
    else
        self.y = self.y - 1;
        local collided_Objects = self:checkObjectCollision();
        self.y = self.y + 1;

        if #collided_Objects > 0 then 
            self.x = self.x + PLAYER_WALK_SPEED * dt;
        end
    end
end


-- CHECK FOR RIGHT SIDE COLLISION
function Player:checkRightCollision(dt)

    local top_Right_Tile = self.tile_Map:pointToMap(self.x + self.width - 1, self.y + 1);
    local bottom_Right_Tile = self.tile_Map:pointToMap(self.x + self.width -1, self.y + self.height - 1);

    if (top_Right_Tile and bottom_Right_Tile) and (top_Right_Tile:collidable() or bottom_Right_Tile:collidable()) then 
        self.x = (top_Right_Tile.x - 1) * TILE_SIZE - self.width;
    else
        self.y = self.y - 1;
        local collided_Objects = self:checkObjectCollision();
        self.y = self.y + 1;

        if #collided_Objects > 0 then 
            self.x = self.x + PLAYER_WALK_SPEED * dt;
        end
    end
end


-- CHECK COLLISION WITH GAME OBJECT
function Player:checkObjectCollision()
    -- return a list of object that collide with player
    local collided_Objects = {};

    for k, object in pairs(self.level.objects) do 
        if object:collides(self) then 
            if object.solid then 
                table.insert( collided_Objects, object)
            end
        end
    end

    return collided_Objects;
end