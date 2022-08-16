import 'package:async/async.dart';
import 'package:network_client/network_client.dart';

import '../model/book.dart';

abstract class GetBookDetailInterface {
  static const path = '/books/:id';

  Future<Result<Book>> getBookDetail({
    required String bookId,
  });
}
