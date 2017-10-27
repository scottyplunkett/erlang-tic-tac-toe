-module(utilities).
-export([move/3,
         mark_board/3,
         change_player/1,
         validate_move_position/2,
         restart_turn/2,
         board_full/1,
         game_won/1]).

move(Location, Board, Piece) ->
  Position = validate_move_position(console_io:validate_move_format(Location), Board),
  case Position of
    invalid ->
      restart_turn(Board,Piece);
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
  
restart_turn(Board,Piece) ->
  console_io:display("Invalid Move, try again...\n"),
  game_loop:take_turn(Board, Piece).

board_full([ThisCell | _]) when is_integer(ThisCell) ->
  false;
board_full([_ | RestOfCells]) ->
  board_full(RestOfCells);
board_full([]) ->
  cats_game.

game_won([o,o,o,_,_,_,_,_,_]) -> true;
game_won([x,x,x,_,_,_,_,_,_]) -> true;
game_won([_,_,_,o,o,o,_,_,_]) -> true;
game_won([_,_,_,x,x,x,_,_,_]) -> true;
game_won([_,_,_,_,_,_,o,o,o]) -> true;
game_won([_,_,_,_,_,_,x,x,x]) -> true;
game_won([o,_,_,o,_,_,o,_,_]) -> true;
game_won([x,_,_,x,_,_,x,_,_]) -> true;
game_won([_,o,_,_,o,_,_,o,_]) -> true;
game_won([_,x,_,_,x,_,_,x,_]) -> true;
game_won([_,_,o,_,_,o,_,_,o]) -> true;
game_won([_,_,x,_,_,x,_,_,x]) -> true;
game_won([_,_,x,_,x,_,x,_,_]) -> true;
game_won([_,_,o,_,o,_,o,_,_]) -> true;
game_won([x,_,_,_,x,_,_,_,x]) -> true;
game_won([o,_,_,_,o,_,_,_,o]) -> true;
game_won(_) -> false.


