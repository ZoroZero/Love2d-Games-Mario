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

    if self.player.y > 6 * TILE_SIZE - CHARACTER_HEIGHT/2 then 
        self.player.y = 6 * TILE_SIZE - CHARACTER_HEIGHT/2;
        self.player:changeState('idle');
    end 

    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
    end
end
