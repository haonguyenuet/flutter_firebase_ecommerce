import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/style_constant.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_bloc.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_event.dart';
import 'package:e_commerce_app/views/screens/all_products/bloc/all_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolBar extends StatefulWidget {
  @override
  _ToolBarState createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  TextEditingController _searchController = TextEditingController();
  BuildContext _blocContext;
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
    return BlocBuilder<AllProductsBloc, AllProductsState>(
      buildWhen: (prevState, currState) {
        return currState is UpdateToolbarState;
      },
      builder: (context, state) {
        _blocContext = context;
        if (state is UpdateToolbarState) {
          return Container(
            color: mPrimaryColor,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(child: _buildTitle(state)),
                _buildActions(state),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _buildActions(UpdateToolbarState state) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            state.showSearchField ? Icons.close : Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            BlocProvider.of<AllProductsBloc>(_blocContext).add(
              state.showSearchField ? ClickCloseSearch() : ClickIconSearch(),
            );
          },
        ),
        IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onPressed: () {}),
      ],
    );
  }

  _buildTitle(UpdateToolbarState state) {
    if (state.showSearchField) {
      _searchController.text = "";
      return TextField(
        controller: _searchController,
        keyboardType: TextInputType.text,
        autofocus: true,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
      );
    } else
      return Text('All Products', style: mPrimaryFontStyle);
  }
}
