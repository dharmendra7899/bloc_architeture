import 'package:cached_network_image/cached_network_image.dart';
import 'package:counter_demo_bloc/res/constants/assets/const_images.dart';
import 'package:flutter/material.dart';

class ImageLock extends StatelessWidget {
  final String? imageUrl;
  final Color? borderColor, color;
  final double? width, height, radius;
  final BoxFit? fit;
  final bool isLocked;

  const ImageLock({
    super.key,
    this.imageUrl,
    this.width,
    this.isLocked = false,
    this.height,
    this.fit,
    this.radius,
    this.borderColor,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isLocked || imageUrl == null || imageUrl?.isEmpty == true) {
      return Image.asset(
        ConstantImage.appLogo,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
    }

    try {
      return CachedNetworkImage(
        key: ValueKey(imageUrl ?? ""),
        repeat: ImageRepeat.noRepeat,
        color: color ?? Colors.transparent,
        imageUrl: imageUrl!,
        placeholder: (context, url) {
          return Center(
            child: CircularProgressIndicator.adaptive(strokeWidth: 2),
          );
        },
        imageBuilder: (context, imageProvider) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              border: Border.all(color: borderColor ?? Colors.transparent),
              color: color ?? Colors.transparent,
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              border: Border.all(color: borderColor ?? Colors.transparent),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
              child: Image.asset(
                ConstantImage.appLogo,
                fit: BoxFit.contain,
                height: height,
                width: width,
              ),
            ),
          );
        },
      );
    } catch (e) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
          child: Image.asset(
            ConstantImage.appLogo,
            fit: BoxFit.contain,
            height: height,
            width: width,
          ),
        ),
      );
    }
  }
}
