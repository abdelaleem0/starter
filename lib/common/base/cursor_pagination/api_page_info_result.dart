class ApiPageInfoCursor {
  int? page;
  int? limit;
  String? nextCursor;
  String? beforeCursor;
  bool? hasNext;
  bool? hasBefore;
  int? totalCount;
  int? totalPages;
  String? direction;

  ApiPageInfoCursor({
    this.page,
    this.limit,
    this.nextCursor,
    this.beforeCursor,
    this.hasNext,
    this.hasBefore,
    this.totalCount,
    this.totalPages,
    this.direction,
  });

  factory ApiPageInfoCursor.fromJson(Map<String, dynamic> json) =>
      ApiPageInfoCursor(
        page: json["page"],
        limit: json["limit"],
        nextCursor: json["nextCursor"],
        beforeCursor: json["beforeCursor"],
        hasNext: json["hasNext"],
        hasBefore: json["hasBefore"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        direction: json["direction"],
      );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "nextCursor": nextCursor,
    "beforeCursor": beforeCursor,
    "hasNext": hasNext,
    "hasBefore": hasBefore,
    if(totalCount != null) "totalCount": totalCount,
    if(totalPages != null) "totalPages": totalPages,
    "direction": direction,
  };
}