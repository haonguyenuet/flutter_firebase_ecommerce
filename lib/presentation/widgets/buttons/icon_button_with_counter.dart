import 'package:e_commerce_app/configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key? key,
    required this.counter,
    required this.icon,
    this.size,
    this.onPressed,
    this.color,
  }) : super(key: key);

  final int counter;
  final String icon;
  final Function()? onPressed;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        _buildIcon(),
        if (counter > 0) _buildCounter(),
      ],
    );
  }

  _buildIcon() {
    return InkWell(
      child: SvgPicture.asset(
        icon,
        width: size,
        height: size,
        color: color,
      ),
      onTap: onPressed,
    );
  }

  _buildCounter() {
    return Positioned(
      right: -5,
      top: -3,
      child: Container(
        alignment: Alignment.center,
        width: SizeConfig.defaultSize * 2,
        height: SizeConfig.defaultSize * 2,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Center(
          child: Text(
            "${counter > 9 ? "9+" : counter}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.defaultSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
