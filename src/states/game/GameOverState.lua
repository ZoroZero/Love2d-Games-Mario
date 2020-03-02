GameOverState = Class {__includes = BaseState}

BOARD_WIDTH = 150;
BOARD_HEIGHT = 100;
-- INIT
function GameOverState:init()
    self.background = math.random(1,3)
end

-- ENTER
function GameOverState:enter(params)
    self.score = params.score;
    self.background = math.random(1,3);
end

-- UPDATE
function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then 
        game_State_Machine:change('start');
    end

    if love.keyboard.wasPressed('escape') then 
        love.event.quit();
    end
end

-- RENDER
function GameOverState:render()
    -- render background
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background], 0, 0);
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background], 0,
        game_Textures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

    -- render score board
    love.graphics.setColor(56/255,56/255,56/255,0.9);
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2 - BOARD_WIDTH/2, VIRTUAL_HEIGHT/2 - BOARD_HEIGHT/2 , BOARD_WIDTH, BOARD_HEIGHT);

    -- Render text
    love.graphics.setColor(1, 155/255, 155/255, 1)
    love.graphics.setFont(game_Fonts['largeFont']);
    love.graphics.printf("YOU DIED!", 0, VIRTUAL_HEIGHT/2 - 40, VIRTUAL_WIDTH, 'center');

    love.graphics.setFont(game_Fonts['mediumFont']);
    love.graphics.printf("Score: " .. tostring(self.score), 0, VIRTUAL_HEIGHT/2, VIRTUAL_WIDTH, 'center');
    love.graphics.setFont(game_Fonts['smallFont']);
    love.graphics.printf("Press enter to play again", 0, VIRTUAL_HEIGHT/2 + 35, VIRTUAL_WIDTH, 'center');
end