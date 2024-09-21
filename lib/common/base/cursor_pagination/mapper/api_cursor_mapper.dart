import 'package:starter/common/base/cursor_pagination/api_page_info_result.dart';
import 'package:starter/common/base/cursor_pagination/cursor_pagination.dart';

extension ApiPageInfoMapper on ApiPageInfoCursor {
  CursorPageInfoResult map() {
    return CursorPageInfoResult(
        page: page ?? 0,
        limit: limit ?? 0,
        nextCursor: nextCursor ?? "",
        beforeCursor: beforeCursor ?? "",
        hasNext: hasNext ?? false,
        hasBefore: hasBefore ?? false,
        totalCount: totalCount ?? 0,
        totalPages: totalPages ?? 0,
        direction: direction ?? "");
  }
}