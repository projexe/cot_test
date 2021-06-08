import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capitalontap_coding_test/config/di_registration.dart';
import 'package:capitalontap_coding_test/core/exceptions.dart';
import 'package:capitalontap_coding_test/models/credit_card.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:equatable/equatable.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc({required this.cardList}) : super(CardInitial(cardList: cardList));
  final RepositoryInterface repo = getIt<RepositoryInterface>();
  final List<CreditCard> cardList;

  @override
  Stream<CardState> mapEventToState(
    CardEvent event,
  ) async* {
    if (event is FreezeIt) {
      var success = false;
      try {
        success = await repo.freeze(event.card, event.isFrozen);
      } on ConnectionException {
        yield NoConnection();
      }
      if (success) {
        yield CardFrozen(creditCard: event.card, isFrozen: event.isFrozen);
      }
    }
  }
}
