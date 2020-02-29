Entity = Class {}

-- INIT ENTITY
function Entity:init(params)
    -- Position
    self.x = params.x;
    self.y = params.y;

    -- Velocity
    self.dx = 0;
    self.dy = 0;

    -- Texture
    self.texture = params.texture;
    self.stateMachine = params.stateMachine;

    -- Direction
    self.direction = 'left';

    -- Tile map
    self.tile_Map = params.tile_Map;

    -- Level
    self.level = params.level;
end


-- UPDATE FUNCTION
function Entity:update(dt)
    self.stateMachine:update(dt);
end


-- RENDER FUNCTION
function Entity:render()
    love.graphics.draw(game_Textures[self.texture], game_Frames[self.texture][self.currentAnimation:getCurrentFrame()],
        math.floor(self.x), math.floor(self.y), 
        
        0, self.direction == 'right' and 1 or -1, 1, 
        
        CHARACTER_WIDTH/2, CHARACTER_HEIGHT/2)
end

-- CHANGE STATE
function Entity:changeState(state, params)
    self.stateMachine:change(state, params);
end