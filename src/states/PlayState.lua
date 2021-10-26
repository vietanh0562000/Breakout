require 'src/models/Paddle';
require 'src/models/Block';
require 'src/models/Ball';

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle();
    self.blocks = {};
    table.insert( self.blocks, Block(0, 0, 1));
    table.insert( self.blocks, Block(32, 0, 1));
    table.insert( self.blocks, Block(64, 0, 1));
    table.insert( self.blocks, Block(96, 0, 1));

    self.ball = Ball(self.paddle.x + self.paddle.width / 2 - 4, self.paddle.y - 5);
end

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

        -- if ball collide with block it change direction. And block break 1 level. Block level will be destroy
        if self.ball:collide(block) then
            self.ball.dy = -self.ball.dy;
            block:crack();
        end

        if block.level == 0 then
            table.remove( self.blocks, k);
        end
    end

    -- update ball every frame
    self.ball:update(dt);

end

function PlayState:serveBall()
    self.ball.dx = math.random(-80, 80);
    self.ball.dy = -80;
    self.ball.state = 1;
end

function PlayState:render(dt)
    self.paddle:render();

    for k, block in pairs(self.blocks) do
        block:render();
    end

    self.ball:render();
end