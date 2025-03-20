import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


Widget MyShimmer(
    {required BuildContext context,
      EdgeInsets marginEdgeInsets = EdgeInsets.zero,
      double? shimmerBorderRadius=20}){
  return Shimmer.fromColors(
    highlightColor: Theme.of(context).colorScheme.background.withOpacity(0.20),
    baseColor: Colors.grey.shade300,
    child: Container(
      height: double.infinity,
      width: double.infinity,
      margin: marginEdgeInsets,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(shimmerBorderRadius!),
      ),
    ),
  );
}
