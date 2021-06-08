part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class ShowCards extends AccountEvent {
  final int id;
  ShowCards(this.id);
  @override
  List<Object> get props => [id];
}

