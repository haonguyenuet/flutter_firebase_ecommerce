import 'package:equatable/equatable.dart';

abstract class LanguageState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialLanguageState extends LanguageState {}

class LanguageUpdating extends LanguageState {}

class LanguageUpdated extends LanguageState {}
