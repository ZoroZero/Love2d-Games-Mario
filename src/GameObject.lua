GameObject = Class{}


-- Init
function GameObject:init(params)
    self.x = params.x;
    self.y = params.y;

    self.width = params.width;
    self.height = params.height;

    self.texture = params.texture;
    self.frame = params.frame;

    -- Collision
    self.solid = params.solid;
    self.collidable = params.collidable;
    self.consumable = params.consumable;
    
    self.onConsume = params.onConsume;
    self.hit = params.hit;
    self.onCollide = params.onCollide;
end

-- Update
function GameObject:update(dt)

end

-- Render
function GameObject:render()
    love.graphics.draw(game_Textures[self.texture], game_Frames[self.texture][self.frame], self.x, self.y);
end


-- Check collision
function GameObject:collides(target)
    return not( self.x > target.x + target.width or self.x + self.width < target.x 
                or self.y > target.y + target.height or self.y + self.height < target.y )
end