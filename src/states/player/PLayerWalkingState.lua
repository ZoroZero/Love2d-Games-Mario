PlayerWalkingState = Class {__includes = BaseState}

-- INIT
function PlayerWalkingState:init(player)
    self.player = player;
    self.animation = Animation({
        frames = {10,11},
        interval = 0.1
    })

    self.player.currentAnimation = self.animation;
end


-- UPDATE
function PlayerWalkingState:update(dt)
    -- update animation
    self.player.currentAnimation:update(dt);
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
        self.player:changeState('idle');
    else
        -- check if ground is below
        bottom_Left_Tile = self.player.tile_Map:pointToMap(self.player.x , self.player.y + self.player.height);
        bottom_Right_Tile = self.player.tile_Map:pointToMap(self.player.x + self.player.width - 1, self.player.y + self.player.height);
    
        if (bottom_Left_Tile and bottom_Right_Tile) and not (bottom_Left_Tile:collidable() or bottom_Right_Tile:collidable()) then 
            self.player.dy = 0;
            self.player:changeState('fall');
            -- self.player.y = (bottom_Left_Tile.y - 1) * TILE_SIZE - self.player.height;
        elseif love.keyboard.isDown('left') then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt;
            self.player.direction = 'left';
            self.player:checkLeftCollision();
        elseif love.keyboard.isDown('right') then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt;
            self.player.direction = 'right';
            self.player:checkRightCollision();
        end
    end
    
    if love.keyboard.isDown('space') then 
        self.player:changeState('jump');
    end
end
