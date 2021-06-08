import 'package:formz/formz.dart';

enum CompanynameValidationError { invalid, empty }

class Companyname extends FormzInput<String, CompanynameValidationError> {
  const Companyname.pure([String value = '']) : super.pure(value);
  const Companyname.dirty([String value = '']) : super.dirty(value);

  @override
  CompanynameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null; }
    else {
      return CompanynameValidationError.empty;
    }

  }
}
