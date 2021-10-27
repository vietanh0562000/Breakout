require 'src/models/Paddle';
require 'src/models/Block';
require 'src/models/Ball';
require 'src/LevelMaker';

PlayState = Class{__includes = BaseState}

-- Call before the first frame of play state
function PlayState:init()
    self.level = 1;
    self.score = 0;
    self.hp = 3;

    self.paddle = Paddle();
    self.blocks = LevelMaker:spawnBlocks(self.level);
    self.ball = Ball(self.paddle.x + self.paddle.width / 2 - 4, self.paddle.y - 5);
end

-- Call every frame of play state
function PlayState:update(dt)
    -- When ball not fly, player can serve ball by press space
    if love.keyboard.wasPressed('space') and self.ball.state == 0 then
        self:serveBall();
    end

    -- update paddle every frame
    self.paddle:update(dt);
    -- if ball collide with block it change direction and increase speed
    if (self.ball.state == 1) and (self.ball:collide(self.paddle)) then
        self.ball.y = self.paddle.y - 8;
        self.ball.dy = -self.ball.dy;

        -- if collide when move paddle
        -- collide left paddle when it move left
        if (self.ball.x < self.paddle.x + self.paddle.width / 2) and (self.paddle.dx < 0) then
            self.ball.dx = -50 + - (8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x));  
            
        -- collide right paddle when move right    
        elseif (self.ball.x > self.paddle.x + self.paddle.width / 2) and (self.paddle.dx > 0) then
            self.ball.dx = 50 + (8 * (self.ball.x - self.paddle.x + self.paddle.width / 2));
        end

        gSounds['paddle_hit']:play();
    end


    -- update all block every frame
    for k, block in pairs(self.blocks) do
        block:update(dt);

        -- if ball collide with block it change direction. 
        -- And block break 1 level. Block level will be destroy
        -- Each time collide block player get one point
        if self.ball:collide(block) then
            -- change direction the ball
            
            -- collide at right
            if (self.ball.x + 2 > block.x + block.width) then
                self.ball.dx = -self.ball.dx;

            -- collide at left    
            elseif (self.ball.x + self.ball.radius < block.x) then    
                self.ball.dx = -self.ball.dx;

            -- collide at bottom    
            elseif (self.ball.y + 2 > block.y + block.height) then    
                self.ball.dy = -self.ball.dy;

            -- collide at top    
            elseif (self.ball.y + self.ball.radius < block.y) then
                self.ball.dy = -self.ball.dy;    
            end


            -- break block
            block:crack();
            gSounds['brick-hit-2']:play();

            -- increase point
            self:getPoint();
        end

        -- level turn 0 <-> block destroy
        if block.level == 0 then
            table.remove( self.blocks, k);
        end
    end
    
    -- if all block is clear then up level. reset ball waiting to serve
    if (#self.blocks == 0) then
        self.level = self.level + 1;
        self.blocks = LevelMaker:spawnBlocks(self.level);
        self.ball:reset(self.paddle);
    end

    -- update ball every frame
    self.ball:update(dt);

    -- check the ball fall out
    if (self.ball.y > VIRTUAL_HEIGHT) then

        self.hp = self.hp - 1;

        -- if hp turn 0 game over
        if (self.hp == 0) then
            gStateMachine:change('GameOver', {score = self.score});
        else
            -- hp > 0 reset ball to paddle waiting serve
           self.ball:reset(self.paddle);
        end
    
    end
end

-- assign velocity to the ball. make it fly
function PlayState:serveBall()
    self.ball.dx = math.random(-80, 80);
    self.ball.dy = -80;
    self.ball.state = 1;
end

-- Increase one point
function PlayState:getPoint()
    self.score = self.score + 1;
end

-- Draw all things of play state
function PlayState:render(dt)
    -- draw paddle
    self.paddle:render();

    -- draw all blocks
    for k, block in pairs(self.blocks) do
        block:render();
    end

    -- draw the ball
    self.ball:render();

    -- draw score
    love.graphics.setFont(gFonts['small']);
    love.graphics.printf('Score: '..self.score, VIRTUAL_WIDTH - 50, 0, 50, 'center');

    -- draw hp
    for i = 1, self.hp do
        love.graphics.draw(gTextures['hearts'], gSprites['hearts'][1], (i - 1) * 8, 0);
    end
end