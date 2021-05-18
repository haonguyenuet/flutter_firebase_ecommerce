import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/presentation/widgets/others/shimmer_image.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatefulWidget {
  final List<BannerModel> banners;

  const HomeBanner({Key? key, required this.banners}) : super(key: key);
  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List<BannerModel> get banners => widget.banners;
  final double aspectRatioBanner = 2 / 1;
  // local states

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 1.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSlider(),
          SizedBox(height: SizeConfig.defaultSize),
          _buildIndicators(),
        ],
      ),
    );
  }

  _buildSlider() {
    return CarouselSlider(
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
          setState(() => currentIndex = index);
        },
      ),
      items: banners.map((banner) {
        return ShimmerImage(
          aspectRatio: aspectRatioBanner,
          imageUrl: banner.imageUrl,
          borderRadius: BorderRadius.circular(10),
          fit: BoxFit.contain,
        );
      }).toList(),
    );
  }

  _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(banners.length, (index) {
          return _buildIndicatorNormal(index == currentIndex);
        })
      ],
    );
  }

  _buildIndicatorNormal(bool isSelected) {
    return AnimatedContainer(
      duration: mAnimationDuration,
      height: SizeConfig.defaultSize,
      width: SizeConfig.defaultSize,
      margin: EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: isSelected ? COLOR_CONST.primaryColor : Colors.black12,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
