import 'package:formz/formz.dart';

enum MobileValidationError { invalid }

class Mobile extends FormzInput<String, MobileValidationError> {
  const Mobile.pure([String value = '']) : super.pure(value);
  const Mobile.dirty([String value = '']) : super.dirty(value);

  static final _mobileRegex = RegExp(
    r'^(\+44\s?7\d{3}|\(?07\d{3}\)?)\s?\d{3}\s?\d{3}$',
  );

  @override
  MobileValidationError? validator(String? value) {
    return _mobileRegex.hasMatch(value ?? '')
        ? null
        : MobileValidationError.invalid;
  }
}