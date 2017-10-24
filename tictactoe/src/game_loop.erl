-module(game_loop).
-export([ begin_play/0,begin_play/1
          % take_turn/2
          ]).

begin_play() ->
  begin_play("greet").
begin_play("greet") ->
  console_io:greet_user();
begin_play("make and display new board") ->
  Board = format_board:make_new_board(),
  DisplayBoard = format_board:split_board_into_rows(Board),
  console_io:display_board(DisplayBoard).
% begin_play(3) ->
%   io:format("Player1:"),
%   {ok,[Marker1]} = console_io:get_marker(),
%   Player1 = list_to_atom(Marker1).
%   io:format("Player2:"),
%   {ok,[Marker2]} = console_io:get_marker(),
%   Player2 = list_to_atom(Marker2),
%   take_turn({Player1,Player2},Board).

% take_turn({PlayerInTurn,NextPlayer},Board) ->
%   PlayerSpecifier = "~s player>",
%   io:format(lists:flatten(io_lib:format(PlayerSpecifier, [PlayerInTurn]))),
%   {ok,[Move]} = turn_progression:send_request_for_move(console_io),
%   NewBoard = turn_progression:place_marker(list_to_integer(Move), PlayerInTurn, Board),
%   console_io:display_board(format_board:split_board_into_rows(NewBoard)),
%   take_turn({NextPlayer,PlayerInTurn},NewBoard).


