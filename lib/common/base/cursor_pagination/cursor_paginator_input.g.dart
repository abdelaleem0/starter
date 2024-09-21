// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_paginator_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPaginatorInput _$CursorPaginatorInputFromJson(
        Map<String, dynamic> json) =>
    CursorPaginatorInput(
      cursor: json['cursor'] as String?,
      limit: (json['limit'] as num?)?.toInt() ?? 15,
      direction: $enumDecodeNullable(
          _$ApiCursorBasedPaginationDirectionEnumMap, json['direction']),
      sort: $enumDecodeNullable(_$ApiCursorBasedSortTypeEnumMap, json['sort']),
    );

Map<String, dynamic> _$CursorPaginatorInputToJson(
        CursorPaginatorInput instance) =>
    <String, dynamic>{
      'cursor': instance.cursor,
      'direction':
          _$ApiCursorBasedPaginationDirectionEnumMap[instance.direction],
      'limit': instance.limit,
      'sort': _$ApiCursorBasedSortTypeEnumMap[instance.sort],
    };

const _$ApiCursorBasedPaginationDirectionEnumMap = {
  ApiCursorBasedPaginationDirection.BEFORE: 'BEFORE',
  ApiCursorBasedPaginationDirection.AFTER: 'AFTER',
};

const _$ApiCursorBasedSortTypeEnumMap = {
  ApiCursorBasedSortType.ASC: 'ASC',
  ApiCursorBasedSortType.DESC: 'DESC',
};
