Player = Class {__includes = Entity}

-- INIT
function Player:init(params)
    Entity.init(self, params)
end

-- UPDATE
function Player:update(dt)
    Entity.update(self,dt);
end

-- RENDER
function Player:render()
    Entity.render(self)
end
