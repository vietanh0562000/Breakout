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

    -- init particle when crack block
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64);

    -- set lifetime for particle
    self.psystem:setParticleLifetime(0.5, 1);

    -- set an accerleration for particle
    self.psystem:setLinearAcceleration(-15, 0, 15, 80);

    -- speard of particles
    self.psystem:setEmissionArea('normal', 10, 10);
end

function Block:update(dt)
    self.psystem:update(dt);
end

function Block:render()
    love.graphics.draw(gTextures['blocks'], gSprites['blocks'][self.level], self.x, self.y);
end

function Block:renderPaticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8);
end


function Block:crack()
    self.level = self.level - 1;

    self.psystem:setColors(
        255,
        255,
        255,
        55 / 255,
        255,
        255,
        255,
        0
    )
    self.psystem:emit(64);
end

