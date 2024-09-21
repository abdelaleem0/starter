
class CursorPaginatedData<T>  {
  final List<T> items;
  final CursorPageInfoResult pageInfo;

  const CursorPaginatedData(this.items, this.pageInfo);

  @override
  List<Object?> get props => [
        items,
        pageInfo,
      ];
}

class CursorPageInfoResult  {
   final int page;
   final int limit;
   final String nextCursor;
   final String beforeCursor;
   final bool hasNext;
   final bool hasBefore;
   final int totalCount;
   final int totalPages;
   final String direction;

  // static const CursorPageInfo empty = CursorPageInfo(1, 20, false);

   const CursorPageInfoResult(
      { required this.page,
        required this.limit,
        required this.nextCursor,
        required  this.beforeCursor,
        required this.hasNext,
        required this.hasBefore,
        required this.totalCount,
        required this.totalPages,
        required this.direction});

   const CursorPageInfoResult.initial():this(limit: 0,
   page: 1,
   beforeCursor: "",
   direction: "",
   hasBefore: false,
   hasNext: false,nextCursor: "",totalCount: 0,totalPages: 0);

  @override
  List<Object?> get props => [
        page,
        limit,
        nextCursor,
        beforeCursor,
        hasNext,
        hasBefore,
        totalCount,
        totalPages,
        direction
      ];
}

class CursorPageInfoInput   {
 final  String? cursor;
 final  CursorBasedPaginationDirection? direction;
 final  int limit;
 final  CursorBasedSortType? sort;

 const CursorPageInfoInput(
      { this.cursor,
       this.direction,
      required this.limit,
       this.sort});

  @override
  List<Object?> get props => [cursor, direction, limit, sort];
}

enum CursorBasedPaginationDirection { before, after }

enum CursorBasedSortType { asc, desc }




