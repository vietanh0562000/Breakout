-- This state appear when you get high score and you will choose your name to write it to high score board
EnterNameState = Class{__includes = BaseState}

function EnterNameState:init()
    self.name = {
        [1] = 65,
        [2] = 65,
        [3] = 65
    };
    self.score = 0;
    self.selectingChar = 1;
end

function EnterNameState:enter(params)
    self.score = params.score;
    self.highscores = params.highScores;
end

function EnterNameState:update()
    if (love.keyboard.wasPressed('return')) then
        self:updateHighScore();
        gStateMachine:change('HighScores');
    end

    -- select character 
    if (love.keyboard.wasPressed('left') and self.selectingChar > 1) then
        self.selectingChar = self.selectingChar - 1;
    elseif (love.keyboard.wasPressed('right') and self.selectingChar < #self.name) then    
        self.selectingChar = self.selectingChar + 1;
    end

    -- change character is select
    if (love.keyboard.wasPressed('up')) then
        -- if current character = Z character turn to A
        if (self.name[self.selectingChar] == 90) then
            self.name[self.selectingChar] = 65;
        else
            self.name[self.selectingChar] = (self.name[self.selectingChar] + 1);
        end    
    elseif (love.keyboard.wasPressed('down')) then    
        -- if current character = A character turn to Z
        if (self.name[self.selectingChar] == 65) then
            self.name[self.selectingChar] = 90;
        else
            self.name[self.selectingChar] = (self.name[self.selectingChar] - 1);
        end
    end
end

function EnterNameState:updateHighScore()
    -- get name player chosen
    local name = '';
    for i = 1, #self.name do
        name = name..string.char(self.name[i]);
    end

    -- insert new score to list
    for i = 9, 0, -1 do
        -- special case when score is the best
        if i == 0 then
            self.highscores[1].name = name;
            self.highscores[1].score = self.score;
            break;
        end

        -- run bottom to up and update score
        if (self.highscores[i].score < self.score) then
            -- push smaller to bottom
            self.highscores[i+1].name = self.highscores[i].name;
            self.highscores[i+1].score = self.highscores[i].score;
        else
            -- insert new score
            self.highscores[i+1].name = name;
            self.highscores[i+1].score = self.score;
        end
    end

    -- rewrite highscores
    WriteHighScores(self.highscores);
end

function EnterNameState:render()
    love.graphics.setFont(gFonts['large']);

    local posX = VIRTUAL_WIDTH / 2 - #self.name / 2 * 28;
    for i = 1, #self.name do
        -- if char is selected make it blue
        if (self.selectingChar == i) then
            love.graphics.setColor(103/255, 1, 1, 1);
        end

        love.graphics.printf(string.char(self.name[i]), posX, VIRTUAL_HEIGHT / 2 - 50, 20, 'center');  

        -- set position for next char
        posX = posX + 22;  

        -- reset color for after char
        love.graphics.setColor(1, 1, 1, 1);
    end
    
end
