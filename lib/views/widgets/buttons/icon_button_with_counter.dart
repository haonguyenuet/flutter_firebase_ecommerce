import 'package:flutter/material.dart';

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
  final IconData icon;
  final Function? onPressed;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      children: [
        _buildIcon(),
        if (counter > 0) _buildCounter(),
      ],
    );
  }

  _buildIcon() {
    return IconButton(
      icon: Icon(icon, size: size),
      onPressed: onPressed as void Function()?,
      color: color,
    );
  }

  _buildCounter() {
    return Positioned(
      right: 2,
      top: 5,
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
