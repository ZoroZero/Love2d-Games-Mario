require 'src/Dependencies'


-- LOAD FUNCTION
function love.load()
    -- SET UP TEXTURE RENDER OPTIONS
    love.graphics.setDefaultFilter('nearest', 'nearest');

    -- SET UP WINDOW TITLE
    love.window.setTitle('Mari0');

    -- SET RANDOM SEED
    math.randomseed(os.time());

    -- SET WINDOW SCREEN
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        resizable = true,
        vsyn = true,
        fullscreen = false
    })

    -- SET UP STATE MACHINE
    game_State_Machine = StateMachine {
    }
    -- game_State_Machine:change('title');
    
    -- SET UP KEY CHECK
    love.keyboard.keysPressed = {};
end


-- UPDATE FUNCTION
function love.update(dt)
    love.keyboard.keysPressed = {};
end


-- RENDER FUNCTION
function love.draw()
    displayFPS();
end


-- RESIZE WINDOW FUNCTION
function love.resize(w, h)
    push:resize(w, h);
end


-- CHECK WHICH KEY WAS PRESSED
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true;
end

-- FUNCTION TO CHECK IF A SPECIFIC KEY WAS PRESSED
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key];
end

-- DISPLAY FPS FUNCTION
function displayFPS()
    love.graphics.setFont(game_Fonts['smallFont']);
    love.graphics.setColor(255, 255, 0, 255);
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10);
end