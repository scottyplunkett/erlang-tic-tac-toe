-module(game_loop_tests).
-include_lib("eunit/include/eunit.hrl").


complete_turn_test() -> 
  [{  "completes a turn by either starting a new turn or ending the game when won or board full",
      ?assertEqual(console_io:display(utilities:o_wins()),
                   game_loop:complete_turn([o,2,3,o,5,6,o,8,9])),
      ?assertEqual(console_io:display(utilities:x_wins()),
                   game_loop:complete_turn([x,2,3,4,x,6,7,8,x])),
      ?assertEqual(console_io:display("Draw!\n"),
                   game_loop:complete_turn([x,o,x,o,x,x,o,x,o]))}].

% ?assertEqual(game_loop:take_turn([x,o,x,4,x,x,7,x,9], x),
%              utilities:complete_turn([x,o,x,4,x,x,7,x,9], o))}].


% begin_play_test() -> 
%   [{ "begins play, displays initial board",
%       ?assert(console_io:greet_user() 
%               =:= 
%               game_loop:begin_play("greet")),
%       ?assert(console_io:display_board(
%                 format_board:split_board_into_rows(
%                   format_board:make_new_board())) 
%               =:= 
%               game_loop:begin_play("make and display new board")),
%       ?assert({player1,player2}
%               =:=
%               game_loop:begin_play("get player markers"))}].
% % take_turn_test() -> 
% %   [{ "allows the player in turn, to make a move, than switches the players and calls itself",
% %       ?assertEqual()}]
