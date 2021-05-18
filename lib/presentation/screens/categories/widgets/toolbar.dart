import 'package:e_commerce_app/data/models/models.dart';
import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:e_commerce_app/presentation/screens/categories/bloc/bloc.dart';
import 'package:e_commerce_app/presentation/screens/categories/widgets/sort_option_dialog.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolBarWidget extends StatefulWidget {
  final CategoryModel currCategoryModel;

  const ToolBarWidget({Key? key, required this.currCategoryModel})
      : super(key: key);

  @override
  _ToolBarWidgetState createState() => _ToolBarWidgetState();
}

class _ToolBarWidgetState extends State<ToolBarWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      final keyword = searchController.text;
      BlocProvider.of<CategoriesBloc>(context).add(SearchQueryChanged(keyword));
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listenWhen: (prevState, currState) => currState is OpenSortOption,
      listener: (context, state) {
        if (state is OpenSortOption && state.isOpen) {
          _openSortOptionsDialog(state);
        }
      },
      buildWhen: (prevState, currState) => currState is UpdateToolbarState,
      builder: (context, state) {
        if (state is UpdateToolbarState) {
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
                _buildLeading(),
                Expanded(child: _buildTitle(state)),
                _buildActions(state),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  _buildLeading() {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios, color: COLOR_CONST.textColor),
      onPressed: () => Navigator.pop(context),
    );
  }

  _buildActions(UpdateToolbarState state) {
    return Row(
      children: [
        // Search action
        IconButton(
          icon: Icon(
            state.showSearchField ? Icons.close : Icons.search,
            color: COLOR_CONST.textColor,
          ),
          onPressed: () {
            BlocProvider.of<CategoriesBloc>(context).add(
                state.showSearchField ? ClickCloseSearch() : ClickIconSearch());
          },
        ),
        // Sort action
        IconButton(
          icon: Icon(Icons.sort, color: COLOR_CONST.textColor),
          onPressed: () {
            BlocProvider.of<CategoriesBloc>(context).add(ClickIconSort());
          },
        ),
      ],
    );
  }

  _buildTitle(UpdateToolbarState state) {
    if (state.showSearchField) {
      searchController.clear();
      return SearchFieldWidget(
        searchController: searchController,
        autoFocus: false,
        hintText: Translate.of(context).translate('search'),
      );
    } else
      return Text(
        Translate.of(context).translate(widget.currCategoryModel.name),
        style: FONT_CONST.BOLD_DEFAULT_20,
      );
  }

  _openSortOptionsDialog(OpenSortOption state) async {
    var sortOption = await showDialog<ProductSortOption>(
      context: context,
      builder: (context) {
        return SortOptionDialog(currSortOption: state.currSortOption);
      },
    );
    if (sortOption != null) {
      BlocProvider.of<CategoriesBloc>(context)
          .add(SortOptionsChanged(sortOption));
    }
    BlocProvider.of<CategoriesBloc>(context).add(CloseSortOption());
  }
}
