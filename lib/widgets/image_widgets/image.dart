// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/error/i_error_logger.dart';
import 'package:dappstore/core/network/network.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ImageWidget extends StatefulWidget {
  /// A default Image Widget wrapper that can be used anywhere in tha app
  /// [image] is required
  final String image;
  final Color? color;
  final double? width;
  final double? height;
  final double? placeholderWidth;
  final double? placeholderHeight;
  final BoxFit? fit;
  final double? scale;
  final Alignment? alignment;
  final bool enableNetworkCache;
  final PlaceholderType? placeholderType;
  final bool renderSvg;
  final String? renderPlaceHolderText;
  final bool keepAlive;
  final Function(BuildContext, String, DownloadProgress)?
      progressIndicatorBuilder;

  const ImageWidget(this.image,
      {super.key,
      this.color,
      this.width,
      this.height,
      this.placeholderWidth,
      this.placeholderHeight,
      this.fit = BoxFit.contain,
      this.scale = 1,
      this.alignment = Alignment.center,
      this.enableNetworkCache = true,
      this.placeholderType,
      this.renderSvg = true,
      this.renderPlaceHolderText,
      this.progressIndicatorBuilder,
      this.keepAlive = false});

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget>
    with AutomaticKeepAliveClientMixin {
  late bool _isLoading;
  late bool _hasError;
  late bool _isNetworkPath;

  late ImageType _imageType;
  late String _imagePath;

  late Uint8List? _imageBytes;
  late String? _svgString;

  @override
  void initState() {
    _isLoading = true;
    _hasError = false;

    _imagePath = widget.image;

    _isNetworkPath = widget.image.startsWith(
        RegExp(r'(https:)|(http:)|(www.)', caseSensitive: false), 0);

    if (widget.image.split('.').last.split('?')[0].split('#')[0] == 'svg') {
      _imageType = ImageType.SVG;
    }

    if (_isNetworkPath) {
      if (!widget.image.startsWith("http")) {
        if (widget.image.startsWith("//")) {
          _imagePath = "https:${widget.image}";
        } else {
          _imagePath = "https://${widget.image}";
        }
      }

      Network(dioClient: Dio(), interceptors: [
        DioCacheInterceptor(
            options: CacheOptions(
          store: MemCacheStore(maxSize: 200000000, maxEntrySize: 7340032),
          policy: CachePolicy.request,
          hitCacheOnErrorExcept: [401, 403],
          maxStale: const Duration(days: 7),
          priority: CachePriority.normal,
          cipher: null,
          keyBuilder: CacheOptions.defaultCacheKeyBuilder,
          allowPostMethod: false,
        ))
      ])
          .get(
        // cacheOptions: CacheOptions(store: MemCacheStore()),
        options: Options(responseType: ResponseType.bytes),
        path: _imagePath,
      )
          .then((response) {
        final contentType = response.headers.map['content-type']?[0];

        if (mounted) {
          setState(() {
            if (contentType == null) {
              _imageType = ImageType.UNSUPPORTED;
            } else {
              _imageType = fromMimeType(contentType);
            }
            if (_imageType == ImageType.IMAGE) {
              _imageBytes = response.data;
            } else {
              _svgString =
                  'data:image/svg+xml;base64,${base64Encode(response.data)}';
            }
            _isLoading = false;
            _hasError = false;
          });
        }
      }).catchError((e) {
        debugPrint('[Media View] Error: $_imagePath $e');

        getIt<IErrorLogger>()
            .logError(e, StackTrace.fromString("image_widget.dart"));

        if (mounted) {
          setState(() {
            _imageType = ImageType.UNSUPPORTED;
            _imageBytes = null;
            _svgString = null;
            _isLoading = false;
            _hasError = true;
          });
        }
      });
    } else {
      debugPrint('LOCAL IMG: ${widget.image}');
      const base64Suffix = '[a-zA-Z0-9,+,/]+={0,2}';

      const base64SvgPrefix = 'data:image/[svg,svg+xml]+;base64,';
      final base64SvgMatch = RegExp('$base64SvgPrefix$base64Suffix');

      const base64ImagePrefix =
          'data:image/[bmp,gif,jpg,png,jpeg,webp]+;base64,';
      final base64ImageMatch = RegExp('$base64ImagePrefix$base64Suffix');

      if (base64SvgMatch.hasMatch(_imagePath) ||
          base64ImageMatch.hasMatch(_imagePath)) {
        _imageType = ImageType.SVG;
        if (mounted) {
          setState(() {
            _svgString = _imagePath;
            _isLoading = false;
            _hasError = false;
          });
        }
        return;
      } else {
        _imageType = ImageType.UNSUPPORTED;
        if (mounted) {
          setState(() {
            _svgString = null;
            _isLoading = false;
            _hasError = true;
          });
        }
      }
    }
    super.initState();
  }

  Widget _getPlaceHolder(PlaceholderType? placeHolderType) {
    return Container();
    // switch (placeHolderType) {
    //   case PlaceholderType.tokenIcon:
    //     return TokenIconPlaceholder();
    //   case PlaceholderType.walletIcon:
    //     return WalletIconPlaceholder();
    //   case PlaceholderType.walletConnect:
    //     return WalletConnectPlaceholder();
    //   case PlaceholderType.imageNotFound:
    //     return ImageNotFoundPlaceholder();
    //   case PlaceholderType.nftItem:
    //     return NftItemPlaceholder();
    //   case PlaceholderType.nftItemSymbol:
    //     return NftItemSymbolPlaceholder(
    //       fit: widget.fit,
    //       text: widget.renderPlaceHolderText,
    //     );
    //   default:
    //     return Placeholder();
    // }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget? imageWidget;

    if (_isLoading) {
      imageWidget = const LoadingIndicator();
    } else if (_hasError) {
      imageWidget = _getPlaceHolder(widget.placeholderType);
    } else {
      switch (_imageType) {
        case ImageType.SVG:
          imageWidget = widget.renderSvg
              ? ScalableImageWidget.fromSISource(
                  si: ScalableImageSource.fromSvgHttpUrl(
                    Uri.parse(_svgString!),
                  ),
                  onLoading: (context) => widget.progressIndicatorBuilder !=
                          null
                      ? widget.progressIndicatorBuilder!.call(
                          context, "", DownloadProgress(_svgString!, 100, 100))
                      : const LoadingIndicator(),
                  onError: (_) => _getPlaceHolder(widget.placeholderType),
                  fit: widget.fit ?? BoxFit.contain,
                  alignment: widget.alignment ?? Alignment.center,
                )
              : _getPlaceHolder(PlaceholderType.nftItem);
          break;
        case ImageType.IMAGE:
          // var image;
          // if ((widget.width != null && widget.height != null) ||
          //     (!widget.width!.isNaN &&
          //         !widget.width!.isInfinite &&
          //         !widget.height!.isNaN &&
          //         !widget.height!.isInfinite)) {
          //   image = ResizeImage(
          //     MemoryImage(_imageBytes!),
          //     width: widget.width?.floor(),
          //     height: widget.height?.floor(),
          //   );
          // } else {
          // image = MemoryImage(_imageBytes!);
          // }
          imageWidget = Image.memory(
            _imageBytes!,
            alignment: widget.alignment ?? Alignment.center,
            fit: widget.fit ?? BoxFit.contain,
          );
          break;
        case ImageType.UNSUPPORTED:
        default:
          imageWidget = _getPlaceHolder(widget.placeholderType);
          break;
      }
    }

    return SizedBox(
      height: _isLoading || _hasError
          ? (widget.placeholderHeight ?? widget.height)
          : widget.height,
      width: _isLoading || _hasError
          ? (widget.placeholderWidth ?? widget.width)
          : widget.width,
      child: imageWidget,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

class ImageWidgetCached extends StatelessWidget {
  final String image;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment? alignment;

  const ImageWidgetCached(
    this.image, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      // keepAlive: true,
      key: ValueKey(image),
      height: height,
      width: width, fit: fit, alignment: alignment ?? Alignment.center,
      color: color,
      placeholder: ((context, url) => const LoadingIndicator()),
      errorWidget: (context, url, error) => const LoadingIndicator(),
      // enableNetworkCache: true,
      // placeholderType: PlaceholderType.nftItemSymbol,
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(milliseconds: 1500), //Default value
      color: Colors.white, //Default value
      colorOpacity: 0.47, //Default value
      enabled: true, //Default value
      direction: const ShimmerDirection.fromLTRB(), //Default Value
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

enum PlaceholderType {
  tokenIcon,
  nftItem,
  nftItemSymbol,
  walletIcon,
  walletConnect,
  imageNotFound
}

enum ImageType { SVG, IMAGE, UNSUPPORTED }

ImageType fromMimeType(String type) {
  if (type.contains('image/svg+xml') || type.contains('text/plain')) {
    return ImageType.SVG;
  } else if (type.contains('image/png') ||
      type.contains('image/jpg') ||
      type.contains('image/jpeg') ||
      type.contains('image/gif') ||
      type.contains('image/bmp') ||
      type.contains('image/webp') ||
      type.contains('application/octet-stream')) {
    return ImageType.IMAGE;
  } else {
    return ImageType.UNSUPPORTED;
  }
}
