import 'package:formz/formz.dart';

enum LastnameValidationError { empty }

class Lastname extends FormzInput<String, LastnameValidationError> {
  const Lastname.pure([String value = '']) : super.pure(value);
  const Lastname.dirty([String value = '']) : super.dirty(value);

  @override
  LastnameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      return null; }
    else {
      return LastnameValidationError.empty;
    }
  }
}
