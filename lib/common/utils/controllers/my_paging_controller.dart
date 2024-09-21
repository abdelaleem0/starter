import 'package:starter/common/base/pagination/pagination.dart';
import 'package:starter/common/utils/extensions/extensions.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../common.dart';

class MyPagingController<K extends int, T> extends PagingController<K, T> {
  MyPagingController(
      {required super.firstPageKey, super.invisibleItemsThreshold = 8});

  void onDataLoaded(PaginatedData? data) {
    if (data == null) {
      appendLastPage([] as List<T>);
      return;
    }

    try {
      final isLastPage = !(data.pageInfo.hasNext);
      if (isLastPage) {
        appendLastPage(data.items as List<T>);
      } else {
        final int nextPageKey = data.pageInfo.page + 1;
        appendPage(data.items as List<T>, nextPageKey as K);
      }
    } catch (error) {
      this.error = error;
    }
  }

  void updateItem(
    bool Function(T e) updateWhere,
    T newItem,
  ) {
    if (itemList == null) return;

    final index = itemList!.firstIndexWhere(updateWhere);

    if (index == null) {
      logDebug("item Not found in List ");
    } else {
      List<T> newList = List.from(itemList!);
      newList[index] = newItem;
      itemList = newList;
    }
  }

  void removeItem(
    bool Function(T e) removeWhere,
  ) {
    if (itemList == null) return;

    List<T> newList = List.from(itemList!);
    newList.removeWhere(removeWhere);
    itemList = newList;
  }

  void addItem(T item, {int? atIndex}) {
    if (itemList == null) return;

    List<T> newList = List.from(itemList!);

    if (atIndex != null) {
      newList.insert(atIndex, item);
    } else {
      newList.add(item);
    }

    itemList = newList;
  }

  bool get isLoadAllData => pagingStatus == PagingStatus.completed;

  int get itemsLength => itemList?.length ?? 0;

  PagingStatus get pagingStatus => value.status;


}
