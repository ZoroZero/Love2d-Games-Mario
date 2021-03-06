push = require 'lib/push';

Class = require 'lib/class';

Timer = require 'lib/knife.timer'

require 'src/constants'
-- State 
require 'src/StateMachine'

-- Ultility functions
require 'src/Ultil'

-- Animation file
require 'src/Animation'

-- Level generation file
require 'src/LevelMaker'
require 'src/GameLevel'
-- Game component
require 'src/Tile'
require 'src/TileMap'
require 'src/Entity'
require 'src/Player'
require 'src/GameObject'
require 'src/Snail'
require 'src/FlagPoll'

-- Game states
require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'
require 'src/states/game/GameOverState'
require 'src/states/game/StandByState'

require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerFallingState'
require 'src/states/player/PlayerWalkingState'
require 'src/states/player/PlayerJumpingState'

require 'src/states/snail/SnailIdleState'
require 'src/states/snail/SnailMovingState'
require 'src/states/snail/SnailChasingState'


