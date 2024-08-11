import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

abstract class PaginationScrollController extends ReactiveViewModel {
  final scrollController = ScrollController();

  int lastWeekRange = 1;

  final isLoading = ValueNotifier<bool>(false);
  final isDataEmpty = ValueNotifier<bool>(false);

  @override
  void dispose() {
    scrollController.dispose();
    isDataEmpty.dispose();
    isLoading.dispose();
    super.dispose();
  }

  Future<bool> fetchData();

  bool changeLoading() => isLoading.value = !isLoading.value;

  paginationReset() {
    isDataEmpty.value = false;
  }

  void loadMore(ScrollNotification notification) async {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent && !isDataEmpty.value) {
        changeLoading();
        isDataEmpty.value = !(await fetchData());
        changeLoading();
      }
    }
  }
}
