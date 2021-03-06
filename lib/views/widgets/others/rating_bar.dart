import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final int initialRating;
  final int itemCount;
  final double itemSize;
  final Function(int)? onRatingUpdate;

  const RatingBar({
    Key? key,
    required this.initialRating,
    this.itemCount = 5,
    this.itemSize = 20,
    this.onRatingUpdate,
  }) : super(key: key);
  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  // local state
  int? _currRating;

  @override
  void initState() {
    super.initState();

    _currRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.itemCount,
        (index) {
          return GestureDetector(
            child: _buildStar(),
            onTap: () {
              setState(() => _currRating = index + 1);
              widget.onRatingUpdate!(index + 1);
            },
          );
        },
      ),
    );
  }

  _buildStar() {
    
  }
}
