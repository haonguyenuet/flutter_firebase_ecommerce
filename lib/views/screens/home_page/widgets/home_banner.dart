import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/widgets/others/shimmer_image.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  final List<BannerItem> banners;

  const HomeBanner({Key? key, required this.banners}) : super(key: key);
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List<BannerItem> get banners => widget.banners;
  // local states
  final aspectRatioBanner = 2 / 1;
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mDarkShadeColor,
      child: Stack(
        children: <Widget>[
          /// Banner images
          CarouselSlider(
            options: CarouselOptions(
              pageViewKey: PageStorageKey("home_banner"),
              aspectRatio: aspectRatioBanner,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.linearToEaseOut,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: banners.map((banner) {
              return ShimmerImage(
                aspectRatio: aspectRatioBanner,
                imageUrl: banner.imageUrl!,
                fit: BoxFit.contain,
              );
            }).toList(),
          ),

          /// Bottom Left Dots
          _buildIndicators(),
        ],
      ),
    );
  }

  _buildIndicators() {
    return Positioned(
      left: 28,
      bottom: 6,
      child: Row(
        children: [
          ...List.generate(banners.length, (index) {
            return _buildIndicatorNormal(index == currentIndex);
          })
        ],
      ),
    );
  }

  _buildIndicatorNormal(bool isSelected) {
    return AnimatedContainer(
      duration: mAnimationDuration,
      height: isSelected ? 6 : 5,
      width: isSelected ? 20 : 16,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.black26,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
