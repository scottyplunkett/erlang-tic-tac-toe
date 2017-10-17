-module(store_tests).
-include_lib("eunit/include/eunit.hrl").

store_move_test() ->
  [{ "stores a piece on the board",
      ?assertEqual(
        ["piece", 2, 3],
        store:store_move(1, "piece", [1,2,3]))
    }].

