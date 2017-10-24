-module(store).
-export([store_move/3]).

store_move(Location, Piece, Board) ->
  BoardBeforeMove = lists:sublist(Board, Location - 1),
  BoardAfterMove = lists:nthtail(Location, Board),
  BoardBeforeMove ++ [Piece] ++ BoardAfterMove.

