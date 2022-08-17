import 'package:cubit_util/cubit_util.dart';
import 'package:domain_book/domain_book.dart';
import 'package:entity_book/entity_book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_util/result_util.dart';

import '../state/detail_state.dart';

class DetailCubit extends Cubit<DetailState> with SafeEmitCubit {
  final GetBookDetailUseCase _getBookDetailUseCase;

  DetailCubit({
    required GetBookDetailUseCase getBookDetailUseCase,
    required int bookId,
    Book? bookData,
  })  : _getBookDetailUseCase = getBookDetailUseCase,
        super(
          DetailState(
            bookId: '$bookId',
            apiResult:
                bookData == null ? const AsyncLoading() : AsyncData(bookData),
          ),
        );

  void load() async {
    if (state.apiResult.isLoading) {
      return;
    }
    emit(state.copyWith(
      apiResult: const AsyncLoading(),
    ));
    final result = await _getBookDetailUseCase.call(
      bookId: state.bookId,
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
}
