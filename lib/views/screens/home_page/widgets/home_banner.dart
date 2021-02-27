import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/business_logic/entities/banner.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/widgets/others/shimmer_image.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  final List<BannerItem> banners;

  const HomeBanner({Key key, @required this.banners}) : super(key: key);
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List<BannerItem> get banners => widget.banners;
  // local states
  final aspectRatioBanner = 16 / 9;
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        /// Banner images
        CarouselSlider(
          options: CarouselOptions(
            pageViewKey: PageStorageKey("home_banner"),
            height: getProportionateScreenHeight(200),
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
              width: SizeConfig.screenWidth,
              imageUrl: banner.imageUrl,
            );
          }).toList(),
        ),

        /// Bottom Left Dots
        _buildIndicators(),
      ],
    );
  }

  _buildIndicators() {
    return Positioned(
      left: 12,
      right: 0,
      bottom: 12,
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
      height: isSelected ? 7 : 6,
      width: isSelected ? 20 : 16,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? mPrimaryColor : Colors.black12,
        border: Border.all(color: Colors.white, width: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
