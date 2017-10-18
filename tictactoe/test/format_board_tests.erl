-module(format_board_tests).
-include_lib("eunit/include/eunit.hrl").

get_board_length_test() ->
  [{ "gets the length of a board",
     ?assertEqual(9,format_board:get_board_length([1,2,3,4,5,6,7,8,9])),
     ?assertNotEqual(8,format_board:get_board_length([1,2,3,4,5,6,7,8,9]))}].

get_board_row_length_test() ->
	[{ "gets the length of a board row",
		?assertEqual(3,format_board:get_board_row_length(9)),
		?assertNotEqual(4,format_board:get_board_row_length(9))}].

split_board_into_rows_test() ->
	[{ "make board into a list of row sublists",
		?assertEqual([[1,2,3],[4,5,6],[7,8,9]],format_board:split_board_into_rows([1,2,3,4,5,6,7,8,9]))}].
