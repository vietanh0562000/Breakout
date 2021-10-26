StateMachine = Class{}

function StateMachine:init(states)
   self.empty = {
       update = function () end,
       enter = function() end,
       render = function() end,
       exit =  function() end
   }

   self.states = states or {};
   self.currentState = self.empty;
end

function StateMachine:change(name, params)
    assert(self.states[name]);
    self.currentState:exit();
    self.currentState = self.states[name]();
    self.currentState:enter(params);
end

function StateMachine:update(dt)
    self.currentState:update(dt);
end

function StateMachine:render()
    self.currentState:render();
end