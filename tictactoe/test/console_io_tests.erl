-module(console_io_tests).
-include_lib("eunit/include/eunit.hrl").
-import(console_io, [display/1,greet_user/0]).
-import(instructions, [greet/0]).

display_board_test() -> 
  [{  "displays a board with a row printed on each line",
      ?assertEqual(console_io:display_board([1]),board)}].

display_test() -> [ ?_assert(display("Some Message") =:= io:fwrite("Some Message")),
                    ?_assert(display(greet()) =:= io:fwrite("Welcome to TicTacToe\n"))].

greet_test() -> ?_assert(greet_user() =:= display(greet())).