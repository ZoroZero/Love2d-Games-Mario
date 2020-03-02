SnailChasingState = Class{__includes = BaseState}

function SnailChasingState:init(tilemap, player, snail)
    self.tilemap = tilemap
    self.player = player
    self.snail = snail
    self.animation = Animation {
        frames = {49, 50},
        interval = 0.5
    }
    self.snail.currentAnimation = self.animation

end


-- UPDATE
function SnailChasingState:update(dt)
    self.snail.currentAnimation:update(dt);

    local distance = math.abs(self.player.x - self.snail.x);

    if distance > 5 * TILE_SIZE then 
        self.snail:changeState('moving')
    else
        if self.player.x < self.snail.x then 
            self.snail.direction = 'left';
            self.snail.x = self.snail.x - SNAIL_SPEED*dt;
            -- Check for wall or pit collision 
            local left_Tile = self.tilemap:pointToMap(self.snail.x, self.snail.y);
            local left_Below_Tile = self.tilemap:pointToMap(self.snail.x, self.snail.y + self.snail.height);

            if (left_Tile and left_Below_Tile) and (left_Tile:collidable() or not left_Below_Tile:collidable()) then 
                self.snail.x = self.snail.x + SNAIL_SPEED * dt;
            end
        else 
            self.snail.direction = 'right';
            self.snail.x = self.snail.x + SNAIL_SPEED*dt;
            -- Check for wall or pit collision
            local right_Tile = self.tilemap:pointToMap(self.snail.x + self.snail.width, self.snail.y);
            local right_Below_Tile = self.tilemap:pointToMap(self.snail.x + self.snail.width, self.snail.y + self.snail.height);

            if (right_Tile and right_Below_Tile) and (right_Tile:collidable() or not right_Below_Tile:collidable()) then 
                self.snail.x = self.snail.x - SNAIL_SPEED * dt; 
            end
        end
    end

end
