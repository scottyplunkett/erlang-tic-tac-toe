-module(ai).
-export([get_boards_possible@next_round/2,score/1,score/2,minimax_value/2,minimax_value/3,get_best_move/2,count_moves/1,minimize/1,maximize/1,strategy/1]).

minimax_value(Board, Player)                    -> minimax_value(Board,Player,score(Board)).
minimax_value(Board, x, not_yet_scoreable)      -> lists:max(lists:flatten(lists:map(strategy(o), get_boards_possible@next_round(Board, x))));
minimax_value(Board, o, not_yet_scoreable)      -> lists:min(lists:flatten(lists:map(strategy(x), get_boards_possible@next_round(Board, o))));
minimax_value(Board,_,_)                        -> score(Board).

score({true, x},Board)                          ->  10 - count_moves(Board);     
score({true, o},Board)                          -> -10 + count_moves(Board);     
score(cats_game,_)                              ->   0;
score(not_yet,_)                                -> not_yet_scoreable;
score(false,Board)                              -> score(utilities:check_for_draw(Board),Board).
score(Board)                                    -> score(utilities:game_won(Board),Board).

maximize(Board)                                 ->  minimax_value(Board, x).
minimize(Board)                                 ->  minimax_value(Board, o).

strategy(x)                                     -> fun minimize/1;
strategy(o)                                     -> fun maximize/1.

count_moves(Board)                              -> length(Board) - length(lists:filter(fun utilities:is_empty_cell/1, Board)).

get_boards_possible@next_round(Board, Piece)              -> get_boards_possible@next_round(Board, Board, [], Piece).
get_boards_possible@next_round(_, [], PossibleBoards, _)  -> PossibleBoards;
get_boards_possible@next_round(Board, [CellToCheck | RestOfBoard], PossibleBoards, Piece) when is_integer(CellToCheck)  
  ->  MoreBoards  = [ utilities:mark_board(9 - length(RestOfBoard), Board, Piece) ] ++  PossibleBoards, 
      get_boards_possible@next_round(Board, RestOfBoard, MoreBoards, Piece);
get_boards_possible@next_round(Board, [_CellToCheck | RestOfBoard], PossibleBoards, Piece) 
  ->  get_boards_possible@next_round(Board, RestOfBoard, PossibleBoards, Piece).

get_best_move(Board, Player)               
  ->  NextStates      = get_boards_possible@next_round(Board, Player),
      MinimaxValues   = lists:map(strategy(Player), NextStates),
      StatesAndValues = lists:zip(MinimaxValues, NextStates),
      [ {_, BestBoard} | _T ]  
                      = case Player of 
                              x ->  lists:reverse(lists:keysort(1, StatesAndValues));
                              o ->  lists:keysort(1, StatesAndValues) end,
      [     BestMove        ]      
                      = Board -- BestBoard,
            BestMove.