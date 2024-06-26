import 'package:base_mvvm/src/presentation/widgets/widget_shimmer.dart';
import 'package:base_mvvm/src/presentation/widgets/widget_shimmer_container.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

import '../../configs/configs.dart';
import '../../utils/utils.dart';

enum ImageNetworkShape { none, circle }

class WidgetImageNetwork extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final ImageNetworkShape? shape;
  final String? assetError;
  final BorderRadius? radius;
  final double? radiusAll;

  const WidgetImageNetwork(
      {Key? key,
        @required this.url,
        this.fit,
        this.radiusAll,
        this.height,
        this.width,
        this.radius,
        this.assetError,
        this.shape = ImageNetworkShape.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: radius ?? BorderRadius.all(Radius.circular(radiusAll ?? 0)),
        child: OctoImage(
          image: CachedNetworkImageProvider(AppUtils.pathMediaToUrl(url ?? '')),
          height: height,
          width: width,
          progressIndicatorBuilder: (context, progress) => WidgetShimmer(
            child: WidgetShimmerContainer(
                height: height,
                width: width,
                radius: radiusAll,
                borderRadius: radius ?? BorderRadius.all(Radius.circular(radiusAll ?? 0))),
          ),
          errorBuilder: (context, error, stackTrace) =>
              Image.asset(assetError ?? AppImages.imgError, fit: BoxFit.cover),
          fit: fit ?? BoxFit.cover,
        ));
  }
}
