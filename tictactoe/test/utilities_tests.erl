-module(utilities_tests).
-include_lib("eunit/include/eunit.hrl").

move_test() ->
  InvalidMove = utilities:validate_move_position(console_io:validate_move_format({ok,["1"]}), [x,2,3,4,5,6,7,8,9]),
  ValidMove = utilities:validate_move_position(console_io:validate_move_format({ok,["1"]}), [1,2,3,4,5,6,7,8,9]),
  [{  "checks validity and marks board when move is valid, otherwise returns invalid info tuple",
      ?assertEqual({invalid,[1,2,3,4,5,6,7,8,x],o}, 
                   utilities:move(InvalidMove,[1,2,3,4,5,6,7,8,x],o)),
      ?assertEqual([x,2,3,4,5,6,7,8,9], 
                   utilities:move(ValidMove,[1,2,3,4,5,6,7,8,9],x))}].

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

whos_in_play_test() -> 
  [{  "using only the board; determines which player is currently at play (their turn)",
    ?assertEqual(x,utilities:whos_in_play([1,2,3,4,5,6,7,8,9])),
    ?assertEqual(o,utilities:whos_in_play([x,2,3,4,5,6,7,8,9]))}].

cell_owned_by_x_test() ->
  [{  "returns boolean based on wheather cell passed as argument holds x or not",
      ?assertEqual(true,utilities:cell_owned_by_x(x),
      ?assertNotEqual(true,utilities:cell_owned_by_x(o)))}].

cell_vacant_test() ->
  [{  "returns boolean based on wheather cell passed as argument is empty",
      ?assertEqual(true,utilities:cell_vacant(1),
      ?assertNotEqual(true,utilities:cell_vacant(o)))}].

validate_move_position_test() ->
  [{  "validates a move",
      ?assertEqual( invalid,
        utilities:validate_move_position(1,[o,2,3,4,5,6,7,8,9])),
      ?assertEqual( invalid,
        utilities:validate_move_position(10,[1,2,3,4,5,6,7,8,9])),
      ?assertEqual( {valid, 1},
        utilities:validate_move_position(1,[1,2,3,4,5,6,7,8,9])),
      ?assertEqual( invalid,
        utilities:validate_move_position(0,[1,2,3,4,5,6,7,8,9]))}].

board_full_test() -> 
  [{  "checks if the game is over",
      ?assertEqual( not_yet,
        utilities:board_full([1,2,3,4,5,6,7,8,9])),
      ?assertEqual( not_yet,
        utilities:board_full([x,2,3,4,5,6,7,8,9])),
      ?assertEqual( not_yet,
        utilities:board_full([x,o,3,4,5,6,7,8,9])),
      ?assertEqual( not_yet,
        utilities:board_full([x,o,x,o,5,x,o,x,o])),
      ?assertEqual( cats_game,
        utilities:board_full([x,o,x,o,x,x,o,x,o]))}].

x_wins_test() ->
  [{  "returns win message for x",
    ?assertEqual("Player 1, the 'x' player has won the game.\n", utilities:x_wins())}].

o_wins_test() ->
  [{  "returns win message for o",
    ?assertEqual("Player 2, the 'o' player has won the game.\n", utilities:o_wins())}].

game_won_test() -> 
  [{  "checks if the game is won",
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([x,x,x,
                            4,5,6,
                            7,8,9])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([o,o,o,
                            4,5,6,
                            7,8,9])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([1,2,3,
                            o,o,o,
                            7,8,9])),
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([1,2,3,
                            x,x,x,
                            7,8,9])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([1,2,3,
                            4,5,6,
                            o,o,o])),
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([1,2,3,
                            4,5,6,
                            x,x,x])),
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([x,2,3,
                            x,5,6,
                            x,8,9])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([o,2,3,
                            o,5,6,
                            o,8,9])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([1,o,3,
                            4,o,6,
                            7,o,9])),
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([1,x,3,
                            4,x,6,
                            7,x,9])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([1,2,o,
                            4,5,o,
                            7,6,o])),
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([1,2,x,
                            4,5,x,
                            6,7,x])),
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([1,2,x,
                            4,x,6,
                            x,8,9])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([1,2,o,
                            4,o,6,
                            o,7,9])),
      ?assertEqual( {true, utilities:x_wins()},
        utilities:game_won([x,2,3,
                            4,x,6,
                            7,8,x])),
      ?assertEqual( {true, utilities:o_wins()},
        utilities:game_won([o,2,3,
                            4,o,6,
                            7,8,o]))
      }].
