class Validator {
  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email cannot be empty";
    } else if (!isValidEmail(email)) {
      return "Enter a valid email address";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Password cannot be empty";
    } else if (password.length < 8) {
      return "Password length min 8 characters";
    }
    return null;
  }
}
