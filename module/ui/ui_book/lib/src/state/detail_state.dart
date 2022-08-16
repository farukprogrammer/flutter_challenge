import 'package:entity_book/entity_book.dart';
import 'package:result_util/result_util.dart';

class DetailState {
  final String bookId;
  final AsyncValue<Book> apiResult;

  DetailState({
    this.bookId = '',
    this.apiResult = const AsyncLoading(),
  });

  DetailState copyWith({
    String? bookId,
    AsyncValue<Book>? apiResult,
  }) {
    return DetailState(
      bookId: bookId ?? this.bookId,
      apiResult: apiResult ?? this.apiResult,
    );
  }
}
