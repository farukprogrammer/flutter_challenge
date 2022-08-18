import 'dart:io';

import 'package:base_component/base_component.dart';
import 'package:collection/collection.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:result_util/result_util.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui_book/src/component/book_detail_component.dart';
import 'package:url_launcher/url_launcher.dart';

import '../component/book_detail_loading_component.dart';
import '../cubit/detail_cubit.dart';
import '../locale/book_locale.dart';
import '../state/detail_state.dart';

class DetailView extends StatefulWidget {
  static const loadingStateKey = 'detail-key-loading';
  static const loadedStateKey = 'detail-key-loaded';
  static const errorStateKey = 'detail-key-error';
  static const retryButtonKey = 'detail-key-retry-button';

  final int bookId;

  const DetailView({
    Key? key,
    required this.bookId,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late DownloaderUtils options;
  late DownloaderCore core;

  late final String path;

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<DetailCubit>();
      if (cubit.state.apiResult.value == null) {
        cubit.load();
      }
    });
  }

  Future<void> _initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    Directory docPath = await getApplicationDocumentsDirectory();
    String localPath = '${docPath.path}${Platform.pathSeparator}Download';

    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    path = localPath;
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
                key: const Key(DetailView.loadedStateKey),
                book: bookData,
                progressDownload: state.progressDownload,
                onTapAuthor: () => _goToSearchPage(
                  context,
                  bookId: '${bookData.id}',
                  field: locale.author,
                  keyword: bookData.authors.firstOrNull?.name ?? '',
                ),
                onTapTitle: () => _goToSearchPage(
                  context,
                  bookId: '${bookData.id}',
                  field: locale.title,
                  keyword: bookData.title,
                ),
                onTapDownload: () {
                  // if already downloading, do nothing
                  if (state.progressDownload > 0 &&
                      state.progressDownload < 1) {
                    return;
                  } else if (state.progressDownload == 1) {
                    _openFile(bookId: '${bookData.id}');
                    return;
                  }
                  _startDownload(
                    context,
                    bookId: '${bookData.id}',
                    downloadUrl: bookData.formats.zip,
                  );
                },
                onTapReadHere: () => _launchUrl(
                  context,
                  url: bookData.formats.textHtml,
                ),
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

  void _goToSearchPage(
    BuildContext context, {
    required String bookId,
    required String field,
    required String keyword,
  }) {
    context.pushNamed(
      'search_result',
      params: {'id': bookId},
      queryParams: {
        'field': field,
        'keyword': keyword,
      },
    );
  }

  void _launchUrl(
    BuildContext context, {
    String? url,
  }) async {
    if (url == null) {
      Snackbar.showError(context, 'text/html link not supported');
      return;
    }
    await launchUrl(Uri.parse(url));
  }

  void _startDownload(
    BuildContext context, {
    required String bookId,
    String? downloadUrl,
  }) async {
    if (downloadUrl == null) {
      Snackbar.showError(context, 'zip link not supported');
      return;
    }
    final cubit = context.read<DetailCubit>();

    options = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total);
        cubit.setProgressDownload(progress);
      },
      file: File('$path/$bookId.zip'),
      progress: ProgressImplementation(),
      onDone: () {
        Snackbar.showNeutral(context, 'Download Finished!');
        _openFile(bookId: bookId);
      },
      deleteOnCancel: true,
    );
    core = await Flowder.download(
      downloadUrl,
      options,
    );
  }

  void _openFile({required String bookId}) async {
    OpenFile.open('$path/$bookId.zip').then((result) {
      if (result.type != ResultType.done) {
        Snackbar.showNeutral(context, result.message);
      }
    });
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
