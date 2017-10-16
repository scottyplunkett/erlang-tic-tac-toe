-module(instructions_tests).
-include_lib("eunit/include/eunit.hrl").

greet_test() -> 
	[{ "passes a greeting message to a client",
		 ?assertEqual("Welcome to TicTacToe", instructions:greet())}].

ask_for_move_test() ->
  [{ "passes a message asking for a move",
     ?assertEqual("Where would you like to place your marker?",instructions:ask_for_move())}].

ask_for_marker_test() ->
  [{ "passes a message asking what marker the player would like to use",
     ?assertEqual("What would you like to use as your marker?",instructions:ask_for_marker())}].