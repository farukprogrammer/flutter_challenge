import 'package:async/async.dart';
import 'package:entity_book/entity_book.dart';

class GetBookDetailUseCase {
  final GetBookDetailInterface _getBookDetail;

  const GetBookDetailUseCase(this._getBookDetail);

  Future<Result<Book>> call({
    required String bookId,
  }) {
    return _getBookDetail.getBookDetail(
      bookId: bookId,
    );
  }
}
