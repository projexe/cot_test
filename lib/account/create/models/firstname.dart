import 'package:formz/formz.dart';

enum FirstnameValidationError { empty }

class Firstname extends FormzInput<String, FirstnameValidationError> {
  const Firstname.pure([String value = '']) : super.pure(value);
  const Firstname.dirty([String value = '']) : super.dirty(value);

  @override
  FirstnameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null; }
    else {
      return FirstnameValidationError.empty;
    }
  }
}
