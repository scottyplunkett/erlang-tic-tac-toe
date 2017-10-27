-module(utilities).
-export([move/3,
         mark_board/3,
         change_player/1,
         validate_move_position/2,
         restart_move/2]).

move(Location, Board, Piece) ->
  Position = validate_move_position(console_io:validate_move_format(Location), Board),
  case Position of
    invalid ->
      restart_move(Board,Piece);
    _ ->
      mark_board(Position, Board, Piece)
  end.
  
mark_board(Move, Board, Piece) ->
  BoardBeforeMove = lists:sublist(Board, Move - 1),
  BoardAfterMove = lists:nthtail(Move, Board),
  BoardBeforeMove ++ [Piece] ++ BoardAfterMove.
  
change_player(x) -> o;
change_player(o) -> x.

validate_move_position(Position, Board) ->
  case    Position =< length(Board)
  andalso Position > 0
  andalso lists:nth(Position, Board) =:= Position of
    true -> 
      Position;
    false -> 
      invalid
  end.
  
restart_move(Board,Piece) ->
  console_io:display("Invalid Move, try again...\n"),
    game_loop:take_turn(Board, Piece).