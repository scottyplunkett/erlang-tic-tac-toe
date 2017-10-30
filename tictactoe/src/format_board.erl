-module(format_board).
-export([ get_board_length/1,
	  get_board_row_length/1,
	  split_board_into_rows/1,split_board_into_rows/2]).

get_board_length(Board) -> length(Board).

get_board_row_length(BoardLength) -> trunc(math:sqrt(BoardLength)).

split_board_into_rows(Board) ->
	BoardLength = get_board_length(Board),
	RowLength = get_board_row_length(BoardLength),
	split_board_into_rows(Board,RowLength).
split_board_into_rows(Board,RowLength) ->
    SkipLength = case length(Board) rem RowLength of
        0 -> 0;
        Rem -> RowLength - Rem
    end,
    split_board_into_rows(lists:reverse(Board),[],SkipLength,RowLength).
split_board_into_rows([],ListOfRowSublists,_,_) -> ListOfRowSublists;
split_board_into_rows([FirstCell|RestOfCells],ListOfRowSublists,PositionInRow,FilledRowSize) when PositionInRow==FilledRowSize ->
    split_board_into_rows(RestOfCells,[[FirstCell] | ListOfRowSublists],1,FilledRowSize);
split_board_into_rows([FirstCell|RestOfCells],[RowBeingFilled | FilledRowSublists],PositionInRow,FilledRowSize) ->
    split_board_into_rows(RestOfCells,[[FirstCell | RowBeingFilled] | FilledRowSublists],PositionInRow+1,FilledRowSize);
split_board_into_rows([FirstCell|RestOfCells],[],PositionInRow,FilledRowSize) ->
    split_board_into_rows(RestOfCells,[[FirstCell]],PositionInRow+1,FilledRowSize).





	

