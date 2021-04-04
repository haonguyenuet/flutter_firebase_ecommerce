import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BorderRadius? borderRadius;
  final double iconHolderSize;
  ShimmerImage({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.aspectRatio,
    this.iconHolderSize = 50,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: Stack(
        children: [
          /// Holder image
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: this.aspectRatio != null
                ? AspectRatio(
                    aspectRatio: aspectRatio!,
                    child: _buildHolder(),
                  )
                : SizedBox(
                    width: width,
                    height: height,
                    child: _buildHolder(),
                  ),
          ),

          /// Image
          this.aspectRatio != null
              ? AspectRatio(
                  aspectRatio: aspectRatio!,
                  child: Image.network(imageUrl, fit: fit ?? BoxFit.contain),
                )
              : Image.network(imageUrl,
                  width: width, height: height, fit: fit ?? BoxFit.contain),
        ],
      ),
    );
  }

  Widget _buildHolder() {
    return Container(
      color: Colors.grey[200],
    );
  }
}
