-module(game_loop).
-export([begin_play/0,take_turn/1,take_turn/2, complete_turn/1, complete_turn/2, setup/0,restart_turn/2]).
-define(INIT_BOARD, [1,2,3,4,5,6,7,8,9]).

begin_play()                     -> Board = ?INIT_BOARD,
                                    setup(),
                                    console_io:display_board(Board),
                                    take_turn(Board, x).

setup()                          -> console_io:greet_user().

take_turn(Board, Piece)          -> take_turn(utilities:move(console_io:get_move(), Board, Piece)).
take_turn({invalid,Board,Piece}) -> game_loop:restart_turn(Board,Piece);
take_turn(NewBoard)              -> console_io:display_board(NewBoard),
                                    complete_turn(NewBoard).
  
complete_turn(Board)             -> complete_turn(Board, utilities:game_won(Board)).
complete_turn(_, {true, Winner}) -> console_io:display(Winner);
complete_turn(Board, false)      -> complete_turn(Board, utilities:check_for_draw(Board));
complete_turn(_, cats_game)      -> console_io:display("Draw!\n");
complete_turn(Board, not_yet)    -> take_turn(Board, utilities:whos_in_play(Board)).

restart_turn(Board,Piece)        -> console_io:display("Invalid Move, try again...\n"), 
                                    take_turn(Board, Piece).