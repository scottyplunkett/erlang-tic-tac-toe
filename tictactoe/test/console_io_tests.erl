-module(console_io_tests).
-include_lib("eunit/include/eunit.hrl").
-import(console_io, [display/1,greet_user/0]).
-import(instructions, [greet/0]).

display_test() -> [	?_assert(display("Some Message") =:= io:fwrite("Some Message")),
										?_assert(display(greet()) =:= io:fwrite("Welcome to TicTacToe\n"))].


greet_test() -> ?_assert(greet_user() =:= display(greet())).