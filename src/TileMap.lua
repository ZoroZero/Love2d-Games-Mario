TileMap = Class {}

-- INIT FUNCTION
function TileMap:init(width, height)
    -- Tile map dimension
    self.width = width;
    self.height = height;

    -- Tiles inside a tile map
    self.tiles = {}
end



-- UPDATE FUNCTION
function TileMap:update(dt)

end


-- FUNCTION TO CONVERT REAL X AND Y TO MAP X, Y
function TileMap:pointToMap(x, y)
    if x < 0 or x > self.width * TILE_SIZE or y < 0 or y > self.height * TILE_SIZE then
        return nil;
    end

    return self.tiles[math.floor(y/TILE_SIZE) + 1][math.floor(x / TILE_SIZE) + 1];
end


-- RENDER FUNCTION
function TileMap:render(camera_Scroll)
    for y = 1, self.height do 
        for x = 1, self.width do
            if (x - 1) * TILE_SIZE - camera_Scroll <= VIRTUAL_WIDTH and (x - 1) * TILE_SIZE - camera_Scroll >= -20 then
                self.tiles[y][x]:render();
            end
        end
    end
end