Block = Class{}

function Block:init(posX, posY, level)
    -- init position of block
    self.x = posX;
    self.y = posY;

    -- init size of block (current: block has one size 32 width and 16 height)
    self.width = 32;
    self.height = 16;

    -- init level of block (level decide which color block has, how many collision to destroy block)
    self.level = level;
end

function Block:update(dt)

end

function Block:render()
    love.graphics.draw(gTextures['blocks'], gSprites['blocks'][2], self.x, self.y);
end

function Block:crack()
    self.level = self.level - 1;
end

