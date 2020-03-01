
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
    self.player:changeState('fall');
end

-- UPDATE FUNCTION
function PlayState:update(dt)
    Timer.update(dt)

    
    self.player:update(dt)
    -- self.level:update(dt)

    self:updateCamera()
end

-- RENDER FUNCTION
function PlayState:render()

    -- render back ground

    love.graphics.translate(-math.floor(self.cam_X), 0)
    -- render stage
    self.level:render(self.cam_X)

    -- render player
    self.player:render()
end


-- UPDATE CAMERA FUNCTION
function PlayState:updateCamera()
    self.cam_X = self.player.x - (VIRTUAL_WIDTH / 2 - CHARACTER_WIDTH/2);
end