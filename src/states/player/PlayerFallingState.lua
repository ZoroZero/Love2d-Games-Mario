PlayerFallingState = Class {__includes = BaseState}

-- INIT
function PlayerFallingState:init(player)
    self.player = player;
    self.animation = Animation({
        frames = {3},
        interval = 1,
    })

    self.player.currentAnimation = self.animation;
end

-- UPDATE
function PlayerFallingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + GRAVITY*dt;
    self.player.y = self.player.y + self.player.dy;

    -- Check for ground below
    bottom_Left_Tile = self.player.tile_Map:pointToMap(self.player.x, self.player.y + self.player.height);
    bottom_Right_Tile = self.player.tile_Map:pointToMap(self.player.x + self.player.width - 1, self.player.y + self.player.height);

    if (bottom_Left_Tile and bottom_Right_Tile) and (bottom_Left_Tile:collidable() or bottom_Right_Tile:collidable()) then 
        self.player.dy = 0;
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then 
            self.player:changeState('walk');
        else
            self.player:changeState('idle');
        end
        self.player.y = (bottom_Left_Tile.y - 1) * TILE_SIZE - self.player.height;
    end

    -- Change direction mid air
    if love.keyboard.isDown('left') then
        self.player.direction = 'left';
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt;
        self.player:checkLeftCollision(dt);
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt;
        self.player:checkRightCollision(dt);
    end

    -- check object collisions
    for k, object in pairs(self.player.level.objects) do 
        if object:collides(self.player) then 
            if object.solid then
                self.player.dy = 0; 
                self.player.y = object.y - self.player.height;
                if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
                    self.player:changeState('walk');
                else
                    self.player:changeState('idle');
                end
            end
        end
    end
end
