import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';

/// A section
class Section extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Function()? handleOnSeeAll;

  const Section({
    required this.title,
    required this.children,
    this.handleOnSeeAll,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section title
        SectionTitle(
          title: title,
          handleOnSeeAll: handleOnSeeAll,
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
    Key? key,
    required this.title,
    this.handleOnSeeAll,
  }) : super(key: key);

  final String title;
  final Function()? handleOnSeeAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          // See more button
          InkWell(
            child: Text('See all', style: FONT_CONST.BOLD_PRIMARY),
            onTap: handleOnSeeAll,
          )
        ],
      ),
    );
  }
}
