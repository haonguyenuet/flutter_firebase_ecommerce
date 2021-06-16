import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/router.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductInfoWidget extends StatefulWidget {
  const ProductInfoWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductInfoWidgetState createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<ProductInfoWidget> {
  Product get product => widget.product;
  // local states
  bool seeMore = false;

  void onSeeMore() => setState(() => seeMore = !seeMore);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.defaultPadding),
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize * 2),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          SizedBox(height: SizeConfig.defaultSize * 0.5),
          _buildPrice(),
          SizedBox(height: SizeConfig.defaultSize * 2),
          Row(
            children: [
              SizedBox(width: SizeConfig.defaultPadding),
              _buildSoldQuantity(),
              SizedBox(width: SizeConfig.defaultSize),
              Container(height: 15, width: 2, color: Colors.black12),
              SizedBox(width: SizeConfig.defaultSize),
              _buildRating(context),
              Spacer(),
              _buildIsAvailable(),
            ],
          ),
          SizedBox(height: SizeConfig.defaultSize * 2),
          _buildDescription(),
        ],
      ),
    );
  }

  _buildProductName() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: Text(product.name, style: FONT_CONST.BOLD_DEFAULT_24),
    );
  }

  _buildPrice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${product.price.toPrice()}",
            style: FONT_CONST.BOLD_PRIMARY_24,
          ),
          if (product.percentOff > 0)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "${product.originalPrice.toPrice()}",
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ),
            ),
        ],
      ),
    );
  }

  _buildSoldQuantity() {
    return Text.rich(
      TextSpan(
        style: FONT_CONST.BOLD_DEFAULT,
        children: [
          TextSpan(
            text: Translate.of(context).translate('sold'),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          TextSpan(
            text: " ${product.soldQuantity}",
            style: FONT_CONST.BOLD_PRIMARY_18,
          ),
        ],
      ),
    );
  }

  _buildRating(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRouter.FEEDBACK,
          arguments: product,
        );
      },
      child: Row(
        children: [
          Text("${product.rating}", style: FONT_CONST.BOLD_DEFAULT_18),
          SizedBox(width: 5),
          SvgPicture.asset(
            "assets/icons/Star Icon.svg",
            width: SizeConfig.defaultSize * 1.8,
            height: SizeConfig.defaultSize * 1.8,
          ),
        ],
      ),
    );
  }

  _buildIsAvailable() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding,
          vertical: SizeConfig.defaultSize,
        ),
        alignment: Alignment.center,
        height: SizeConfig.defaultSize * 5,
        decoration: BoxDecoration(
          color: product.isAvailable ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConfig.defaultSize * 2.5),
            bottomLeft: Radius.circular(SizeConfig.defaultSize * 2.5),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/Check mark rounde.svg",
              color:
                  product.isAvailable ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
              width: SizeConfig.defaultSize * 3,
              height: SizeConfig.defaultSize * 3,
            ),
            SizedBox(width: 5),
            Text(
              "${product.isAvailable ? Translate.of(context).translate('available') : Translate.of(context).translate('not_available')}",
              style: FONT_CONST.REGULAR_DEFAULT_18,
            ),
          ],
        ),
      ),
    );
  }

  _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.description,
            style: FONT_CONST.REGULAR_DEFAULT_18,
            maxLines: seeMore ? null : 2,
          ),
          SizedBox(height: 5),

          // See more button
          GestureDetector(
            onTap: onSeeMore,
            child: Text(
              "${seeMore ? Translate.of(context).translate('see_less') : Translate.of(context).translate('see_more')}",
              style: FONT_CONST.BOLD_PRIMARY_18,
            ),
          ),
        ],
      ),
    );
  }
}
