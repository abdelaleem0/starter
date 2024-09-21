// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginator_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatorInput _$PaginatorInputFromJson(Map<String, dynamic> json) =>
    PaginatorInput(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 15,
    );

Map<String, dynamic> _$PaginatorInputToJson(PaginatorInput instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
