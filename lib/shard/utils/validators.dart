///return error message if the [value] is not an [_email] or [value] is empty
String? emailValidator(String? value) {
  if (value == null) {
    return null;
  }
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value);
  if (emailValid) return null;
  return 'الرجاء ادخال بريد الكتروني صحيح';
}

///returns error message if the [value] is less than 8 characters or the [value] is empty
String? passwordValidator(String? value) {
  int validate = 0;
  RegExp capital = RegExp(r'^(?=.*?[A-Z]).{8,}$');
  RegExp small = RegExp(r'^(?=.*?[a-z]).{8,}$');
  RegExp number = RegExp(r'^(?=.*?[0-9]).{8,}$');
  RegExp symbol = RegExp(r'^(?=.*?[!@#\$&*~.]).{8,}$');
  if (capital.hasMatch(value!)) validate++;
  if (small.hasMatch(value)) validate++;
  if (number.hasMatch(value)) validate++;
  if (symbol.hasMatch(value)) validate++;

  if (validate >= 2) return null;
  return 'يجب ان تحتوي كلمة المرور على رموز واحرف كبيرة وصغيرة وعلى الأقل 8 حروف';
}

///returns error message if the provided values doesn't match
String? passwordMatchValidator(String? password, String? passwordConfirmation) {
  if (password == null) {
    return null;
  }
  if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
    return "الرجاء تأكيد كلمة المرور.";
  }
  if (password == passwordConfirmation) {
    return null;
  }
  return "كلمة المرور غير متطابقة";
}

///returns error message if the [value] is only numbers
String? nameValidator(String? value) {
  if (int.tryParse(value!) == null && value != '') return null;
  return 'الرجاء ادخال اسم صحيح';
}

///return error message if [value] is not numbers only
String? phoneNumberValidator(String? value) {
  if (value == null) {
    return null;
  }

  if (int.tryParse(value) != null) return null;

  return 'الرجاء ادخال رقم هاتف صحيح';
}

String? intOnlyValidator(String? value) {
  if (value == null) {
    return null;
  }

  if (int.tryParse(value) != null) return null;

  return 'الرجاء ادخال رقم صحيح';
}

String? doubleOnlyValidator(String? value) {
  if (value == null) {
    return null;
  }

  if (double.tryParse(value) != null) return null;

  return 'الرجاء ادخال ارقام فقط';
}

///returns error message if the [value] is empty or length != 4
String? otpValidator(String? value) {
  if (value != null && int.tryParse(value) != null && value.length == 6) {
    return null;
  }
  return 'الرجاء ادخال رقم التأكيد';
}

String? idValidator(String? value) {
  if (value != null && int.tryParse(value) != null && value.length == 14) {
    return null;
  }
  return 'رجاء ادخل معرّف صحيح';
}

String? dateValidator(String? value) {
  if (DateTime.tryParse(value!) != null) return null;
  return 'الرجاء اختيار تاريخ';
}

String? notEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'الرجاء ملء هذا الحقل';
  }
  return null;
}
