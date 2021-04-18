import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LanguageEvent extends Equatable {}

class LanguageChanged extends LanguageEvent {
  final Locale locale;

  LanguageChanged(this.locale);

  @override
  List<Object> get props => [this.locale];
}
