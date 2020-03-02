StandByState = Class {__includes = BaseState}

-- ENTER
function StandByState:enter(params)
    self.score = params.score;
    self.stage = params.stage;
    self.opacity = 0;
    Timer.tween(0.9, {
        [self] = {opacity = 0.8};
    }):finish(function()
                game_State_Machine:change('play', {score = self.score, stage = self.stage});
            end);
end

-- UPDATE
function StandByState:update(dt)
    
    -- game_State_Machine:change('play', {score = self.score, stage = self.stage})

end

-- RENDER
function StandByState:render()
    -- render score board
    love.graphics.setColor(1,1,1,self.opacity);
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - BOARD_WIDTH/2, VIRTUAL_HEIGHT/2 - BOARD_HEIGHT/2 , BOARD_WIDTH, BOARD_HEIGHT);

    -- Render text
    love.graphics.setColor(1, 155/255, 155/255, 1)
    love.graphics.setFont(game_Fonts['largeFont']);
    love.graphics.printf("Stage " .. tostring(self.stage), 0, VIRTUAL_HEIGHT/2 - 40, VIRTUAL_WIDTH, 'center');

    love.graphics.setFont(game_Fonts['mediumFont']);
    love.graphics.printf("Score: " .. tostring(self.score), 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center');
    love.graphics.setFont(game_Fonts['smallFont']);
    love.graphics.printf("Loading ...", 0, VIRTUAL_HEIGHT/2 + 35, VIRTUAL_WIDTH, 'center');
end