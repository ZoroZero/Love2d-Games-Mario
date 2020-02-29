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
        if love.keyboard.isDown('left') then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt;
            self.player.direction = 'left';
        elseif love.keyboard.isDown('right') then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt;
            self.player.direction = 'right';
        end
    end
    
    if love.keyboard.isDown('space') then 
        self.player:changeState('jump');
    end
end
