-module(ai).
-export([possible_boards/2,score/1,score/2,minimax_value/2,minimax_value/3,get_best_move/2,count_moves/1,minimize/1,maximize/1,opponent_strategy/1]).

minimax_value(Board, Player) -> 
 minimax_value(Board,Player,score(Board)).
minimax_value(Board, Player, not_yet_scoreable) -> 
 PossibleBoards = possible_boards(Board, Player),
 MinimaxValues  = lists:map(opponent_strategy(Player), PossibleBoards),
 case Player of
    x ->
        lists:max(lists:flatten(MinimaxValues));
    o ->
        lists:min(lists:flatten(MinimaxValues))
 end;
minimax_value(Board,_,_) -> 
 score(Board).



score({true, x},Board) -> 
  10 - count_moves(Board);     
score({true, o},Board) -> 
 -10 + count_moves(Board);     
score(cats_game,_) -> 
   0;
score(not_yet,_) -> 
 not_yet_scoreable;
score(false,Board) -> 
 score(utilities:check_for_draw(Board),Board).
score(Board) -> 
 score(utilities:game_won(Board),Board).

maximize(Board) ->
 minimax_value(Board, x).
minimize(Board) -> 
 minimax_value(Board, o).

opponent_strategy(x) -> 
 fun minimize/1;
opponent_strategy(o) -> 
 fun maximize/1.  

count_moves(Board)
 -> length(Board) - length(lists:filter(fun utilities:is_empty_cell/1, Board)).

possible_boards(Board, Piece) -> 
 possible_boards(Board, Board, [], Piece).
possible_boards(_, [], PossibleBoards, _) -> 
 PossibleBoards;
possible_boards(Board, [CellToCheck | RestOfBoard], PossibleBoards, Piece) when is_integer(CellToCheck) -> 
 MoreBoards  = [ utilities:mark_board(9 - length(RestOfBoard), Board, Piece) ] ++  PossibleBoards, 
 possible_boards(Board, RestOfBoard, MoreBoards, Piece);
possible_boards(Board, [_CellToCheck | RestOfBoard], PossibleBoards, Piece) -> 
 possible_boards(Board, RestOfBoard, PossibleBoards, Piece).

get_best_move(Board, Player) ->  
 PossibleBoards = possible_boards(Board, Player),
 MinimaxValues  = lists:map(opponent_strategy(Player), PossibleBoards),
 ValuesWithBoards = lists:zip(MinimaxValues, PossibleBoards),
 RankBoardsByValue = lists:keysort(1, ValuesWithBoards),
 [ {_, BestBoard} | _T ] = 
  case Player of 
   x ->  lists:reverse(RankBoardsByValue);
   o ->  RankBoardsByValue 
  end,
  [ BestMove ] = Board -- BestBoard,
    BestMove.