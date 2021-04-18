import 'package:e_commerce_app/data/local/pref.dart';
import 'package:e_commerce_app/configs/config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(InitialLanguageState());

  @override
  Stream<LanguageState> mapEventToState(event) async* {
    if (event is LanguageChanged) {
      if (event.locale == AppLanguage.defaultLanguage) {
        yield LanguageUpdated();
      } else {
        yield LanguageUpdating();
        AppLanguage.defaultLanguage = event.locale;
        await LocalPref.setString("language", event.locale.languageCode);
        yield LanguageUpdated();
      }
    }
  }
}
