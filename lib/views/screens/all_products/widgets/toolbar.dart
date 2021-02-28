import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolBar extends StatefulWidget {
  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  TextEditingController _searchController = TextEditingController();
  // Local states
  bool _showSearchField = true;

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      final keyword = _searchController.text;
      if (keyword.isNotEmpty) {
        BlocProvider.of<AllProductsBloc>(context)
            .add(SearchQueryChanged(keyword: keyword));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: mDarkShadeColor,
      child: Row(
        children: <Widget>[
          _buildLeading(context),
          Expanded(child: _buildTitle()),
          _buildActions(context),
        ],
      ),
    );
  }

  _buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: mAccentTintColor),
      onPressed: () => Navigator.pop(context),
    );
  }

  _buildActions(BuildContext context) {
    return Row(
      children: [
        // Search action
        IconButton(
          icon: Icon(
            _showSearchField ? Icons.close : Icons.search,
            color: mAccentTintColor,
          ),
          onPressed: () {
            setState(() {
              _showSearchField = !_showSearchField;
            });
            if (_showSearchField == false) {
              BlocProvider.of<AllProductsBloc>(context)
                  .add(SearchQueryChanged(keyword: ""));
            }
          },
        ),
        // Sort action
        IconButton(
          icon: Icon(Icons.sort, color: mAccentTintColor),
          onPressed: () {},
        ),
      ],
    );
  }

  _buildTitle() {
    if (_showSearchField) {
      _searchController.text = "";
      return Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.only(top: 3),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      );
    } else
      return Text(
        'All Products',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      );
  }
}
