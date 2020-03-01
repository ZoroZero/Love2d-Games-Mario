GameLevel = Class {}

-- INIT
function GameLevel:init(entities, objects, tile_Map)
    self.entities = entities;
    self.objects = objects;
    self.tile_Map = tile_Map;
end

-- UPDATE
function GameLevel:update(dt)
    self.tile_Map:update(dt)
end

-- RENDER
function GameLevel:render()
    self.tile_Map:render()
end