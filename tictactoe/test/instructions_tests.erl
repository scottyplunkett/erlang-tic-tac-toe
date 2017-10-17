-module(instructions_tests).
-include_lib("eunit/include/eunit.hrl").
-import(instructions, [greet/0]).

greet_test() -> ?_assert(greet() =:= "Welcome to TicTacToe\n").