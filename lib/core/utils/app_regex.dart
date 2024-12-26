class AppRegex {
  static bool isUsernameValid(String username) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username);
  }

  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
        .hasMatch(password);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneNumber);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static String? passwordValidator(String password) {
    if (!hasLowerCase(password)) {
      return 'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل.';
    }
    if (!hasUpperCase(password)) {
      return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل.';
    }
    if (!hasSpecialCharacter(password)) {
      return 'يجب أن تحتوي كلمة المرور على حرف خاص واحد على الأقل.';
    }
    if (!hasNumber(password)) {
      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل.';
    }
    if (!hasMinLength(password)) {
      return 'يجب أن تكون كلمة المرور مكونة من 8 أحرف على الأقل.';
    }
    return null;
  }
}
