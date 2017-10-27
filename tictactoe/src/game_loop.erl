-module(game_loop).
-export([ begin_play/0,take_turn/2, setup/0]).

begin_play() ->
  Board = format_board:make_new_board(),
  setup(),
  console_io:display_board(format_board:split_board_into_rows(Board)),
  take_turn(Board, x).

setup() ->
  console_io:greet_user().

take_turn(Board, Piece) ->
  Move = console_io:get_move(),
  NewBoard = utilities:move(Move, Board, Piece),
  console_io:display_board(format_board:split_board_into_rows(NewBoard)),
  utilities:complete_turn(NewBoard,Piece).
  