import 'package:base_component/base_component.dart';
import 'package:collection/collection.dart';
import 'package:entity_book/entity_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:result_util/result_util.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_book/src/component/book_detail_component.dart';

import '../cubit/detail_cubit.dart';
import '../locale/book_locale.dart';
import '../state/detail_state.dart';
import '../component/book_detail_loading_component.dart';

class DetailView extends StatefulWidget {
  static const loadingStateKey = 'key-loading';
  static const loadedStateKey = 'key-loaded';
  static const errorStateKey = 'key-error';
  static const retryButtonKey = 'key-retry-button';

  final int bookId;

  const DetailView({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<DetailCubit>();
    if (cubit.state.apiResult.value == null) {
      cubit.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.booksDetail),
        centerTitle: true,
      ),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          if (state.apiResult.isLoading) {
            return const _LoadingBook(
              key: Key(DetailView.loadingStateKey),
            );
          } else if (state.apiResult.isData) {
            final bookData = state.apiResult.asData?.value;
            if (bookData != null) {
              return BookDetailComponent(
                book: bookData,
                onTapAuthor: () => _goToSearchAuthor(context, bookData),
              );
            }
          }
          return const _ErrorBook(
            key: Key(DetailView.errorStateKey),
          );
        },
      ),
    );
  }

  void _goToSearchAuthor(BuildContext context, Book bookData) {
    context.goNamed(
      'search_result',
      params: {'id': '${bookData.id}'},
      queryParams: {'author': bookData.authors.firstOrNull?.name ?? ''},
    );
  }
}

class _LoadingBook extends StatelessWidget {
  const _LoadingBook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const BookDetailLoadingComponent(),
    );
  }
}

class _ErrorBook extends StatelessWidget {
  static const String imageNoConnection =
      'packages/ui_book/asset/image/nointernet_connection.png';

  const _ErrorBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageComponent.asset(
                    imageNoConnection,
                    width: 300,
                  ),
                  const SizedBox(height: 24),
                  TextComponent(
                    locale.somethingWrong,
                    style: TypographyToken.subheading18(),
                  ),
                  const SizedBox(height: 8),
                  TextComponent(
                    locale.alienBlocking,
                    style: TypographyToken.body14(),
                  ),
                ],
              ),
            ),
          ),
          Row(children: [
            Expanded(
              child: ButtonComponent.large(
                locale.retry,
                key: const Key(DetailView.retryButtonKey),
                style: BaseButtonStyle.outlineGreen,
                onPressed: () => context.read<DetailCubit>().load(),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
