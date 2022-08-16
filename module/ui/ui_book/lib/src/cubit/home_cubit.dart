import 'package:cubit_util/cubit_util.dart';
import 'package:domain_book/domain_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
