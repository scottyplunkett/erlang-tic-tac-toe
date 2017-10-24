-module(turn_progression).
-export([stop_turning/2,
         send_request_for_move/1,
         validate_move/1,
         place_marker/3,
         switch_player/1]).

send_request_for_move(console_io) -> console_io:get_move().

stop_turning(true,_EndConditionInfo) -> _EndConditionInfo;
stop_turning(false,_NextTurnParams) ->  _NextTurnParams.

validate_move(_) ->
  true.

place_marker(Location, Piece, Board) ->
  store:store_move(Location, Piece, Board).

switch_player({PlayerInPlay,NextPlayer}) ->
  {NextPlayer,PlayerInPlay}.

