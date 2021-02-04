import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final double size;
  final Function handleOnPress;
  final Icon icon;
  final Color color;

  const CircleIconButton({
    Key key,
    @required this.size,
    @required this.icon,
    @required this.color,
    this.handleOnPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.05, 0.2),
            color: Colors.black,
            spreadRadius: 0.06,
          )
        ],
      ),
      child: IconButton(
        onPressed: handleOnPress,
        icon: icon,
      ),
    );
  }
}
