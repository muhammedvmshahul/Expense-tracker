class Validation {
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Amount must be a valid integer';
    }
    if (intValue <= 0) {
      return 'Amount must be greater than 0';
    }
    return null;
  }
}
