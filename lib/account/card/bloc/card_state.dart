part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();
}

class CardInitial extends CardState {
  CardInitial({required this.cardList});
  final List<CreditCard> cardList;
  @override
  List<Object> get props => [cardList];
}

class CardFrozen extends CardState {
  CardFrozen({required this.creditCard, required this.isFrozen});
  final bool isFrozen;
  final CreditCard creditCard;
  @override
  List<Object> get props => [creditCard, isFrozen];
}

class NoConnection extends CardState {
  NoConnection();
  @override
  List<Object> get props => [];
}
