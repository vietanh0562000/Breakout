WelcomeState = Class{__includes = BaseState}

function WelcomeState:enter()
    self.selectedOption = 0;    
end

function WelcomeState:update()
    -- player change option to choose
    if love.keyboard.wasPressed('down') and self.selectedOption < 1 then
        self.selectedOption = self.selectedOption + 1;
        gSounds['paddle_hit']:play();
    elseif love.keyboard.wasPressed('up') and self.selectedOption > 0 then    
        self.selectedOption = self.selectedOption - 1;
        gSounds['paddle_hit']:play();
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit();
    end

end

function WelcomeState:render()
    -- draw game name
    love.graphics.setFont(gFonts['large']);
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 2 - 70, VIRTUAL_WIDTH, 'center');

    -- draw menu
    love.graphics.setFont(gFonts['medium']);

        -- start option
    if self.selectedOption == 0 then
        love.graphics.setColor(103/255, 1, 1, 1);
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center');

    -- reset color
    love.graphics.setColor(1, 1, 1, 1);

        -- high score option
    if self.selectedOption == 1 then
        love.graphics.setColor(103/255, 1, 1, 1);
    end        
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 20, VIRTUAL_WIDTH, 'center');

     -- reset color
     love.graphics.setColor(1, 1, 1, 1);

end
