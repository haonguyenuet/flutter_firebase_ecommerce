import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  // Call super.pure to represent an unmodified form input.
  const Password.pure() : super.pure('');
  // Call super.dirty to represent a modified form input.
  const Password.dirty({String value = ''}) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  // Override validator to handle validating a given input value.
  @override
  PasswordValidationError validator(String value) {
    return value.length >= 6 ? null : PasswordValidationError.invalid;
  }
}
