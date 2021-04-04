import 'package:e_commerce_app/business_logic/common_blocs/language/bloc.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:e_commerce_app/presentation/widgets/custom_widgets.dart';
import 'package:e_commerce_app/utils/language.dart';
import 'package:e_commerce_app/utils/dialog.dart';
import 'package:e_commerce_app/utils/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late Locale _selectedLanguage;
  List<Locale> supportLanguage = AppLanguage.supportLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate("settings")),
      ),
      body: SafeArea(
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 1.5),
          children: [
            CustomListTile(
              title: Translate.of(context).translate("language"),
              leading: Icon(Icons.language, color: COLOR_CONST.primaryColor),
              trailing: Text(
                Translate.of(context).translate(UtilLanguage.getLanguageName(
                    AppLanguage.defaultLanguage.languageCode)),
              ),
              onPressed: () => _showLanguageSetting(),
            ),
            CustomListTile(
              title: Translate.of(context).translate("theme"),
              leading: Icon(Icons.color_lens, color: COLOR_CONST.primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSetting() async {
    setState(() {
      _selectedLanguage = AppLanguage.defaultLanguage;
    });
    final response = await UtilDialog.showConfirmation(
      context,
      title: Translate.of(context).translate("language_setting"),
      content: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(supportLanguage.length, (index) {
                final language = supportLanguage[index];
                return CheckboxListTile(
                  title: Text(
                    Translate.of(context).translate(
                        UtilLanguage.getLanguageName(language.languageCode)),
                  ),
                  value: language == _selectedLanguage,
                  onChanged: (value) {
                    setState(() => _selectedLanguage = language);
                  },
                );
              }),
            ),
          );
        },
      ),
      confirmButtonText: Translate.of(context).translate("select"),
    ) as bool;

    if (response) {
      BlocProvider.of<LanguageBloc>(context)
          .add(LanguageChanged(_selectedLanguage));
    }
  }
}
