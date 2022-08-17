import 'package:cubit_util/cubit_util.dart';
import 'package:domain_book/domain_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_client/network_client.dart';
import 'package:result_util/result_util.dart';

import '../state/book_list_state.dart';

class BookListCubit extends Cubit<BookListState> with SafeEmitCubit {
  final GetBooksUseCase _getBooksUseCase;

  BookListCubit({
    required GetBooksUseCase getBooksUseCase,
    String keyword = '',
  })  : _getBooksUseCase = getBooksUseCase,
        super(BookListState(keyword: keyword));

  void load({String? keyword}) async {
    if (state.apiResult.isLoading && !state.isFirstTime) {
      return;
    }
    emit(state.copyWith(
      keyword: keyword,
      apiResult: const AsyncLoading(),
      isFirstTime: false,
    ));
    final result = await _getBooksUseCase.call(
      searchQuery: keyword,
    );
    if (result.isValue) {
      emit(state.copyWith(
        apiResult: AsyncData(result.asValue!.value),
      ));
    } else {
      emit(state.copyWith(
        apiResult: AsyncError(
          result.asError?.error ?? Exception('Error network'),
        ),
      ));
    }
  }

  void loadAndAppend() async {
    final nextFullUrl = state.apiResult.asData?.value.next;
    // if next is nullOrEmpty or still loading, then return
    if (nextFullUrl?.isEmpty ?? true == true || state.isLoadingMorePage) {
      return;
    }
    emit(state.copyWith(isLoadingMorePage: true));
    final result = await _getBooksUseCase.call(
      fullUrl: nextFullUrl,
      searchQuery: state.keyword,
    );
    if (result.isValue) {
      final newResults = result.asValue!.value;
      final oldResults = state.apiResult.asData?.value ?? GoatResponseArray();

      emit(state.copyWith(
        apiResult: AsyncData(oldResults.appendResult(newResults)),
        isLoadingMorePage: false,
      ));
    } else {
      emit(state.copyWith(
        error: ConsumableValue(
          result.asError?.error ?? Exception('Error network'),
        ),
        isLoadingMorePage: false,
      ));
    }
  }

  void setNewKeyword(String keyword) {
    emit(state.copyWith(keyword: keyword));
  }
}
