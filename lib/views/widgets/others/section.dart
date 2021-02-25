import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';

/// A section
class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Function handleOnTap;

  const Section({
    this.title,
    this.children,
    this.handleOnTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section title
        SectionTitle(
          title: title,
          handleOnTap: handleOnTap,
        ),

        /// Section content
        Container(
          child: children.length == 0
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: children,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

/// Section title
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    this.title,
    this.handleOnTap,
  }) : super(key: key);

  final String title;
  final Function handleOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // See more button
          InkWell(
            child: Text(
              'See all',
              style: TextStyle(
                fontSize: 14,
                height: 1,
                color: mPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: handleOnTap,
          )
        ],
      ),
    );
  }
}
