import 'package:async/async.dart';
import 'package:network_client/network_client.dart';

import '../model/book.dart';

abstract class GetBooksInterface {
  static const defaultFullUrl = 'https://gutendex.com/books/';

  Future<Result<GoatResponseArray<Book>>> getBooks({
    required String fullUrl,
    String? searchQuery,
  });
}
