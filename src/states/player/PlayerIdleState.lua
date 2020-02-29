PlayerIdleState = Class {__includes = BaseState}

-- INIT
function PlayerIdleState:init(player)
    self.player = player;
    self.animation = Animation({
        frames = {1},
        interval = 1
    })

    self.player.currentAnimation = self.animation;
end


-- UPDATE
function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') then 
        self.player.direction = 'left';
        self.player:changeState('walk');
    elseif love.keyboard.isDown('right') then 
        self.player.direction = 'right';
        self.player:changeState('walk');
    end

    if love.keyboard.isDown('space') then 
        self.player:changeState('jump');
    end
end
