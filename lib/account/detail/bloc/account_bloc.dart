import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:capitalontap_coding_test/config/di_registration.dart';
import 'package:capitalontap_coding_test/core/exceptions.dart';
import 'package:capitalontap_coding_test/models/credit_card.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:equatable/equatable.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());

  final RepositoryInterface repo = getIt<RepositoryInterface>();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is ShowCards) {
      var cardList = <CreditCard>[];
      try {
        cardList = await repo.fetchUserCards(event.id);
      } on ConnectionException {
        yield NoDataConnection();
      }
      if (cardList.isNotEmpty) {
        yield CardsDisplay(cardList: cardList);
      }
    }
  }
}
