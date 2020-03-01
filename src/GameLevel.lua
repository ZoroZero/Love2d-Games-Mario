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

    for k, object in pairs(self.objects) do
        object:update(dt);
    end
end

-- RENDER
function GameLevel:render(camera_Scroll_X)

    self.tile_Map:render(camera_Scroll_X)
    for k, object in pairs(self.objects) do
        object:render();
    end
end