HighScoreState = Class{__includes = BaseState}

function HighScoreState:init()
    self.highScores = GetHighScores();
end

function HighScoreState:update()
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('Welcome');
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFonts['large']);

    love.graphics.printf("High Scores", 0, 20, VIRTUAL_WIDTH, 'center');

    love.graphics.setFont(gFonts['medium']);

    for i = 1, 10 do
        local name = self.highScores[i].name or '----';
        local score = self.highScores[i].score or '----';

        -- printf index
        love.graphics.printf(i..'.', VIRTUAL_WIDTH / 4, 60 + i * 13, 50, 'center');

        -- printf name
        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 50, 60 + i * 13, 50, 'center');

        -- print score
        love.graphics.printf(score, VIRTUAL_WIDTH / 4 + 100, 60 + i * 13, 50, 'center');
    end
end
