import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final double initialRating;
  final int itemCount;
  final double itemSize;
  final Color itemColor;
  final Color unratedColor;
  final bool readOnly;
  final Function(int)? onRatingUpdate;

  const RatingBar({
    Key? key,
    required this.initialRating,
    this.itemCount = 5,
    this.itemSize = 24,
    this.itemColor = Colors.amber,
    this.unratedColor = COLOR_CONST.textColor,
    this.onRatingUpdate,
    this.readOnly = false,
  }) : super(key: key);
  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  // local state
  double _currRating = 0;

  @override
  void initState() {
    super.initState();
    _currRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.itemCount,
        (index) {
          return GestureDetector(
              child: _buildStar(index + 1),
              onTap: widget.readOnly
                  ? null
                  : () {
                      setState(() => _currRating = index + 1);
                      widget.onRatingUpdate!(index + 1);
                    });
        },
      ),
    );
  }

  _buildStar(int index) {
    int currRatingCeil = _currRating.ceil();
    if (index == currRatingCeil && currRatingCeil - _currRating != 0) {
      return Icon(
        Icons.star_half,
        size: widget.itemSize,
        color: widget.itemColor,
      );
    }
    if (index > currRatingCeil) {
      return Icon(
        Icons.star,
        size: widget.itemSize,
        color: widget.unratedColor,
      );
    }
    return Icon(
      Icons.star,
      size: widget.itemSize,
      color: widget.itemColor,
    );
  }
}
