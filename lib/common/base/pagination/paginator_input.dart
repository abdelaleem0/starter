import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginator_input.g.dart';

@JsonSerializable()
class PaginatorInput extends Equatable {
  final int page;
  final int limit;

  const PaginatorInput({this.page = 1, this.limit = 15});

  factory PaginatorInput.fromJson(Map<String, dynamic> json) =>
      _$PaginatorInputFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatorInputToJson(this);

  factory PaginatorInput.fromInput(PaginatorInput data) {
    return PaginatorInput(
      page: data.page,
      limit: data.limit,
    );
  }

  @override
  List<Object?> get props => [page, limit];
}
