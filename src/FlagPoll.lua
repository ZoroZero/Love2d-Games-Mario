FlagPoll = Class {__includes = GameObject}

-- init
function FlagPoll:init(params)
    GameObject.init(self, params)
    -- Flag position
    self.flag_X = self.x + TILE_SIZE/2;
    self.flag_Y = self.y;

    -- Flag texture
    self.flag_Texture = 3;
    
    self.currentAnimation = Animation{
        frames = {1,2},
        interval = 0.2,
    }
end

-- update
function FlagPoll:update(dt)
    self.currentAnimation:update(dt);
end

-- render
function FlagPoll:render()
    -- render the poll
    GameObject.render(self)

    -- render flag
    love.graphics.draw(game_Textures['polls'], game_Frames['flag_sets'][self.flag_Texture][self.currentAnimation:getCurrentFrame()],
                        self.flag_X, self.flag_Y);
end