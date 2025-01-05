import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../theming/colors.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final customCacheManager = CacheManager(Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 50,
    ));

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        cacheManager: customCacheManager,
        key: UniqueKey(),
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[700]!,
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: ColorsManager.black,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[700]!,
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: ColorsManager.black,
            ),
          ),
        ),
      ),
    );
  }
}
