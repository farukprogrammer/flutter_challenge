import 'package:flutter/widgets.dart';

/// An image options to:
/// * [diskCacheEnabled] Enable or disable disk cache
/// * [crossFadeEnabled] Enable or disable cross fade animation
/// * [placeholder] Image placeholder, must be an asset image source
/// * [size] Resize image dimension to specific target width x height
/// * [allowUpScaling] Enable or disable image upscaling (when resized size > original size)
/// * [onLoadFailed] Callback image fail loaded
/// * [onImageLoaded] Callback image loaded
class ImageOptions {
  final bool diskCacheEnabled;
  final bool crossFadeEnabled;
  final String? placeholder;
  final Size size;
  final bool allowUpScaling;
  final VoidCallback? onLoadFailed;
  final VoidCallback? onImageLoaded;

  const ImageOptions({
    this.diskCacheEnabled = true,
    this.crossFadeEnabled = false,
    this.placeholder,
    this.size = const Size(0, 0),
    this.allowUpScaling = false,
    this.onLoadFailed,
    this.onImageLoaded,
  });

  /// Whether the target image should be resized or keep the original dimension
  bool isResizedImage() {
    return size.width > 0 && size.height > 0;
  }
}