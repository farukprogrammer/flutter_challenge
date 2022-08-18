import 'package:async/async.dart';
import 'package:entity_book/entity_book.dart';
import 'package:fake_domain_book/fake_domain_book.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_client/network_client.dart';
import 'package:test_util/test_util.dart';
import 'package:ui_book/src/view/detail_view.dart';
import 'package:ui_book/ui_book.dart';

void main() {
  bool useCaseShouldSuccess = false;
  int testBookId = 123;
  String testBookTitle = 'test title';
  String testAuthorName = 'Jane';
  int testDownloadCount = 500;

  Book testBook = Book(
      id: testBookId,
      title: testBookTitle,
      downloadCount: testDownloadCount,
      authors: [Person(name: testAuthorName)]);

  // region mock-helper
  final testGetBookDetailUseCase = FakeGetBookDetailUseCase()
    ..stubCall = ({required bookId}) async {
      if (useCaseShouldSuccess) {
        return Future.value(Result.value(testBook));
      } else {
        return Future.value(Result.error(const NoInternetException()));
      }
    };
  // endregion

  setUpAll(() {});

  tearDown(() {
    useCaseShouldSuccess = false;
  });

  testPage(
    'Loading State should display correct component',
    pageBuilder: () => BookDetailPage(
      bookId: testBookId,
      getBookDetailUseCase: testGetBookDetailUseCase,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      final locale = BookLocale();

      // assert appbar text
      expect(find.text(locale.booksDetail), findsOneWidget);

      // Verify Loading State Displayed
      expect(
        find.byKey(const Key(DetailView.loadingStateKey)),
        findsOneWidget,
      );
    },
  );

  testPage(
    'Loaded State should display correct component',
    given: () async {
      useCaseShouldSuccess = true;
    },
    pageBuilder: () => BookDetailPage(
      bookId: testBookId,
      getBookDetailUseCase: testGetBookDetailUseCase,
      bookData: testBook,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      // to continue after loading state
      await tester.pumpAndSettle();

      final locale = BookLocale();

      // assert appbar text
      expect(find.text(locale.booksDetail), findsOneWidget);
      expect(find.text(testBookTitle), findsOneWidget);
      expect(find.text(testAuthorName), findsOneWidget);
      expect(
        find.text('${locale.downloads}: $testDownloadCount'),
        findsOneWidget,
      );
      expect(find.text(locale.readHere), findsOneWidget);

      // Verify Loaded State Displayed
      expect(
        find.byKey(const Key(DetailView.loadedStateKey)),
        findsOneWidget,
      );
    },
  );

  testPage(
    'Error State should display correct component',
    given: () async {
      useCaseShouldSuccess = false;
    },
    pageBuilder: () => BookDetailPage(
      bookId: testBookId,
      getBookDetailUseCase: testGetBookDetailUseCase,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      // to continue after loading state
      await tester.pumpAndSettle();

      final locale = BookLocale();

      // assert appbar text
      expect(find.text(locale.booksDetail), findsOneWidget);

      // Verify Error State Displayed
      expect(
        find.byKey(const Key(DetailView.errorStateKey)),
        findsOneWidget,
      );
    },
  );

  testPage(
    'Click Retry on Error State should reload page',
    given: () async {
      useCaseShouldSuccess = false;
    },
    pageBuilder: () => BookDetailPage(
      bookId: testBookId,
      getBookDetailUseCase: testGetBookDetailUseCase,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      // to continue after loading state
      await tester.pumpAndSettle();

      // Verify Error State Displayed
      expect(find.byKey(const Key(DetailView.errorStateKey)), findsOneWidget);

      // change api to success
      useCaseShouldSuccess = true;

      // Click retry
      await tester.tap(find.byKey(const Key(DetailView.retryButtonKey)));
      await tester.pumpAndSettle();

      // Verify Loaded State Displayed
      expect(
        find.byKey(const Key(DetailView.loadedStateKey)),
        findsOneWidget,
      );
    },
  );
}
