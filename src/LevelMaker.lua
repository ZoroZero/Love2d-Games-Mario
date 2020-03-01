LevelMaker = Class{}

-- Generate map function
function LevelMaker.generateMap(map_width, map_height)
    local tile_map = TileMap(map_width, map_height);
    local objects = {};
    local entities = {};
    local tiles = {};
    local tile_Set = math.random(#game_Frames['tile_sets']);
    local topper_Set = math.random(#game_Frames['topper_sets']);

    -- generate table first
    for y = 1, map_height do 

        table.insert( tiles, {} )

        for x = 1, map_width do 
            table.insert(tiles[y], Tile(x, y, EMPTY_TILE, false, tile_Set, topper_Set));
        end
    end

    -- Generate GROUND_TILE, pillar and pit
    for x = 1, map_width do 
        generate_Pillar = math.random(5) == 1;
        generate_Pit = math.random(10) == 1;
        pillar_Height = math.random(1,3);
        generate_Block = math.random(10);

        if generate_Pit and x > 7 then
            goto continue;
        end
 
        if generate_Pillar and x > 7 then 
            for pillar = PLAYER_STANDING, PLAYER_STANDING - pillar_Height, -1 do 
                tiles[pillar][x] =  Tile(x, pillar, GROUND_TILE, (pillar == PLAYER_STANDING - pillar_Height) and true or false, 
                tile_Set, topper_Set);
            end
        end

        for ground = PLAYER_STANDING, map_height do
            if x <= 7 then 
                tiles[ground][x] = Tile(x, ground, GROUND_TILE,  (ground == PLAYER_STANDING) and true or false, 
                tile_Set, topper_Set);
            else
                tiles[ground][x] = Tile(x, ground, GROUND_TILE,  (not generate_Pillar and ground == PLAYER_STANDING) and true or false, 
                tile_Set, topper_Set);
            end
        end 
        ::continue::

        if generate_Block == 1 then 
            table.insert( objects, GameObject{
                texture = 'jump_blocks',
                        x = (x - 1) * TILE_SIZE,
                        y = (3 - 1) * TILE_SIZE,
                        width = TILE_SIZE,
                        height = TILE_SIZE,

                        -- make it a random variant
                        frame = math.random(10),
                        collidable = true,
                        hit = false,
                        solid = true,

                        -- collision function takes itself
                        onCollide = function() end
            });
        end

    end

    tile_map.tiles = tiles
    return GameLevel(entity, objects, tile_map);
end