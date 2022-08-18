import 'dart:async';

import 'package:entity_book/entity_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:base_component/base_component.dart';
import 'package:result_util/result_util.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:ui_book/src/cubit/book_list_cubit.dart';
import 'package:ui_book/src/state/book_list_state.dart';

import '../component/book_component.dart';
import '../component/book_loading_component.dart';
import '../locale/book_locale.dart';

class BookListView extends StatelessWidget {
  static const loadingStateKey = 'key-loading';
  static const loadedStateKey = 'key-loaded';
  static const seachBarKey = 'key-search-bar';
  static const errorStateKey = 'key-error';
  static const retryButtonKey = 'key-retry-button';

  final String title;
  final bool isUseSearchBar;

  const BookListView({
    Key? key,
    required this.title,
    this.isUseSearchBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: BlocBuilder<BookListCubit, BookListState>(
          builder: (context, state) {
            if (state.apiResult.isLoading) {
              return _LoadingBooks(
                key: const Key(BookListView.loadingStateKey),
                isUseSearchBar: isUseSearchBar,
                keyword: state.keyword,
              );
            } else if (state.apiResult.isData) {
              return _LoadedBooks(
                key: const Key(BookListView.loadedStateKey),
                isUseSearchBar: isUseSearchBar,
                keyword: state.keyword,
                data: state.apiResult.asData?.value.results ?? [],
                isLoadingMore: state.isLoadingMorePage,
              );
            } else {
              return const _ErrorBooks(
                key: Key(BookListView.errorStateKey),
              );
            }
          },
        ),
      ),
    );
  }
}

class _LoadingBooks extends StatelessWidget {
  final bool isUseSearchBar;

  final String keyword;

  const _LoadingBooks({
    Key? key,
    required this.isUseSearchBar,
    required this.keyword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: ColorToken.backgroundSubtle,
          height: 4,
        ),
        itemCount: 15,
        itemBuilder: (context, index) {
          if (isUseSearchBar && index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
              child: SearchBarComponent(
                placeholder: locale.search,
                text: keyword,
                enabled: false,
              ),
            );
          }
          return const BookLoadingComponent();
        },
      ),
    );
  }
}

class _LoadedBooks extends StatefulWidget {
  static const searchDebounceTime = 2;

  final String keyword;

  final List<Book> data;

  final bool isLoadingMore;

  final bool isUseSearchBar;

  const _LoadedBooks({
    Key? key,
    required this.keyword,
    required this.data,
    required this.isLoadingMore,
    required this.isUseSearchBar,
  }) : super(key: key);

  @override
  State<_LoadedBooks> createState() => _LoadedBooksState();
}

class _LoadedBooksState extends State<_LoadedBooks> {
  late ScrollController _scrollController;

  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final cubit = context.read<BookListCubit>();
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.95 &&
          !cubit.state.isLoadingMorePage) {
        cubit.loadAndAppend();
      }
    });
    if (_searchDebounce?.isActive == true) {
      _searchDebounce?.cancel();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (_searchDebounce?.isActive == true) {
      _searchDebounce?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = GoatLocale.of<BookLocale>(context);

    return PullToRefresh(
      onRefresh: () async {
        context.read<BookListCubit>().load();
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (widget.isUseSearchBar) ...[
            SliverPinnedHeader(
              key: const Key(BookListView.seachBarKey),
              child: Container(
                color: ColorToken.inverse01,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: SearchBarComponent(
                    placeholder: locale.search,
                    text: widget.keyword,
                    onTextChanged: (keyword) {
                      if (_searchDebounce?.isActive == true) {
                        _searchDebounce?.cancel();
                      }
                      _searchDebounce = Timer(
                        const Duration(
                          seconds: _LoadedBooks.searchDebounceTime,
                        ),
                        () => context
                            .read<BookListCubit>()
                            .load(keyword: keyword),
                      );
                    },
                    onTextSubmitted: (keyword) {
                      context.read<BookListCubit>().load(keyword: keyword);
                    },
                  ),
                ),
              ),
            ),
          ],
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // loading more indicator
                if (index >= widget.data.length) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(100, 16, 100, 16),
                    child: SizedBox(
                      height: 16,
                      child: LoadingComponent(
                        style: BaseLoadingStyle.linear,
                      ),
                    ),
                  );
                }

                final book = widget.data[index];
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
              childCount: widget.data.length + (widget.isLoadingMore ? 1 : 0),
            ),
          ),
        ],
      ),
    );
  }

  void _goToBookDetail(BuildContext context, Book book) {
    context.pushNamed(
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
                key: const Key(BookListView.retryButtonKey),
                style: BaseButtonStyle.outlineGreen,
                onPressed: () => context.read<BookListCubit>().load(),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
