Snail = Class {__includes = Entity}

-- INIT
function Snail:init(params)
    Entity.init(self, params)
end

-- RENDER
function Snail:render()
    love.graphics.draw(game_Textures[self.texture], game_Frames[self.texture][self.currentAnimation:getCurrentFrame()],
    -- Position
    math.floor(self.x) + self.width/2, math.floor(self.y) + self.height/2, 
    -- Rotation
    0, self.direction == 'right' and -1 or 1, 1, 
    -- Drawing offset
    CHARACTER_WIDTH/2, 16/2)
end