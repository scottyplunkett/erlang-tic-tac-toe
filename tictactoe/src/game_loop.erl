-module(game_loop).
-export([set_mode/1,begin_play/0,take_turn/2, complete_turn/2, complete_turn/3, display_mode_choices/0,restart_turn/0,human_move/0,computer_move/1]).
-define(INIT_BOARD, [1,2,3,4,5,6,7,8,9]).

begin_play() -> 
 io:format(os:cmd(clear)),
 console_io:greet_user(),
 display_mode_choices(),
 {ok,[Option]} = console_io:prompt("Enter an option>"),
 MoveOrder = set_mode(Option),
 io:format("Mode set to ~s.~n",[Option]),
 Board = ?INIT_BOARD,
 console_io:display_board(Board),
 take_turn(Board,MoveOrder).

human_move() ->    
 {ok,[Input]} = console_io:get_move(),list_to_integer(Input).
computer_move(Board) -> 
 CurrentAI = 
  case utilities:whos_in_play(Board) of 
   x -> "Ticky, the Tictactoe AI:"; 
   o -> "Earl, the Erlang AI:" 
  end,
 Choice = ai:get_best_move(Board, utilities:whos_in_play(Board)),
 console_io:display(CurrentAI),
 console_io:display("\n\"I choose to mark the "),
 io:write(Choice),
 console_io:display(" cell...\"\n"),
 timer:sleep(1000),
 Choice.

display_mode_choices() -> 
 console_io:display("What game mode would you like to play?\n"),
 console_io:display("1: Human vs Human\n"),
 console_io:display("2: Human vs Computer\n"),
 console_io:display("3: Computer vs Computer\n").

take_turn(Board,MoveOrder) ->
 Move = 
 fun(Type) -> 
  case Type of 
   human    -> utilities:move(human_move(), Board);
   computer ->  utilities:move(computer_move(Board), Board)
  end 
 end,
[Player1Move,Player2Move] = MoveOrder,
Player =  
 case utilities:whos_in_play(Board) of 
  x -> Player1Move;
  o -> Player2Move
 end,
{Validity,ReturnedBoard} = Move(Player),
 case Validity of
  valid   -> complete_turn(ReturnedBoard,MoveOrder);
  invalid -> restart_turn(), take_turn(Board,MoveOrder)
 end.

complete_turn(Board,MoveOrder) -> 
 complete_turn(Board, utilities:game_won(Board),MoveOrder).
complete_turn(_, {true, Winner},_) -> 
 case Winner of 
  x -> utilities:x_wins(); 
  o -> utilities:o_wins() 
 end;
complete_turn(Board, false,MoveOrder) -> 
 complete_turn(Board, utilities:check_for_draw(Board),MoveOrder);
complete_turn(_, cats_game,_) -> 
 console_io:display("Draw!\n");
complete_turn(Board, not_yet,MoveOrder) -> 
 io:format("\e[H\e[2J"),
 console_io:display_board(Board),
 take_turn(Board,MoveOrder).

restart_turn() -> 
 console_io:display("Invalid Move, try again...\n").

set_mode(Option) -> 
 case Option of
  "1"  -> [human,human];
  "2"  -> [human,computer]; 
  "3"  -> [computer,computer]
 end.