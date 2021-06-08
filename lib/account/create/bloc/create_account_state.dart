part of 'create_account_bloc.dart';

enum CreateAccountError { api, connection, none }

class CreateAccountState extends Equatable {
  const CreateAccountState(
      {this.firstname = const Firstname.pure(),
      this.lastname = const Lastname.pure(),
      this.companyname = const Companyname.pure(),
      this.turnover = const Turnover.pure(),
      this.mobile = const Mobile.pure(),
      this.status = FormzStatus.pure,
      this.id,
      this.complete = false,
      this.error = CreateAccountError.none});

  final Firstname firstname;
  final Lastname lastname;
  final Companyname companyname;
  final Turnover turnover;
  final Mobile mobile;
  final FormzStatus status;
  final int? id;
  final bool complete;
  final CreateAccountError error;

  CreateAccountState copyWith(
      {Firstname? firstname,
      Lastname? lastname,
      Companyname? companyname,
      Turnover? turnover,
      Mobile? mobile,
      FormzStatus? status,
      int? id,
      bool? complete,
      CreateAccountError? error}) {
    return CreateAccountState(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        companyname: companyname ?? this.companyname,
        turnover: turnover ?? this.turnover,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
        id: id ?? this.id,
        complete: complete ?? this.complete,
        error: error ?? CreateAccountError.none);
  }

  User toUser() => User(
      firstName: firstname.value,
      lastName: lastname.value,
      companyName: companyname.value,
      annualTurnover: int.parse(turnover.value),
      mobileNumber: mobile.value,
      id: id);

  @override
  List<Object?> get props => [
        firstname,
        lastname,
        companyname,
        turnover,
        mobile,
        status,
        id,
        error,
        complete
      ];
}
