-module(game_loop_tests).
% -include_lib("eunit/include/eunit.hrl").

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
