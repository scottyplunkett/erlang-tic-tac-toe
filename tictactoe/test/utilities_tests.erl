-module(utilities_tests).
-include_lib("eunit/include/eunit.hrl").

mark_board_test() ->
  [{  "returns board with marker placed",
      ?assertEqual(
        ["X",2,3,4,5,6,7,8,9],
        utilities:mark_board(1, [1,2,3,4,5,6,7,8,9], "X")),
      ?assertEqual(
        ["O",2,3,4,5,6,7,8,9],
        utilities:mark_board(1, [1,2,3,4,5,6,7,8,9], "O"))}].

change_player_test() ->
  [{  "changes player marker",
      ?assertEqual(o,utilities:change_player(x)),
      ?assertEqual(x,utilities:change_player(o))}].

validate_move_test() ->
  [{  "validates a move",
      ?assertEqual( invalid,
        utilities:validate_move_position(1,[o,2,3,4,5,6,7,8,9])),
      ?assertEqual( invalid,
        utilities:validate_move_position(10,[1,2,3,4,5,6,7,8,9])),
      ?assertEqual( 1,
        utilities:validate_move_position(1,[1,2,3,4,5,6,7,8,9])),
      ?assertEqual( invalid,
        utilities:validate_move_position(0,[1,2,3,4,5,6,7,8,9]))}].

board_full_test() -> 
  [{  "checks if the game is over",
      ?assertEqual( false,
        utilities:board_full([1,2,3,4,5,6,7,8,9])),
      ?assertEqual( false,
        utilities:board_full([x,2,3,4,5,6,7,8,9])),
      ?assertEqual( false,
        utilities:board_full([x,o,3,4,5,6,7,8,9])),
      ?assertEqual( false,
        utilities:board_full([x,o,x,o,5,x,o,x,o])),
      ?assertEqual( true,
        utilities:board_full([x,o,x,o,x,x,o,x,o]))}].


