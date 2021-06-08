import 'package:formz/formz.dart';

enum TurnoverValidationError { invalid, negative, empty, zero }

class Turnover extends FormzInput<String, TurnoverValidationError> {
  const Turnover.pure([String value = '']) : super.pure(value);

  const Turnover.dirty([String value = '']) : super.dirty(value);

  @override
  TurnoverValidationError? validator(String? value) {
    int? amount;
    if (value?.isEmpty == true) {
      return TurnoverValidationError.empty;
    }
    try {
      amount = int.parse(value!);
    } catch (_) {
      return TurnoverValidationError.invalid;
    }
    if (amount < 0) {
      return TurnoverValidationError.negative;
    }

    if (amount == 0) {
      return TurnoverValidationError.zero;
    }

    return null;
  }
}
