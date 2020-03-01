Tile = Class {}

-- INIT TILE
function Tile:init(x, y, tile_id, topper, tile_set, topper_set)
    -- Tile position in map
    self.x = x;
    self.y = y;

    -- Tile id and has topper or not
    self.tile_id = tile_id;
    self.topper = topper;

    -- Set that tile belong to and topper set of that tile
    self.tile_set = tile_set;
    self.topper_set = topper_set;
end



-- UPDATE FUNCTION
function Tile:update(dt)

end


-- FUNCTION TO CHECK IF A TILE IS COLLIDABLE
function Tile:collidable()
    if GROUND_TILE == self.tile_id then 
            return true;
    end

    return false;
end


-- RENDER FUNCTION
function Tile:render()
    love.graphics.draw(game_Textures['tile'], game_Frames['tile_sets'][self.tile_set][self.tile_id], 
    (self.x - 1)* TILE_SIZE, (self.y - 1)* TILE_SIZE);
    if self.topper then 
        love.graphics.draw(game_Textures['topper'], game_Frames['topper_sets'][self.topper_set][self.tile_id], 
        (self.x - 1)* TILE_SIZE, (self.y - 1)* TILE_SIZE);
    end
end