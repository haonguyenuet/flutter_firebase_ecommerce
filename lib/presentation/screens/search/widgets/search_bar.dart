import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/search/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController searchController;

  const SearchBar({Key? key, required this.searchController}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();

    widget.searchController.addListener(() {
      final keyword = widget.searchController.text;
      BlocProvider.of<SearchBloc>(context).add(KeywordChanged(keyword));
    });
  }

  void onClearSearchField() {
    if (widget.searchController.text.isNotEmpty) {
      widget.searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.defaultSize * 0.5,
        horizontal: SizeConfig.defaultSize,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: COLOR_CONST.cardShadowColor.withOpacity(0.2),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: COLOR_CONST.textColor),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: SearchFieldWidget(
              searchController: widget.searchController,
              hintText:
                  Translate.of(context).translate("search_by_product_name"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: onClearSearchField,
          ),
        ],
      ),
    );
  }
}
