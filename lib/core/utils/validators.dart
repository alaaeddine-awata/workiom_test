class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value, {
    int? minLength,
    bool? requireUppercase,
    bool? requireLowercase,
    bool? requireDigit,
    bool? requireSpecialChar,
  }) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    if (minLength != null && value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (requireUppercase == true && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (requireLowercase == true && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (requireDigit == true && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    if (requireSpecialChar == true && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return '$fieldName should contain only letters';
    }
    return null;
  }

  static String? validateTenantName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a tenant name';
    }
    if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9-]*$').hasMatch(value)) {
      return 'Tenant name must start with a letter and can contain letters, numbers, and dashes';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
