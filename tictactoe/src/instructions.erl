-module(instructions).
-export([greet/0,ask_for_move/0]).

greet() 	      -> "Welcome to TicTacToe\n".

ask_for_move() 	-> "Where would you like to place your marker?".
