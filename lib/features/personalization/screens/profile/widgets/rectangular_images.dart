import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/shimmer.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class SRectangularImage extends StatelessWidget {
  const SRectangularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = SSizes.sm,
    this.isNetworkImage = false,
    this.scaleFactor = 1.5,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding, scaleFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (SHelperFunctions.isDarkMode(context)
                ? SColors.black
                : SColors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Center(
          child: isNetworkImage
              ? Transform.scale(
                  scale: scaleFactor,
                  child: CachedNetworkImage(
                    fit: fit,
                    color: overlayColor,
                    imageUrl: image,
                    progressIndicatorBuilder: (context, url,
                            downloadProgress) =>
                        const SShimmerEffect(width: 55, height: 55, radius: 55),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                )
              : Transform.scale(
                  scale: scaleFactor,
                  child: Image(
                    fit: fit,
                    image: AssetImage(image),
                    color: overlayColor,
                  ),
                ),
        ),
      ),
    );
  }
}
