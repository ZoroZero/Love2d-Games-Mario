
PlayState = Class {__includes = BaseState}

-- INIT FUNCTION
function PlayState:init()
    -- Camera offset
    self.cam_X = 0;
    self.cam_Y = 0;

    -- Set up level
    self.level = LevelMaker.generateMap(MAP_WIDTH, MAP_HEIGHT);
    self.tile_Map = self.level.tile_Map;
    -- Set up back ground
    self.background_image = math.random(3);
    self.background_X = 0;

    -- Set up player
    self.player = Player({
        x = 0, y = 0,
        width = CHARACTER_WIDTH, height = CHARACTER_HEIGHT,
        texture = 'green_alien',
        stateMachine = StateMachine { 
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walk'] = function() return PlayerWalkingState(self.player) end,
            ['jump'] = function() return PlayerJumpingState(self.player) end,
            ['fall'] = function() return PlayerFallingState(self.player) end
        },
        tile_Map = self.tile_Map,
        level = self.level
    })

    self:spawnEnemy();
    self.player:changeState('fall');
end

-- UPDATE FUNCTION
function PlayState:update(dt)
    Timer.update(dt)

    
    self.player:update(dt)


    self.level:update(dt)

    self:updateCamera()
end

-- RENDER FUNCTION
function PlayState:render()

    -- render back ground
    love.graphics.push();

    -- first 256 pixel
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background_image], -math.floor(self.background_X), 0);
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background_image], -math.floor(self.background_X),
        game_Textures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

    -- 256 pixels after that for looping
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background_image], 
    -math.floor(self.background_X) + 256, 0);
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background_image], 
    -math.floor(self.background_X) + 256, game_Textures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)


    love.graphics.translate(-math.floor(self.cam_X), 0)
    -- render stage
    self.level:render(self.cam_X)

    -- render player
    self.player:render()
    love.graphics.pop();
end


-- UPDATE CAMERA FUNCTION
function PlayState:updateCamera()
    if self.player.x < VIRTUAL_WIDTH / 2 - CHARACTER_WIDTH/2 then 
        self.cam_X = 0;
    else
        self.cam_X = self.player.x - (VIRTUAL_WIDTH / 2 - CHARACTER_WIDTH/2);
    end

    self.background_X = (self.cam_X / 3)%256;
end


-- SPAWN ENEMY
function PlayState:spawnEnemy()
    for x = 1, self.tile_Map.width do 
        ground_Found = false;

        for y = 1, self.tile_Map.height do 
            if not ground_Found then 
                if self.tile_Map.tiles[y][x]:collidable() then 
                    ground_Found = true;
                
            
                    if math.random(20) == 1 and x > 10 and y == PLAYER_STANDING then 
                        local snail;
                        snail = Snail{
                            texture = 'creatures',
                            x = (x - 1) * TILE_SIZE, y = (y - 2) * TILE_SIZE,
                            width = TILE_SIZE, height = TILE_SIZE,
                            stateMachine = StateMachine {
                                ['idle'] = function() return SnailIdleState(self.tile_Map, self.player, snail) end,
                                ['moving'] = function() return SnailMovingState(self.tile_Map, self.player, snail) end,
                                ['chase'] = function() return SnailChasingState(self.tile_Map, self.player, snail) end
                            },
                            tile_Map = self.tile_Map,
                            level = self.level
                        }

                        snail:changeState('idle', {
                            wait = 1;
                        })

                        table.insert(self.level.entities, snail)
                        break;
                    end
                end
            end
        end
    end

end