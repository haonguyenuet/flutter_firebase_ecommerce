import 'package:flutter/material.dart';

class StarButton extends StatelessWidget {
  const StarButton({
    Key key,
    @required this.numberOfStars,
    this.handleOnTap,
    this.isActive = false,
  }) : super(key: key);

  final int numberOfStars;
  final Function() handleOnTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              "$numberOfStars",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.star,
              color: isActive ? Colors.amber : Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
