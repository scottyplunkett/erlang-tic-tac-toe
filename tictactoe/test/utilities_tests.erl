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
      ?assertEqual(
        utilities:validate_move_position(1,[o,2,3,4,5,6,7,8,9]),invalid),
      ?assertEqual( 
        utilities:validate_move_position(10,[1,2,3,4,5,6,7,8,9]),invalid),
      ?assertEqual( 
        utilities:validate_move_position(1,[1,2,3,4,5,6,7,8,9]),1),
      ?assertEqual( 
        utilities:validate_move_position(0,[1,2,3,4,5,6,7,8,9]),invalid)}].