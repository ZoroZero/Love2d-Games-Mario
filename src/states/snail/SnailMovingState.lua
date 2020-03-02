SnailMovingState = Class{__includes = BaseState}

function SnailMovingState:init(tilemap, player, snail)
    self.tilemap = tilemap
    self.player = player
    self.snail = snail
    self.animation = Animation {
        frames = {49, 50},
        interval = 0.5
    }
    self.snail.currentAnimation = self.animation

    self.movingDirection = math.random(2) == 1 and 'left' or 'right'
    self.snail.direction = self.movingDirection
    self.movingDuration = math.random(5)
    self.movingTimer = 0
end

function SnailMovingState:update(dt)
    self.movingTimer = self.movingTimer + dt
    self.snail.currentAnimation:update(dt)

    if self.movingTimer > self.movingDuration then 
        self.movingDirection = self.movingDirection == 'left' and 'right' or 'left';
        self.snail.direction = self.movingDirection;
        self.movingTimer = 0;
    end

    if self.movingDirection == 'left' then 
        self.snail.x = self.snail.x - SNAIL_SPEED*dt;
        -- Check for wall or pit collision 
        local left_Tile = self.tilemap:pointToMap(self.snail.x, self.snail.y);
        local left_Below_Tile = self.tilemap:pointToMap(self.snail.x, self.snail.y + self.snail.height);

        if (left_Tile and left_Below_Tile) and (left_Tile:collidable() or not left_Below_Tile:collidable()) then 
            self.snail.x = self.snail.x + SNAIL_SPEED * dt; 
            self.movingDirection = 'right';
            self.snail.direction = self.movingDirection;
            self.movingTimer = 0;
        end
    elseif self.movingDirection == 'right' then 
        self.snail.x = self.snail.x + SNAIL_SPEED*dt;
        -- Check for wall or pit collision
        local right_Tile = self.tilemap:pointToMap(self.snail.x + self.snail.width, self.snail.y);
        local right_Below_Tile = self.tilemap:pointToMap(self.snail.x + self.snail.width, self.snail.y + self.snail.height);

        if (right_Tile and right_Below_Tile) and (right_Tile:collidable() or not right_Below_Tile:collidable()) then 
            self.snail.x = self.snail.x - SNAIL_SPEED * dt; 
            self.movingDirection = 'left';
            self.snail.direction = self.movingDirection;
            self.movingTimer = 0;
        end
    end


    if math.abs(self.player.x - self.snail.x) <= 5 * TILE_SIZE then 
        self.snail:changeState('chase');
    end;

end