PlayerJumpingState = Class {__includes = BaseState}

-- INIT
function PlayerJumpingState:init(player)
    self.player = player;
    self.animation = Animation({
        frames = {3},
        interval = 1,
    });

    self.player.currentAnimation = self.animation;
end

-- ENTER
function PlayerJumpingState:enter()
    self.player.dy = JUMP_ACELERATION;
end

-- UPDATE
function PlayerJumpingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + GRAVITY*dt;
    self.player.y = self.player.y + self.player.dy;

    if self.player.dy >= 0 then
        self.player:changeState('fall');
    end

    self.player.y = self.player.y + self.player.dy;

    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
    end
end

