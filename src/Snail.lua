Snail = Class {__includes = Entity}

-- INIT
function Snail:init(params)
    Entity.init(self, params)
end

-- RENDER
function Snail:render()
    Entity.render(self)
end