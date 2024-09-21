
import 'package:starter/common/base/cursor_pagination/cursor_pagination.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cursor_paginator_input.g.dart';

@JsonSerializable()
class CursorPaginatorInput extends Equatable {
  final String? cursor;
  final ApiCursorBasedPaginationDirection? direction;
  final int limit;
  final ApiCursorBasedSortType? sort;

  const CursorPaginatorInput(
      {this.cursor, this.limit = 15, this.direction, this.sort});

  factory CursorPaginatorInput.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginatorInputFromJson(json);

  Map<String, dynamic> toJson() => _$CursorPaginatorInputToJson(this);

  Map<String, dynamic> toJsonWithoutNulls() {
    final Map<String, dynamic> filteredJson = {};
    toJson().forEach((key, value) {
      if (value != null) {
        filteredJson[key] = value;
      }
    });
    return filteredJson;
  }

  factory CursorPaginatorInput.fromInput(CursorPageInfoInput data) {
    return CursorPaginatorInput(
        cursor: data.cursor,
        direction: data.direction == null
            ? null
            :getDirection(data.direction!),
        limit: data.limit,
        sort: data.sort == null
            ? null
            :getSort(data.sort!));
  }

  CursorPaginatorInput copyWith({
    String? cursor,
    ApiCursorBasedPaginationDirection? direction,
    int? limit,
    ApiCursorBasedSortType? sort,
  }) {
    return CursorPaginatorInput(
      cursor: cursor ?? this.cursor,
      direction: direction ?? this.direction,
      limit: limit ?? this.limit,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props => [cursor, direction, limit, sort];

  static ApiCursorBasedSortType getSort(CursorBasedSortType cursorBasedSortType){
    if(cursorBasedSortType == CursorBasedSortType.asc){
      return ApiCursorBasedSortType.ASC;
    }else{
      return ApiCursorBasedSortType.DESC;
    }
  }

  static ApiCursorBasedPaginationDirection getDirection(CursorBasedPaginationDirection cursorBasedPaginationDirection){
    if(cursorBasedPaginationDirection == CursorBasedPaginationDirection.before){
      return ApiCursorBasedPaginationDirection.BEFORE;
    }else{
      return ApiCursorBasedPaginationDirection.AFTER;
    }
  }
}

enum ApiCursorBasedPaginationDirection { BEFORE, AFTER }

enum ApiCursorBasedSortType { ASC, DESC }
