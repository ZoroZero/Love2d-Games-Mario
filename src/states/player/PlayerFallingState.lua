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
        self.player:changeState('idle');

        self.player.y = (bottom_Left_Tile.y - 1) * TILE_SIZE - self.player.height;
    end

    if love.keyboard.isDown('left') then
        self.player.direction = 'left';
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt;
        self.player:checkLeftCollision();
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt;
        self.player:checkRightCollision();
    end
end
