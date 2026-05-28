class AppValidators {
  static String? validateEmail(String? value, {required String emailRequired, required String invalidEmail}) {
    if (value == null || value.isEmpty) {
      return emailRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? value, {
    required String passwordRequired,
    required String passwordTooShort,
    required String passwordInvalid,
  }) {
    if (value == null || value.isEmpty) {
      return passwordRequired;
    }
    if (value.length < 8) {
      return passwordTooShort;
    }
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
    if (!passwordRegex.hasMatch(value)) {
      return passwordInvalid;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password, {
    required String confirmPasswordRequired,
    required String passwordsDoNotMatch,
  }) {
    if (value == null || value.isEmpty) {
      return confirmPasswordRequired;
    }
    if (value != password) {
      return passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateName(String? value, {required String nameRequired}) {
    if (value == null || value.isEmpty) {
      return nameRequired;
    }
    return null;
  }

  static String? validatePhone(String? value, {required String phoneRequired, required String invalidPhone}) {
    if (value == null || value.isEmpty) {
      return phoneRequired;
    }
    final phoneRegex = RegExp(r'^(010|011|012|015)[0-9]{8}$');
    if (!phoneRegex.hasMatch(value)) {
      return invalidPhone;
    }
    return null;
  }
}
