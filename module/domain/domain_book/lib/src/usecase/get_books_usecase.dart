import 'package:async/async.dart';
import 'package:entity_book/entity_book.dart';
import 'package:network_client/network_client.dart';

class GetBooksUseCase {
  final GetBooksInterface _getBooks;

  const GetBooksUseCase(this._getBooks);

  Future<Result<GoatResponseArray<Book>>> call({
    String? fullUrl,
    String? searchQuery,
  }) {
    return _getBooks.getBooks(
      fullUrl: fullUrl ?? GetBooksInterface.defaultFullUrl,
      searchQuery: searchQuery,
    );
  }
}