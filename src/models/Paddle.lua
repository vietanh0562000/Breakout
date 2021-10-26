Paddle = Class{};

function Paddle:init()
    -- init position of paddle
    self.x = VIRTUAL_WIDTH / 2 - 32;
    self.y = VIRTUAL_HEIGHT - 32;

    -- init size of paddle
    self.width = 32;
    self.height = 16;

    -- init skin
    self.skin = 1;

    -- init speed
    self.dx = 0;
end

function Paddle:update(dt)
    -- update velocity of paddle when press key
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED;
    elseif love.keyboard.isDown('right') then    
        self.dx = PADDLE_SPEED;
    else
        self.dx = 0;    
    end    

    -- update position of paddle
    self.x = self.x + self.dx * dt;

    -- limit paddle
    if self.x < 0 then 
        self.x = 0; 
    end
    if (self.x + self.width > VIRTUAL_WIDTH) then 
        self.x = VIRTUAL_WIDTH - self.width; 
    end

end

function Paddle:render()
    love.graphics.draw(gTextures['blocks'], gSprites['paddles'][1], 
        self.x, self.y);
end
