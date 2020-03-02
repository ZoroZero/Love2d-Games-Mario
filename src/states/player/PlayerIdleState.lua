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

    bottom_Left_Tile = self.player.tile_Map:pointToMap(self.player.x , self.player.y + self.player.height);
    bottom_Right_Tile = self.player.tile_Map:pointToMap(self.player.x + self.player.width - 1, self.player.y + self.player.height);
    
    self.player.y = self.player.y + 1;
    local collided_Objects = self.player:checkObjectCollision();
    self.player.y = self.player.y - 1;

    
    if #collided_Objects == 0 and (bottom_Left_Tile and bottom_Right_Tile) and not (bottom_Left_Tile:collidable() or bottom_Right_Tile:collidable()) then 
        self.player.dy = 0;
        self.player:changeState('fall');

    elseif love.keyboard.isDown('left') then 
        self.player.direction = 'left';
        self.player:changeState('walk');

    elseif love.keyboard.isDown('right') then 
        self.player.direction = 'right';
        self.player:changeState('walk');
    end

    if love.keyboard.isDown('space') then 
        self.player:changeState('jump', JUMP_ACELERATION);
    end

    -- Check if collide with enemy
    for k, entity in pairs(self.player.level.entities) do 
        if entity:collide(self.player) then 
            game_State_Machine:change('start');
        end
    end
end
