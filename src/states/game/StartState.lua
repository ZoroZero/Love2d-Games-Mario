StartState = Class {__includes = BaseState}


-- INIT
function StartState:init()
    self.map = LevelMaker.generateMap(20, 10);
    self.background = math.random(1,3)
end

-- UPDATE
function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then 
        game_State_Machine:change('play', {score = 0});
    end
end

-- RENDER
function StartState:render()
    -- render background
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background], 0, 0);
    love.graphics.draw(game_Textures['backgrounds'], game_Frames['backgrounds'][self.background], 0,
        game_Textures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

    -- render map
    self.map:render(0);
    
    -- render title
    love.graphics.setFont(game_Fonts['titleFont']);
    drawShadowText("Super Mario 0", VIRTUAL_HEIGHT/2 - 30);
    love.graphics.printf("Super Mario 0", 0,  VIRTUAL_HEIGHT/2 - 30, VIRTUAL_WIDTH, 'center');

    -- Press enter
    love.graphics.setFont(game_Fonts['mediumFont']);
    drawShadowText("Press enter ...", VIRTUAL_HEIGHT/2 + 50);
    love.graphics.printf("Press enter ...", 2, VIRTUAL_HEIGHT/2 + 50, VIRTUAL_WIDTH, 'center');
end

-- Print shadow function
function drawShadowText(text, y)
    love.graphics.setColor(0, 0, 0, 255);
    love.graphics.printf(text, 2, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 1, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 0, y + 1, VIRTUAL_WIDTH, 'center');
    love.graphics.printf(text, 1, y + 2, VIRTUAL_WIDTH, 'center');
    love.graphics.setColor(255, 255, 255, 255)
end