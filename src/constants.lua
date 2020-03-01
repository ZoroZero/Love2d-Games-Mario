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
JUMP_ACELERATION = -3;

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

-- BUSH ID
BUSH_IDS = {1, 2, 5, 6, 7}

-- SOUND
game_Sounds = {
    -- ['confirm'] = love.audio.newSource('assets/sounds/confirm.wav', 'static'),
    -- ['clock'] = love.audio.newSource('assets/sounds/clock.wav', 'static'),
    -- ['error'] = love.audio.newSource('assets/sounds/error.wav', 'static'),
    -- ['game-over'] = love.audio.newSource('assets/sounds/game-over.wav', 'static'),
    -- ['match'] = love.audio.newSource('assets/sounds/match.wav', 'static'),
    -- ['music'] = love.audio.newSource('assets/sounds/music.mp3', 'static'),
    -- ['music2'] = love.audio.newSource('assets/sounds/music2.mp3', 'static'),
    -- ['music3'] = love.audio.newSource('assets/sounds/music3.mp3', 'static'),
    -- ['next-level'] = love.audio.newSource('assets/sounds/next-level.wav', 'static'),
    -- ['select'] = love.audio.newSource('assets/sounds/select.wav', 'static'),
}

-- FONT
game_Fonts = {
    ['smallFont'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['mediumFont'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['largeFont'] = love.graphics.newFont('assets/fonts/font.ttf', 24)
}

-- TEXTURE
game_Textures = {
    -- ['background'] = love.graphics.newImage('assets/graphics/background.png'),
    -- ['main'] = love.graphics.newImage('assets/graphics/match3.png')
    ['tile'] = love.graphics.newImage('assets/graphics/tiles.png'),
    ['topper'] = love.graphics.newImage('assets/graphics/tile_tops.png'),
    ['backgrounds'] = love.graphics.newImage('assets/graphics/backgrounds.png'),
    ['green_alien'] = love.graphics.newImage('assets/graphics/green_alien.png'),
    ['jump_blocks'] = love.graphics.newImage('assets/graphics/jump_blocks.png'),
    ['bushes'] = love.graphics.newImage('assets/graphics/bushes_and_cacti.png')
}


-- GAME FRAMES
game_Frames = {
    ['tiles'] = generateQuad(game_Textures['tile'], TILE_SIZE, TILE_SIZE),
    ['toppers'] = generateQuad(game_Textures['topper'], TILE_SIZE, TILE_SIZE),
    ['backgrounds'] = generateQuad(game_Textures['backgrounds'], BACKGROUND_WIDTH, BACKGROUND_HEIGHT),
    ['green_alien'] = generateQuad(game_Textures['green_alien'], CHARACTER_WIDTH, CHARACTER_HEIGHT),
    ['jump_blocks'] = generateQuad(game_Textures['jump_blocks'], TILE_SIZE, TILE_SIZE),
    ['bushes'] = generateQuad(game_Textures['bushes'], TILE_SIZE, TILE_SIZE)
}

-- TABLE OF TILE SET
game_Frames['tile_sets'] = generateTileSets(game_Frames['tiles'], NUM_TILE_SETS_PER_ROW, NUM_TILE_SETS_PER_COL,
                                            NUM_TILES_PER_ROW, NUM_TILES_PER_COL);

-- TABLE OF TOPPER
game_Frames['topper_sets'] = generateTileSets(game_Frames['toppers'], NUM_TOPPER_SETS_PER_ROW, NUM_TOPPER_SETS_PER_COL,
                                            NUM_TILES_PER_ROW, NUM_TILES_PER_COL);