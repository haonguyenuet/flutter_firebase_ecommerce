import 'package:flutter/material.dart';
import '../../../constants.dart';

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
          alignment: Alignment.center,
          child: children.length == 0
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      children: children,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}

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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // See more button
          InkWell(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'See more',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1,
                    color: mPrimaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.arrow_forward,
                    color: mPrimaryColor,
                    size: 14,
                  ),
                ),
              ],
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}
