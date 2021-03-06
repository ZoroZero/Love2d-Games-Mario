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
    
        self.player.y = self.player.y + 1;
        local collided_Objects = self.player:checkObjectCollision();
        self.player.y = self.player.y - 1;

        if #collided_Objects == 0 and (bottom_Left_Tile and bottom_Right_Tile) and not (bottom_Left_Tile:collidable() or bottom_Right_Tile:collidable()) then 
            self.player.dy = 0;
            self.player:changeState('fall');
        elseif love.keyboard.isDown('left') then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt;
            self.player.direction = 'left';
            self.player:checkLeftCollision(dt);
        elseif love.keyboard.isDown('right') then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt;
            self.player.direction = 'right';
            self.player:checkRightCollision(dt);
        end
    end
    
    if love.keyboard.isDown('space') then 
        game_Sounds['jump']:play();
        self.player:changeState('jump', JUMP_ACELERATION);
    end

    -- Check if collide with any consumable
    for k, object in pairs(self.player.level.objects) do 
        if object:collides(self.player) then 
            if object.consumable then 
                object.onConsume(self.player, object)
                if not (getmetatable(object) == FlagPoll) then
                    table.remove(self.player.level.objects, k);
                else 
                    Timer.tween(1, {
                        [object] = {flag_Y = object.y + POLL_HEIGHT - 16}
                    }):finish(function()
                        game_State_Machine:change('standby', {score = self.player.score, stage = self.player.stage + 1})
                    end);
                end
            elseif object.solid and object.texture == 'keys' then 
                object.onCollide(self.player, object);
            end
        end
    end

    -- Check if collide with enemy
    for k, entity in pairs(self.player.level.entities) do 
        if entity:collide(self.player) then 
            game_Sounds['death']:play()
            game_State_Machine:change('game_over', {score = self.player.score});
        end
    end
end
