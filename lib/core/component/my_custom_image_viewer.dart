import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'my_custom_shimmer.dart';

class CustomImageViewer {
  CustomImageViewer._();

  static show(
      {required BuildContext context,
        required String url,
        BoxFit? fit,
        double? radius=20}) {
    return CachedNetworkImage(
        imageUrl: url,
        fit: fit ?? BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(
              radius ?? 8,
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Center(child: MyShimmer(context: context,shimmerBorderRadius: radius),),
        errorWidget: (context, url, error) => Center(child: MyShimmer(context: context,shimmerBorderRadius: radius),),);
  }
}
