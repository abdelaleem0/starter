
import 'package:starter/common/base/pagination/pagination.dart';

class ApiPageInfo {
  ApiPageInfo({
    required this.page,
    required this.limit,
    required this.hasNext,
  });

  int page;
  int limit;
  bool hasNext;

  factory ApiPageInfo.fromJson(Map<String, dynamic> json) => ApiPageInfo(
        page: json["page"] ?? 0,
        limit: json["limit"] ?? 0,
        hasNext: json["hasNext"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "hasNext": hasNext,
      };

  PageInfo map() {
    return PageInfo(
      page,
      limit,
      hasNext,
    );
  }
}
