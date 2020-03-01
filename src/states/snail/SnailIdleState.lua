SnailIdleState = Class{__includes = BaseState}

function SnailIdleState:init(tilemap, player, snail)
    self.tile_Map = tilemap
    self.player = player
    self.snail = snail
    self.waitTimer = 0
    self.animation = Animation {
        frames = {51},
        interval = 1
    }
    self.snail.currentAnimation = self.animation
end

function SnailIdleState:enter(params)
    self.waitPeriod = params.wait
end

function SnailIdleState:update(dt)
    if self.waitTimer < self.waitPeriod then
        self.waitTimer = self.waitTimer + dt
    else
        self.snail:changeState('moving')
    end
end