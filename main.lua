require 'src/Dependencies'

MAP_WIDTH = 20;
MAP_HEIGHT = 20;

CAMERA_SCOLL_SPEEED = 60;
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

    -- TEST MAP
    tiles = {}

    for y = 1, MAP_HEIGHT do
        table.insert( tiles, {} )
        for x = 1,MAP_WIDTH do 
            table.insert( tiles[y], {id = y < 7 and 2 or 1})
        end
    end

    -- SET UP CAMERA SCROLL
    camera_Scroll = 0;

    -- SET UP CHARACTER
    character_X = 6 * 16;
    character_Y = 6* 16 - 20 + 10;
    character_DY = 0;

    standing_Animation = Animation({
        frames = {1}, 
        interval = 1
    })

    moving_Animation = Animation({
        frames = {10, 11}, 
        interval = 0.2
    })

    jumping_Animation = Animation({
        frames = {3}, 
        interval = 1
    })

    moving_Direction = 'right';


    character_Animation = standing_Animation;
end


-- UPDATE FUNCTION
function love.update(dt)
    -- Update timer
    Timer.update(dt);

    -- Update
    character_DY = character_DY + GRAVITY*dt;  
    character_Y = character_Y + character_DY;

    if character_Y > 6 * TILE_SIZE  - CHARACTER_HEIGHT/2 then
        character_Y = 6 * TILE_SIZE  - CHARACTER_HEIGHT/2
        character_DY = 0;
    end
    
    if love.keyboard.isDown('space') and character_DY == 0 then 
        character_DY = JUMP_ACELERATION;
        character_Animation = jumping_Animation;
    end

    character_Animation:update(dt);

    -- 
    if love.keyboard.isDown('left') then 
        character_X = character_X - CAMERA_SCOLL_SPEEED*dt;
        if character_DY == 0 then
            character_Animation = moving_Animation;
        end
        moving_Direction = 'left';
    elseif love.keyboard.isDown('right') then
        character_X = character_X + CAMERA_SCOLL_SPEEED*dt;
        if character_DY == 0 then
            character_Animation = moving_Animation;
        end
        moving_Direction = 'right';
    else
        character_Animation = standing_Animation;
    end

    camera_Scroll = character_X - VIRTUAL_WIDTH/2 + CHARACTER_WIDTH/2;
    
    -- RESET KEY CHECK
    love.keyboard.keysPressed = {};
end


-- RENDER FUNCTION
function love.draw()
    push:start()

    love.graphics.translate(math.floor(-camera_Scroll), 0);
    for y = 1, MAP_HEIGHT do 
        for x = 1, MAP_WIDTH do
            if (x - 1) * 16 - camera_Scroll <= VIRTUAL_WIDTH and (x - 1) * 16 - camera_Scroll >= - 20 then
                local id = tiles[y][x].id;
                if id == 1 then 
                    love.graphics.draw(game_Textures['tile'], game_Frames['tile_sets'][1][27], (x - 1) * 16,(y - 1) * 16);
                end
            end
        end
    end

    love.graphics.draw(game_Textures['green_alien'], game_Frames['character'][character_Animation:getCurrentFrame()], 
    math.floor(character_X), character_Y,
    -- 0 rotation, -1 X scale if moving left or 1 if moving right, and 1 for y scale
    0, moving_Direction == 'left' and -1 or 1, 1,
    -- Set draw offset to sraw from center
    CHARACTER_WIDTH/2 , CHARACTER_HEIGHT/2
    );

    displayFPS();
    push:finish()
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