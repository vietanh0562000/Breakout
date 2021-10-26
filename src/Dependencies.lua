-- library draw game at a virtual resolution
push = require('lib/push');

-- Simple library help us coding in oop
Class = require('lib/class');

-- All constants of game
require 'src/constants';

-- All global function in game
require 'src/Util';

-- states
require 'src/StateMachine'
require 'src/states/BaseState';
require 'src/states/WelcomeState';
require 'src/states/PlayState';
