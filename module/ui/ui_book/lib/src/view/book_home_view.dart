import 'package:entity_book/entity_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:base_component/base_component.dart';
import 'package:result_util/result_util.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:ui_book/src/cubit/home_cubit.dart';
import 'package:ui_book/src/state/home_state.dart';

import '../component/book_component.dart';
import '../component/book_loading_component.dart';
import '../locale/book_locale.dart';

class BookHomeView extends StatelessWidget {
  static const loadingStateKey = 'key-loading';
  static const loadedStateKey = 'key-loaded';
  static const errorStateKey = 'key-error';
  static const retryButtonKey = 'key-retry-button';

  const BookHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale.books),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.apiResult.isLoading) {
              return const _LoadingBooks(
                key: Key(BookHomeView.loadingStateKey),
              );
            } else if (state.apiResult.isData) {
              return _LoadedBooks(
                key: const Key(BookHomeView.loadedStateKey),
                data: state.apiResult.asData?.value.results ?? [],
              );
            } else {
              return const _ErrorBooks(
                key: Key(BookHomeView.errorStateKey),
              );
            }
          },
        ),
      ),
    );
  }
}

class _LoadingBooks extends StatelessWidget {
  const _LoadingBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: ColorToken.backgroundSubtle,
          height: 4,
        ),
        itemCount: 15,
        itemBuilder: (context, index) => const BookLoadingComponent(),
      ),
    );
  }
}

class _LoadedBooks extends StatefulWidget {
  final List<Book> data;

  const _LoadedBooks({Key? key, required this.data}) : super(key: key);

  @override
  State<_LoadedBooks> createState() => _LoadedBooksState();
}

class _LoadedBooksState extends State<_LoadedBooks> {
  late final List<Book> data;

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return PullToRefresh(
      onRefresh: () async {
        context.read<HomeCubit>().load();
      },
      child: CustomScrollView(
        slivers: [
          SliverPinnedHeader(
            child: Container(
              color: ColorToken.inverse01,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBarComponent(
                  placeholder: locale.search,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final book = data[index];

                return Column(
                  children: [
                    if (index > 0) ...{
                      const Divider(height: 8, color: BaseColor.systemBlack),
                    },
                    BookComponent(
                      book: book,
                      onTap: () => _goToBookDetail(context, book),
                    ),
                  ],
                );
              },
              childCount: data.length,
            ),
          ),
        ],
      ),
    );
  }

  void _goToBookDetail(BuildContext context, Book book) {
    context.goNamed(
      'detail',
      params: {'id': '${book.id}'},
      extra: book,
    );
  }
}

class _ErrorBooks extends StatelessWidget {
  static const String imageNoConnection =
      'packages/ui_book/asset/image/nointernet_connection.png';

  const _ErrorBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    'Something went wrong..',
                    style: TypographyToken.subheading18(),
                  ),
                  const SizedBox(height: 8),
                  TextComponent(
                    'An alien is probably blocking your signal.',
                    style: TypographyToken.body14(),
                  ),
                ],
              ),
            ),
          ),
          Row(children: [
            Expanded(
              child: ButtonComponent.large(
                'RETRY',
                key: const Key(BookHomeView.retryButtonKey),
                style: BaseButtonStyle.outlineGreen,
                onPressed: () => context.read<HomeCubit>().load(),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
