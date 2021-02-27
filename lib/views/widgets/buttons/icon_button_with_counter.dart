import 'package:e_commerce_app/views/widgets/buttons/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconButtonWithCounter extends StatelessWidget {
  const IconButtonWithCounter({
    Key key,
    @required this.counter,
    @required this.svgIcon,
    this.size,
    this.onPressed,
  }) : super(key: key);

  final int counter;
  final String svgIcon;
  final Function onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        _buildIcon(),
        if (counter > 0) _buildCounter(),
      ],
    );
  }

  _buildIcon() {
    return CircleIconButton(size: 20, onPressed: onPressed, svgIcon: svgIcon);
  }

  _buildCounter() {
    return Positioned(
      right: -4,
      top: -2,
      child: Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
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
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
