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
        if object.x >= camera_Scroll_X - 20 and object.x - camera_Scroll_X <= VIRTUAL_WIDTH + 20 then
            object:render();
        end
    end
end