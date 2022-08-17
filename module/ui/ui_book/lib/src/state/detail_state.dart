import 'package:entity_book/entity_book.dart';
import 'package:result_util/result_util.dart';

class DetailState {
  final String bookId;
  final AsyncValue<Book> apiResult;
  final double progressDownload;

  DetailState({
    this.bookId = '',
    this.apiResult = const AsyncLoading(),
    this.progressDownload = 0,
  });

  DetailState copyWith({
    String? bookId,
    AsyncValue<Book>? apiResult,
    double? progressDownload,
  }) {
    return DetailState(
      bookId: bookId ?? this.bookId,
      apiResult: apiResult ?? this.apiResult,
      progressDownload: progressDownload ?? this.progressDownload,
    );
  }
}
