import 'package:async/async.dart';
import 'package:fake_domain_book/fake_domain_book.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_client/network_client.dart';
import 'package:test_util/test_util.dart';
import 'package:ui_book/src/view/book_list_view.dart';
import 'package:ui_book/ui_book.dart';

void main() {
  String testField = 'author';
  String testKeyword = 'jane';
  bool useCaseShouldSuccess = false;

  // region mock-helper
  final testGetBooksUseCase = FakeGetBooksUseCase()
    ..stubCall = ({fullUrl, searchQuery}) async {
      if (useCaseShouldSuccess) {
        return Future.value(Result.value(GoatResponseArray()));
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
    pageBuilder: () => BookSearchResultPage(
      getBooksUseCase: testGetBooksUseCase,
      field: testField,
      keyword: testKeyword,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      // assert appbar text
      expect(find.text('$testField: $testKeyword'), findsOneWidget);
      // assert search bar not displayed
      expect(
        find.byKey(const Key(BookListView.seachBarKey)),
        findsNothing,
      );

      // Verify Loading State Displayed
      expect(
        find.byKey(const Key(BookListView.loadingStateKey)),
        findsOneWidget,
      );
    },
  );

  testPage(
    'Loaded State should display correct component',
    given: () async {
      useCaseShouldSuccess = true;
    },
    pageBuilder: () => BookSearchResultPage(
      getBooksUseCase: testGetBooksUseCase,
      field: testField,
      keyword: testKeyword,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      // to continue after loading state
      await tester.pumpAndSettle();

      // assert appbar text
      expect(find.text('$testField: $testKeyword'), findsOneWidget);
      // assert search bar not displayed
      expect(
        find.byKey(const Key(BookListView.seachBarKey)),
        findsNothing,
      );

      // Verify Loaded State Displayed
      expect(
        find.byKey(const Key(BookListView.loadedStateKey)),
        findsOneWidget,
      );
    },
  );

  testPage(
    'Error State should display correct component',
    given: () async {
      useCaseShouldSuccess = false;
    },
    pageBuilder: () => BookSearchResultPage(
      getBooksUseCase: testGetBooksUseCase,
      field: testField,
      keyword: testKeyword,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      // to continue after loading state
      await tester.pumpAndSettle();

      // assert appbar text
      expect(find.text('$testField: $testKeyword'), findsOneWidget);
      // assert search bar not displayed
      expect(
        find.byKey(const Key(BookListView.seachBarKey)),
        findsNothing,
      );

      // Verify Error State Displayed
      expect(
        find.byKey(const Key(BookListView.errorStateKey)),
        findsOneWidget,
      );
    },
  );

  testPage(
    'Click Retry on Error State should reload page',
    given: () async {
      useCaseShouldSuccess = false;
    },
    pageBuilder: () => BookSearchResultPage(
      getBooksUseCase: testGetBooksUseCase,
      field: testField,
      keyword: testKeyword,
    ),
    localeDelegate: BookLocaleDelegate(),
    then: (tester) async {
      // to continue after loading state
      await tester.pumpAndSettle();

      // Verify Error State Displayed
      expect(find.byKey(const Key(BookListView.errorStateKey)), findsOneWidget);
      // assert search bar not displayed
      expect(
        find.byKey(const Key(BookListView.seachBarKey)),
        findsNothing,
      );

      // change api to success
      useCaseShouldSuccess = true;

      // Click retry
      await tester.tap(find.byKey(const Key(BookListView.retryButtonKey)));
      await tester.pumpAndSettle();

      // assert search bar not displayed
      expect(
        find.byKey(const Key(BookListView.seachBarKey)),
        findsNothing,
      );
      // Verify Loaded State Displayed
      expect(
        find.byKey(const Key(BookListView.loadedStateKey)),
        findsOneWidget,
      );
    },
  );
}
