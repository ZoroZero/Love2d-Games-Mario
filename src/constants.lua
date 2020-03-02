require 'src/Ultil'

-- WINDOW DIMENSIONS
WINDOW_WIDTH = 1280;
WINDOW_HEIGHT = 720;

-- VIRTUAL DIMENSIONS
VIRTUAL_WIDTH = 256;
VIRTUAL_HEIGHT = 144;


-- CHARACTER DIMENSIONS
CHARACTER_WIDTH = 16;
CHARACTER_HEIGHT = 20;
PLAYER_WALK_SPEED = 60;


-- SNAIL DIMENSION 
SNAIL_HEIGHT = 16;
SNAIL_WIDTH = 16;
SNAIL_SPEED =10;
-- TILE DIMENSIONS
TILE_SIZE = 16;

-- TILE SET DIMENSIONS
NUM_TILE_SETS_PER_ROW = 6;
NUM_TILE_SETS_PER_COL = 10;

-- NUM OF TILES IN A SET
NUM_TILES_PER_ROW  = 5;
NUM_TILES_PER_COL = 4;

-- NUM OF TOPPER SETS
NUM_TOPPER_SETS_PER_ROW = 6;
NUM_TOPPER_SETS_PER_COL = 18;

-- GRAVITY CONSTANT
GRAVITY = 10;
JUMP_ACELERATION = -3.5;

-- BACK GROUND DIMENSIONS
BACKGROUND_WIDTH = 256;
BACKGROUND_HEIGHT = 128;

-- MAP TILE ID
EMPTY_TILE = 5
GROUND_TILE = 3
PLAYER_STANDING = 7;


-- COLLIDABLE TILES
COLLIDABLE_TILES = {
    GROUND_TILE
}

-- NUMBER OF BLOCK
NUM_BLOCKS = 30;
NUM_GEMS = 8;
-- BUSH ID
BUSH_IDS = {1, 2, 5, 6, 7}

-- SOUND
game_Sounds = {
    ['death'] = love.audio.newSource('assets/sounds/death.wav', 'static'),
    ['empty-block'] = love.audio.newSource('assets/sounds/empty-block.wav', 'static'),
    ['jump'] = love.audio.newSource('assets/sounds/jump.wav', 'static'),
    ['kill'] = love.audio.newSource('assets/sounds/kill.wav', 'static'),
    ['kill2'] = love.audio.newSource('assets/sounds/kill2.wav', 'static'),
    ['music'] = love.audio.newSource('assets/sounds/music.wav', 'static'),
    ['pickup'] = love.audio.newSource('assets/sounds/pickup.wav', 'static'),
    ['powerup-reveal'] = love.audio.newSource('assets/sounds/powerup-reveal.wav', 'static')
}

-- FONT
game_Fonts = {
    ['smallFont'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['mediumFont'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['largeFont'] = love.graphics.newFont('assets/fonts/font.ttf', 24),
    ['titleFont'] = love.graphics.newFont('assets/fonts/ArcadeAlternate.ttf', 32)
}

-- TEXTURE
game_Textures = {
    ['tile'] = love.graphics.newImage('assets/graphics/tiles.png'),
    ['topper'] = love.graphics.newImage('assets/graphics/tile_tops.png'),
    ['backgrounds'] = love.graphics.newImage('assets/graphics/backgrounds.png'),
    ['green_alien'] = love.graphics.newImage('assets/graphics/green_alien.png'),
    ['jump_blocks'] = love.graphics.newImage('assets/graphics/jump_blocks.png'),
    ['bushes'] = love.graphics.newImage('assets/graphics/bushes_and_cacti.png'),
    ['creatures'] = love.graphics.newImage('assets/graphics/creatures.png'),
    ['gems'] = love.graphics.newImage('assets/graphics/gems.png')
}


-- GAME FRAMES
game_Frames = {
    ['tiles'] = generateQuad(game_Textures['tile'], TILE_SIZE, TILE_SIZE),
    ['toppers'] = generateQuad(game_Textures['topper'], TILE_SIZE, TILE_SIZE),
    ['backgrounds'] = generateQuad(game_Textures['backgrounds'], BACKGROUND_WIDTH, BACKGROUND_HEIGHT),
    ['green_alien'] = generateQuad(game_Textures['green_alien'], CHARACTER_WIDTH, CHARACTER_HEIGHT),
    ['jump_blocks'] = generateQuad(game_Textures['jump_blocks'], TILE_SIZE, TILE_SIZE),
    ['bushes'] = generateQuad(game_Textures['bushes'], TILE_SIZE, TILE_SIZE),
    ['creatures'] = generateQuad(game_Textures['creatures'], TILE_SIZE, TILE_SIZE),
    ['gems'] = generateQuad(game_Textures['gems'], TILE_SIZE, TILE_SIZE)
}

-- TABLE OF TILE SET
game_Frames['tile_sets'] = generateTileSets(game_Frames['tiles'], NUM_TILE_SETS_PER_ROW, NUM_TILE_SETS_PER_COL,
                                            NUM_TILES_PER_ROW, NUM_TILES_PER_COL);

-- TABLE OF TOPPER
game_Frames['topper_sets'] = generateTileSets(game_Frames['toppers'], NUM_TOPPER_SETS_PER_ROW, NUM_TOPPER_SETS_PER_COL,
                                            NUM_TILES_PER_ROW, NUM_TILES_PER_COL);