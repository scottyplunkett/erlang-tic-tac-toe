-module(game_loop).
-export([begin_play/0,take_turn/1,take_turn/2, complete_turn/1, complete_turn/2, setup/0,restart_turn/2,get_mode_move/1,get_mode_move/3]).
-define(INIT_BOARD, [1,2,3,4,5,6,7,8,9]).

begin_play()                     -> Board = ?INIT_BOARD,
                                    Mode = setup(),
                                    console_io:display_board(Board),
                                    take_turn(Board,maps:get(player1, Mode)).

setup()                          -> console_io:greet_user(),
                                    console_io:display("What game mode would you like to play?\n"),
                                    console_io:display("1: Human vs Human\n"),
                                    console_io:display("2: Human vs Computer\n"),
                                    console_io:display("3: Computer vs Computer\n"),
                                    {ok,Option} = console_io:prompt("Option>"),
                                    setup:set_players(list_to_integer(Option)).

get_mode_move(Board,Piece,human)    ->  utilities:move(console_io:get_move(), Board, Piece);
get_mode_move(Board,Piece,computer) ->  ai:get_best_move(Board,Piece).

get_mode_move(Board)                ->  case utilities:whos_in_play(Board) of 
                                              x ->  get_mode_move(Board,x,maps:get(player1));
                                              o ->  get_mode_move(Board,o,maps:get(player2))
                                        end.

take_turn(Board, Piece)          -> take_turn(utilities:move(get_mode_move(Board), Board, Piece)).
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