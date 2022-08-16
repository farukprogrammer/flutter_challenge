import 'package:async/async.dart';
import 'package:entity_book/entity_book.dart';
import 'package:network_client/network_client.dart';

class BookRepository implements GetBooksInterface {
  final NetworkClient apiClient;

  BookRepository(this.apiClient);

  @override
  Future<Result<GoatResponseArray<Book>>> getBooks({
    required String fullUrl,
    String? searchQuery,
  }) {
    final fullUri = Uri.parse(fullUrl);
    final queryParam = <String, dynamic>{
      'search': searchQuery ?? '',
    };
    queryParam.addAll(fullUri.queryParameters);

    return apiClient.getRequestArrayFull(
      Book.fromJson,
      path: fullUri.path,
      queryParameters: queryParam,
    );
  }
}
