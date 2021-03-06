LevelMaker = Class{}

-- Generate map function
function LevelMaker.generateMap(map_width, map_height)
    local tile_map = TileMap(map_width, map_height);
    local objects = {};
    local entities = {};
    local tiles = {};
    local tile_Set = math.random(#game_Frames['tile_sets']);
    local topper_Set = math.random(#game_Frames['topper_sets']);
    local block_height = 4;
    local has_Key = false;
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
        
        generate_Block = math.random(10) == 1;
        generate_Bush = math.random(8) == 1;
        pillar_Height = math.random(1,3);
        block_height = 4;

        -- generate pit
        if generate_Pit and x > 10 and x < map_width - 10 then
            goto continue;
        end
 
        -- generate pillar
        if generate_Pillar and (x > 10 and x < map_width - 10) then 
            block_height = 2;
            for pillar = PLAYER_STANDING, PLAYER_STANDING - pillar_Height, -1 do 
                tiles[pillar][x] =  Tile(x, pillar, GROUND_TILE, (pillar == PLAYER_STANDING - pillar_Height) and true or false, 
                tile_Set, topper_Set);
            end

        -- generate bushes 
        elseif generate_Bush then 
            table.insert( objects, GameObject{
                texture = 'bushes',
                        x = (x - 1) * TILE_SIZE,
                        y = (PLAYER_STANDING - 2) * TILE_SIZE,
                        width = TILE_SIZE,
                        height = TILE_SIZE,

                        -- make it a random variant
                        frame = BUSH_IDS[math.random(#BUSH_IDS)] + math.random(4) * 7,
                        collidable = false,
                        hit = false,
                        solid = false,

                        -- collision function takes itself
                        onCollide = function() end
            });
        end

        for ground = PLAYER_STANDING, map_height do
            if x <= 10 or x >= map_width - 10 then 
                tiles[ground][x] = Tile(x, ground, GROUND_TILE,  (ground == PLAYER_STANDING) and true or false, 
                tile_Set, topper_Set);
            else
                tiles[ground][x] = Tile(x, ground, GROUND_TILE,  (not generate_Pillar and ground == PLAYER_STANDING) and true or false, 
                tile_Set, topper_Set);
            end
        end 
        ::continue::

        if generate_Block and not(x <= 10 or x >= map_width - 10) then 
            table.insert( objects, GameObject{
                        texture = 'jump_blocks',
                        x = (x - 1) * TILE_SIZE,
                        y = (block_height - 1) * TILE_SIZE,
                        width = TILE_SIZE,
                        height = TILE_SIZE,

                        -- make it a random variant
                        frame = math.random(NUM_BLOCKS),
                        collidable = true,
                        hit = false,
                        solid = true,

                        -- collision function takes itself
                        onCollide = function(obj) 
                            if not obj.hit then 
                                -- chance to spawn key inside when hit
                                local gen_key = true;
                                if gen_key and not has_Key then
                                    has_Key = true;
                                    local key = GameObject{
                                        texture = 'keys',
                                        x = (x - 1) * TILE_SIZE,
                                        y = obj.y - 0.5 * TILE_SIZE,
                                        width = TILE_SIZE,
                                        height = TILE_SIZE,

                                        -- make it a random variant
                                        frame = math.random(4),
                                        collidable = true,
                                        hit = false,
                                        solid = false,
                                        consumable = true,

                                        -- collision function takes itself
                                        onConsume = function(player, obj)
                                            game_Sounds['pickup']:play()
                                            player.has_Key = true;
                                        end
                                    };

                                    Timer.tween(0.1, {
                                        [key] = {y = obj.y -  TILE_SIZE}
                                    });
                                    game_Sounds['powerup-reveal']:play()
                                    table.insert(objects, key);
                                else
                                    local gem = GameObject{
                                        texture = 'gems',
                                        x = (x - 1) * TILE_SIZE,
                                        y = obj.y - 0.5 * TILE_SIZE,
                                        width = TILE_SIZE,
                                        height = TILE_SIZE,

                                        -- make it a random variant
                                        frame = math.random(NUM_GEMS),
                                        collidable = true,
                                        hit = false,
                                        solid = false,
                                        consumable = true,

                                        -- collision function takes itself
                                        onConsume = function(player, obj)
                                            game_Sounds['pickup']:play()
                                            player.score = player.score + 100;
                                        end
                                    };

                                    Timer.tween(0.1, {
                                        [gem] = {y = obj.y -  TILE_SIZE}
                                    });
                                    game_Sounds['powerup-reveal']:play()
                                    table.insert(objects, gem);
                                end
                                game_Sounds['empty-block']:play()
                                obj.hit = true;
                            end
                        end
            });
        end

    end

    -- -- generate flag poll;
    -- local flag = FlagPoll{
    --     texture = 'polls',
    --     -- x = (map_width - 7) * TILE_SIZE - POLL_WIDTH,
    --     x = 7* TILE_SIZE - POLL_WIDTH,
    --     y = (PLAYER_STANDING - 1) * TILE_SIZE - POLL_HEIGHT,
    --     width = POLL_WIDTH,
    --     height =  POLL_HEIGHT,

    --     -- make it a random variant
    --     frame = 1,
    --     collidable = true,
    --     hit = false,
    --     solid = true,
    --     consumable = true,

    --     onConsume = function(player, obj)
    --         local animation = Animation{
    --             frames = {3},
    --             interval = 1
    --         }
    --         obj.currentAnimation = animation;
    --     end
    -- }
    -- table.insert(objects, flag);


    -- GENERATE LOCK AT THE END OF LEVEL
    local lock = GameObject{
        texture = 'keys',
        x = (map_width - 7) * TILE_SIZE,
        y = (PLAYER_STANDING - 2) * TILE_SIZE,
        width = TILE_SIZE,
        height = TILE_SIZE,

        -- make it a random variant
        frame = math.random(5,8),
        collidable = true,
        hit = false,
        solid = true,
        consumable = false,
        -- collision function takes itself
        onCollide = function(player, obj)
                        if player.has_Key then 
                            game_Sounds['pickup']:play()
                            local flag = FlagPoll{
                                texture = 'polls',
                                x = (map_width - 5) * TILE_SIZE - POLL_WIDTH,
                                -- x = 7* TILE_SIZE - POLL_WIDTH,
                                y = (PLAYER_STANDING - 1) * TILE_SIZE - POLL_HEIGHT,
                                width = POLL_WIDTH,
                                height =  POLL_HEIGHT,
                        
                                -- make it a random variant
                                frame = 1,
                                collidable = true,
                                hit = false,
                                solid = true,
                                consumable = true,
                        
                                onConsume = function(player, obj)
                                    local animation = Animation{
                                        frames = {3},
                                        interval = 1
                                    }
                                    obj.currentAnimation = animation;
                                end
                            }
                            table.insert(objects, flag);
                            player.has_Key = false;
                        end
                    end
    };
    table.insert(objects, lock);


    tile_map.tiles = tiles
    return GameLevel(entities, objects, tile_map);
end