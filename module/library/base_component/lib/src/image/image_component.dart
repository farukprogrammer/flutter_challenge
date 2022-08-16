import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

import 'image_holder.dart';
import 'image_options.dart';

class ImageComponent extends StatelessWidget {
  final ImageProvider imageProvider;
  final ImageOptions? imageOptions;
  final AssetBundle? bundle;
  final ImageFrameBuilder? frameBuilder;
  final ImageErrorWidgetBuilder? errorBuilder;
  final ImageLoadingBuilder? loadingBuilder;
  final String? semanticLabel;
  final bool excludeFromSemantics;
  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;
  final bool isAntiAlias;

  @override
  Widget build(BuildContext context) {
    final imageProvider = this.imageProvider;

    var options = imageOptions;
    if (options != null) {
      var placeholder = options.placeholder;
      var duration = options.crossFadeEnabled
          ? const Duration(milliseconds: 200)
          : const Duration(milliseconds: 0);

      if (placeholder != null) {
        return FadeInImage(
          placeholder: AssetImage(placeholder),
          image: imageProvider,
          imageErrorBuilder: errorBuilder,
          imageSemanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          width: width,
          height: height,
          fit: fit,
          placeholderFit: fit,
          alignment: alignment,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
          fadeInDuration: duration,
          fadeOutDuration: duration,
        );
      }

      if (options.isResizedImage()) {
        return Image(
          image: imageProvider,
          frameBuilder: frameBuilder,
          errorBuilder: errorBuilder,
          loadingBuilder: loadingBuilder,
          semanticLabel: semanticLabel,
          excludeFromSemantics: excludeFromSemantics,
          width: width,
          height: height,
          color: color,
          opacity: opacity,
          colorBlendMode: colorBlendMode,
          fit: fit,
          alignment: alignment,
          repeat: repeat,
          centerSlice: centerSlice,
          matchTextDirection: matchTextDirection,
          gaplessPlayback: gaplessPlayback,
          filterQuality: filterQuality,
          isAntiAlias: isAntiAlias,
        );
      }
    }
    return Image(
      image: imageProvider,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
      isAntiAlias: isAntiAlias,
    );
  }

  /// Load image from local asset
  /// Does not support [ImageOptions]
  ImageComponent.asset(String source,
      {Key? key,
      this.bundle,
      this.frameBuilder,
      this.errorBuilder,
      this.loadingBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.width,
      this.height,
      this.color,
      this.opacity,
      this.colorBlendMode,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.filterQuality = FilterQuality.low,
      this.isAntiAlias = false})
      : imageProvider = AssetImage(source),
        imageOptions = null,
        super(key: key);

  /// Load image from string url
  ImageComponent.url(String url,
      {this.imageOptions = const ImageOptions(diskCacheEnabled: true),
      Key? key,
      this.bundle,
      this.frameBuilder,
      this.errorBuilder,
      this.loadingBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.width,
      this.height,
      this.color,
      this.opacity,
      this.colorBlendMode,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.filterQuality = FilterQuality.low,
      this.isAntiAlias = false})
      : imageProvider = NetworkImage(url),
        super(key: key);

  /// Load image from [NetworkImage]
  ImageComponent.network(NetworkImage networkImage,
      {this.imageOptions = const ImageOptions(diskCacheEnabled: true),
      Key? key,
      this.bundle,
      this.frameBuilder,
      this.errorBuilder,
      this.loadingBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.width,
      this.height,
      this.color,
      this.opacity,
      this.colorBlendMode,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.filterQuality = FilterQuality.low,
      this.isAntiAlias = false})
      : imageProvider = _getNetworkImageProvider(networkImage, imageOptions),
        super(key: key);

  /// Load image from [File]
  ImageComponent.file(File file,
      {this.imageOptions,
      Key? key,
      this.bundle,
      this.frameBuilder,
      this.errorBuilder,
      this.loadingBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.width,
      this.height,
      this.color,
      this.opacity,
      this.colorBlendMode,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.filterQuality = FilterQuality.low,
      this.isAntiAlias = false})
      : imageProvider = FileImage(file),
        super(key: key);

  /// Load image from [ImageHolder]
  /// * Does not support vector, use [IconAV] to display vector icon
  ImageComponent.imageHolder(ImageHolder imageHolder,
      {this.imageOptions,
      Key? key,
      this.bundle,
      this.frameBuilder,
      this.errorBuilder,
      this.loadingBuilder,
      this.semanticLabel,
      this.excludeFromSemantics = false,
      this.width,
      this.height,
      this.color,
      this.opacity,
      this.colorBlendMode,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat,
      this.centerSlice,
      this.matchTextDirection = false,
      this.gaplessPlayback = false,
      this.filterQuality = FilterQuality.low,
      this.isAntiAlias = false})
      : imageProvider = imageHolder.getImageProvider(),
        super(key: key);

  ImageComponent.memory(
    Uint8List uInt8list, {
    this.imageOptions,
    Key? key,
    this.bundle,
    this.frameBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    this.isAntiAlias = false,
  })  : imageProvider = MemoryImage(uInt8list),
        super(key: key);

  static ImageProvider _getNetworkImageProvider(
      NetworkImage networkImage, ImageOptions? imageOptions) {
    if (imageOptions == null) {
      return networkImage;
    }

    if (imageOptions.isResizedImage()) {
      if (imageOptions.diskCacheEnabled) {
        return ResizeImage(
            CachedNetworkImageProvider(networkImage.url,
                headers: networkImage.headers),
            width: imageOptions.size.width.toInt(),
            height: imageOptions.size.height.toInt(),
            allowUpscaling: imageOptions.allowUpScaling);
      }

      return ResizeImage(networkImage,
          width: imageOptions.size.width.toInt(),
          height: imageOptions.size.height.toInt(),
          allowUpscaling: imageOptions.allowUpScaling);
    }

    if (imageOptions.diskCacheEnabled) {
      return CachedNetworkImageProvider(networkImage.url,
          headers: networkImage.headers);
    }
    return networkImage;
  }
}
