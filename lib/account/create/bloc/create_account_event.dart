part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object?> get props => [];
}

class FirstnameChanged extends CreateAccountEvent {
  const FirstnameChanged({required this.firstname});

  final String firstname;

  @override
  List<Object> get props => [firstname];
}

class LastnameChanged extends CreateAccountEvent {
  const LastnameChanged({required this.lastname});

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

class CompanynameChanged extends CreateAccountEvent {
  const CompanynameChanged({required this.companyname});

  final String companyname;

  @override
  List<Object> get props => [companyname];
}

class MobileChanged extends CreateAccountEvent {
  const MobileChanged({required this.mobile});

  final String mobile;

  @override
  List<Object> get props => [mobile];
}

class TurnoverChanged extends CreateAccountEvent {
  const TurnoverChanged({required this.turnover});

  final String turnover;

  @override
  List<Object> get props => [turnover];
}

class FirstnameUnfocused extends CreateAccountEvent {}

class LastnameUnfocused extends CreateAccountEvent {}

class CompanynameUnfocused extends CreateAccountEvent {}

class TurnoverUnfocused extends CreateAccountEvent {}

class MobileUnfocused extends CreateAccountEvent {}

class FormSubmitted extends CreateAccountEvent {
  const FormSubmitted({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];

}
