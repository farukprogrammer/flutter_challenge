import 'package:cubit_util/cubit_util.dart';
import 'package:entity_book/entity_book.dart';
import 'package:network_client/network_client.dart';
import 'package:result_util/result_util.dart';

class BookListState {
  final String keyword;
  final AsyncValue<GoatResponseArray<Book>> apiResult;
  // one time error
  final ConsumableValue<Object>? error;
  final bool isLoadingMorePage;
  final bool isFirstTime;

  BookListState({
    this.keyword = '',
    this.apiResult = const AsyncLoading(),
    this.error,
    this.isLoadingMorePage = false,
    this.isFirstTime = true,
  });

  BookListState copyWith({
    String? keyword,
    AsyncValue<GoatResponseArray<Book>>? apiResult,
    ConsumableValue<Object>? error,
    bool? isLoadingMorePage,
    bool? isFirstTime,
  }) {
    return BookListState(
      keyword: keyword ?? this.keyword,
      apiResult: apiResult ?? this.apiResult,
      error: error ?? this.error,
      isLoadingMorePage: isLoadingMorePage ?? this.isLoadingMorePage,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }
}
