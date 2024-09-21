import 'package:equatable/equatable.dart';

class PaginatedData<T> extends Equatable {
  final List<T> items;
  final PageInfo pageInfo;

  const PaginatedData(this.items, this.pageInfo);

  @override
  List<Object?> get props => [items, pageInfo];
}

class PageInfo extends Equatable {
  final int page;
  final int limit;
  final bool hasNext;

  const PageInfo(this.page, this.limit, this.hasNext,);

  const PageInfo.initial():this(1, 15, false);

  static const PageInfo empty = PageInfo(0, 20, true);

  @override
  List<Object?> get props => [page, limit, hasNext];
}