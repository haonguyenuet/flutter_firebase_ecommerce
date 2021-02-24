import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key key,
    @required this.counter,
    @required this.svgIcon,
    this.onPressed,
  }) : super(key: key);

  final int counter;
  final String svgIcon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        buildIcon(),
        if (counter > 0) buildCounter(),
      ],
    );
  }

  IconButton buildIcon() {
    return IconButton(
      icon: SvgPicture.asset(svgIcon),
      onPressed: onPressed,
    );
  }

  Positioned buildCounter() {
    return Positioned(
      right: 2,
      top: 8,
      child: Container(
        alignment: Alignment.center,
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Center(
          child: Text(
            "${counter > 9 ? "9+" : counter}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
