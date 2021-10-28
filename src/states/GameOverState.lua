GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    self.score = 0;
    self.highScores = GetHighScores();
end

function GameOverState:enter(params)
    self.score = params.score;
    if (self.highScores[10].score < self.score) then
        gStateMachine:change('EnterName',{
            score = self.score,
            highScores = self.highScores
        });
    end;
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('return') then
            gStateMachine:change('Play');
    end
end

function GameOverState:render()
    -- set font for greetings and score
    love.graphics.setFont(gFonts['medium']);

    -- printf greetings and score
    love.graphics.printf("Oops. Nice try",  0, 10, VIRTUAL_WIDTH, 'center');
    love.graphics.printf("Your score: " .. self.score, 0, 80, VIRTUAL_WIDTH, 'center');

    -- set font for suggest
    love.graphics.setFont(gFonts['small']);

    -- printf suggest
    love.graphics.printf("Press Enter to play again!", 0, 150, VIRTUAL_WIDTH, 'center');
end
