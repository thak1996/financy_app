class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';

    if (value.length > 255) {
      return 'Name must be at most 255 characters';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(
      r'^\([1-9]{2}\) [9]{0,1}[6-9]{1}[0-9]{3}\-[0-9]{4}$',
    );
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (value.length > 255) {
      return 'Email must be at most 255 characters';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Password confirmation is required';
    }
    if (value != password) {
      return 'Passwords do not match. Please retype.';
    }
    return null;
  }
}
