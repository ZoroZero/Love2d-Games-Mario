Entity = Class {}

-- INIT ENTITY
function Entity:init(params)
    -- Position
    self.x = params.x;
    self.y = params.y;
    self.width = params.width;
    self.height = params.height;
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
        -- Position
        math.floor(self.x) + self.width/2, math.floor(self.y) + self.height/2, 
        -- Rotation
        0, self.direction == 'right' and 1 or -1, 1, 
        -- Drawing offset
        self.width/2, self.height/2)
end

-- CHANGE STATE
function Entity:changeState(state, params)
    self.stateMachine:change(state, params);
end


-- CHECK COLLISION FUNCTION
function Entity:collide(target)
    return not(self.x > target.x + target.width or self.x + self.width < target.x 
                or self.y > target.y + target.height or self.y + self.height < target.y)
end