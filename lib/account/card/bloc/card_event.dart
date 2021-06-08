part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
}

class FreezeIt extends CardEvent {
  final CreditCard card;
  final bool isFrozen;
  FreezeIt({required this.card,  required this.isFrozen});
  @override
  List<Object> get props => [card, isFrozen];
}
