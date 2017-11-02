-module(instructions_tests).
-include_lib("eunit/include/eunit.hrl").

greet_test() 	    -> [{ "passes a greeting message to a client",
			   ?assertEqual("Welcome to TicTacToe\n", instructions:greet())}].

ask_for_move_test() -> [{ "passes a message asking for a move",
			   ?assertEqual("Where would you like to place your marker?",instructions:ask_for_move())}].
