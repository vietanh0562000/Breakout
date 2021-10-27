Ball = Class{};

function Ball:init(posX, posY)
    -- init position of ball
    self.x = posX;
    self.y = posY;

    -- init radius
    self.radius = 2;

    -- init velocity
    self.dx = 0;
    self.dy = 0;

    -- state (ball has 2 state: init(0 lay on paddle), fly(1 fly))
    self.state = 0;
end

-- reset ball to (waiting serve state) 
function Ball:reset(paddle)
    self.state = 0;
    self.x = paddle.x + paddle.width / 2 - 4;
    self.y = paddle.y - 5;
    self.dx = 0;
    self.dy = 0;
end

-- update ball every frame
function Ball:update(dt)
    -- if lay on paddle move like paddle
    if self.state == 0 then
        if love.keyboard.isDown('left') then
            self.dx = -PADDLE_SPEED;
        elseif love.keyboard.isDown('right') then    
            self.dx = PADDLE_SPEED;
        else
            self.dx = 0;    
        end    
    end

    self.x = self.x + self.dx * dt;
    self.y = self.y + self.dy * dt;

    -- if ball collide with 2 cross wall (left and right) --> ball change direction x
    if self.x + self.radius > VIRTUAL_WIDTH or
       self.x - self.radius < 0 then
           self.dx = -self.dx;
       end

    -- if ball collide with wall (top) --> ball change direction y
    if self.y - self.radius < 0 then
        self.dy = -self.dy;
    end   
end

function Ball:collide(other)
    if (self.x  > other.x + other.width) or
        (self.x + self.radius * 2 < other.x) or
        (self.y > other.y + other.height) or
        (self.y + self.radius * 2 < other.y) then
            return false;
    end
    
    return true;
end

function Ball:render()
    love.graphics.draw(gTextures['blocks'], gSprites['balls'][1], self.x, self.y);
end

