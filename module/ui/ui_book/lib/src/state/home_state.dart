import 'package:entity_book/entity_book.dart';
import 'package:network_client/network_client.dart';
import 'package:result_util/result_util.dart';

class HomeState {
  final String keyword;
  final AsyncValue<GoatResponseArray<Book>> apiResult;

  HomeState({
    this.keyword = '',
    this.apiResult = const AsyncLoading(),
  });

  HomeState copyWith({
    int? currentPage,
    String? keyword,
    AsyncValue<GoatResponseArray<Book>>? apiResult,
  }) {
    return HomeState(
      keyword: keyword ?? this.keyword,
      apiResult: apiResult ?? this.apiResult,
    );
  }
}
