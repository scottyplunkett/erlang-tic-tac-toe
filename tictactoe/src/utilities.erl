-module(utilities).
-export([move/2,mark_board/3,change_player/1,validate_move_position/2,check_for_draw/1,winner_of/1,game_won/1,x_wins/0,o_wins/0,whos_in_play/1,is_player_x_cell/1,is_empty_cell/1]).

move(invalid,Board)           
  -> {invalid,Board};
move({valid, Position},Board) 
  -> {valid,mark_board(Position, Board, whos_in_play(Board))};
move(Location, Board)        
  -> Validity_Of_Position = validate_move_position(console_io:validate_move_format(Location), Board),
                            move(Validity_Of_Position,Board).

mark_board(Move, Board, Piece) 
  -> BoardBeforeMove = lists:sublist(Board, Move - 1),
     BoardAfterMove  = lists:nthtail(Move, Board),
     BoardBeforeMove ++ [Piece] ++ BoardAfterMove.

change_player(x) -> o;
change_player(o) -> x;
change_player([Player1Type,Player2Type]) -> [Player2Type,Player1Type].

whos_in_play(Board) 
  -> Xs      = length(lists:filter(fun is_player_x_cell/1, Board)),
     Empties = length(lists:filter(fun is_empty_cell/1, Board)),
     Os      = 9 - Xs - Empties,
     case Xs - Os =< 0 of 
       true  -> x;
       false -> o
     end.

is_player_x_cell(x) -> true;
is_player_x_cell(_) -> false.

is_empty_cell(Cell) when is_integer(Cell) 
  -> true;
is_empty_cell(_)        
  -> false.

validate_move_position(Position, Board) 
  -> case     Position  =<  length(Board)
     andalso  Position  >   0  
     andalso  Position  =:= lists:nth(Position, Board) of
       true  -> {valid, Position};
       false -> invalid
     end.

check_for_draw([ThisCell | _]) 
  when is_integer(ThisCell)       -> not_yet;
check_for_draw([_ | RestOfCells]) -> check_for_draw(RestOfCells);
check_for_draw([])                -> cats_game.

x_wins() -> "Player 1, the 'x' player has won the game.".
o_wins() -> "Player 2, the 'o' player has won the game.".

winner_of(WinCombination) -> 
  case length(lists:usort(WinCombination)) of 
    1 -> lists:usort(WinCombination); 
    _ -> false 
end.

game_won([o,o,o,_,_,_,_,_,_]) -> {true, o};
game_won([_,_,_,o,o,o,_,_,_]) -> {true, o};
game_won([_,_,_,_,_,_,o,o,o]) -> {true, o};
game_won([o,_,_,o,_,_,o,_,_]) -> {true, o};
game_won([_,o,_,_,o,_,_,o,_]) -> {true, o};
game_won([_,_,o,_,_,o,_,_,o]) -> {true, o};
game_won([o,_,_,_,o,_,_,_,o]) -> {true, o};
game_won([_,_,o,_,o,_,o,_,_]) -> {true, o};
game_won([x,x,x,_,_,_,_,_,_]) -> {true, x};
game_won([_,_,_,x,x,x,_,_,_]) -> {true, x};
game_won([_,_,_,_,_,_,x,x,x]) -> {true, x};
game_won([x,_,_,x,_,_,x,_,_]) -> {true, x};
game_won([_,x,_,_,x,_,_,x,_]) -> {true, x};
game_won([_,_,x,_,_,x,_,_,x]) -> {true, x};
game_won([_,_,x,_,x,_,x,_,_]) -> {true, x};
game_won([x,_,_,_,x,_,_,_,x]) -> {true, x};
game_won(_)                   -> false.