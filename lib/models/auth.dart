import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  String email;
  String password;

  Auth({
    this.email,
    this.password,
  });

  void createEmail(String typedEmail) {
    email = typedEmail;
    notifyListeners();
  }

  void createPassword(String typedPassword) {
    password = typedPassword;
    notifyListeners();
  }
}
