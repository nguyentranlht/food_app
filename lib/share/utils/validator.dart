class Validator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email không được để trống';
    }
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    if (!emailRegExp.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Họ và tên không được để trống';
    }
    return null;
  }

  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    final RegExp phoneRegExp = RegExp(
      r'^[0-9]{10,11}$',
    );
    if (!phoneRegExp.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }
}
