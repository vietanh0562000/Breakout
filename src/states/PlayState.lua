require 'src/models/Paddle';
require 'src/models/Block';
require 'src/models/Ball';
require 'src/LevelMaker';

PlayState = Class{__includes = BaseState}

-- Call before the first frame of play state
function PlayState:init()
    self.paddle = Paddle();
    self.blocks = LevelMaker:spawnBlocks(1);
    self.ball = Ball(self.paddle.x + self.paddle.width / 2 - 4, self.paddle.y - 5);
    self.score = 0;
    self.hp = 3;
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
    if self.ball:collide(self.paddle) then
        self.ball.dy = -self.ball.dy * 1.1;
    end


    -- update all block every frame
    for k, block in pairs(self.blocks) do
        block:update(dt);

        -- if ball collide with block it change direction. 
        -- And block break 1 level. Block level will be destroy
        -- Each time collide block player get one point
        if self.ball:collide(block) then
            -- change direction the ball
            self.ball.dy = -self.ball.dy;

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