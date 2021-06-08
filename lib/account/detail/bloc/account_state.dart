part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class CardsDisplay extends AccountState {
  CardsDisplay({required this.cardList});
  final List<CreditCard> cardList;
  @override
  List<Object> get props => [cardList];
}

class NoDataConnection extends AccountState {
  @override
  List<Object> get props => [];
}

