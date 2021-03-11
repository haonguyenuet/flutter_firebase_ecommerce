import 'package:e_commerce_app/configs/size_config.dart';
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
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
      padding: EdgeInsets.only(
        left: SizeConfig.defaultSize * 2,
        right: SizeConfig.defaultSize * 2,
        bottom: SizeConfig.defaultSize * 0.5,
        top: SizeConfig.defaultSize * 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: FONT_CONST.BOLD_DEFAULT_18,
          ),
          // See more button
          InkWell(
            child: Text('See all', style: FONT_CONST.BOLD_PRIMARY_16),
            onTap: handleOnSeeAll,
          )
        ],
      ),
    );
  }
}
