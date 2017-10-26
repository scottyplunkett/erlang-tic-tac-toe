-module(utilities).
-export([move/3,mark_board/3,change_player/1]).

move(Location, Board, Piece) ->
  mark_board(console_io:check_move(Location),Board, Piece).
  
mark_board(Move, Board, Piece) ->
  BoardBeforeMove = lists:sublist(Board, Move - 1),
  BoardAfterMove = lists:nthtail(Move, Board),
  BoardBeforeMove ++ [Piece] ++ BoardAfterMove.
  
change_player(x) -> o;
change_player(o) -> x.