/// Provides consistent validation rules for CAV form fields.
class CavValidators {
  CavValidators._();

  static final _emailPattern = RegExp(
    r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
  );
  static final _cellphonePattern = RegExp(r'^\d{11}$');

  /// Returns an error when [value] is empty after trimming whitespace.
  static String? required(String? value) {
    if ((value ?? '').trim().isEmpty) return 'This field is required.';
    return null;
  }

  /// Returns an error when [value] is missing or not a valid email address.
  static String? email(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (!_emailPattern.hasMatch(value!.trim())) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  /// Returns an error unless [value] contains exactly 11 numeric digits.
  static String? cellphone(String? value) {
    final requiredError = required(value);
    if (requiredError != null) return requiredError;

    if (!_cellphonePattern.hasMatch(value!.trim())) {
      return 'Enter an 11-digit cellphone number.';
    }
    return null;
  }
}
