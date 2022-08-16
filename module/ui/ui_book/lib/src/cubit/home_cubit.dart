import 'package:cubit_util/cubit_util.dart';
import 'package:domain_book/domain_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_client/network_client.dart';
import 'package:result_util/result_util.dart';

import '../state/home_state.dart';

class HomeCubit extends Cubit<HomeState> with SafeEmitCubit {
  final GetBooksUseCase _getBooksUseCase;

  HomeCubit({
    required GetBooksUseCase getBooksUseCase,
  })  : _getBooksUseCase = getBooksUseCase,
        super(HomeState());

  void load({
    String? keyword,
    String? fullUrl,
  }) async {
    emit(state.copyWith(
      keyword: keyword,
      apiResult: const AsyncLoading(),
    ));
    final result = await _getBooksUseCase.call(
      fullUrl: fullUrl,
      searchQuery: keyword,
    );
    if (result.isValue) {
      if (result.asValue?.value.results.isNotEmpty == true) {
        emit(state.copyWith(
          apiResult: AsyncData(result.asValue!.value),
        ));
      }
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
    if (nextFullUrl?.isEmpty == true || state.isLoadingMorePage) {
      return;
    }
    emit(state.copyWith(isLoadingMorePage: true));
    final result = await _getBooksUseCase.call(
      fullUrl: nextFullUrl,
      searchQuery: state.keyword,
    );
    if (result.isValue) {
      if (result.asValue?.value.results.isNotEmpty == true) {
        final newResults = result.asValue!.value;
        final oldResults = state.apiResult.asData?.value ?? GoatResponseArray();

        emit(state.copyWith(
          apiResult: AsyncData(oldResults.appendResult(newResults)),
          isLoadingMorePage: false,
        ));
      }
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
