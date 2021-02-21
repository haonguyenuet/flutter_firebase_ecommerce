import '../constants.dart';

/// Validate email
String validateEmail(String email) {
  // Null or empty email is invalid
  if (email == null || email.isEmpty) {
    return mEmailNullError;
  }

  const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(email)) {
    return mInvalidEmailError;
  }
  return null;
}

/// Validate password
String validatePassword(String password) {
  // Null or empty email is invalid
  if (password == null || password.isEmpty) {
    return mPassNullError;
  }
  // String pattern =
  //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  // RegExp regExp = new RegExp(pattern);
  // if (!regExp.hasMatch(password)) {
  //   return mShortPassError;
  // }
  if (password.length < 6) {
    return mShortPassError;
  }
  return null;
}

/// Validate password
String validateConfirmedPassword(String password, String confirmedPassword) {
  // Null or empty email is invalid
  if (password != confirmedPassword) {
    return mMatchPassError;
  }
  return null;
}
