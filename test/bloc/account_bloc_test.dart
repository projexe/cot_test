import 'package:capitalontap_coding_test/core/exceptions.dart';
import 'package:capitalontap_coding_test/models/credit_card.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:capitalontap_coding_test/account/detail/bloc/account_bloc.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements RepositoryInterface {}

class MockConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  final testId = faker.randomGenerator.integer(9999);
  final testName = faker.person.name().toString();
  final testCompany = faker.company.name().toString();
  final testCardNo = faker.randomGenerator.fromPattern(['############']);
  final testDate = faker.date.dateTime();
  final testCustomerId = faker.randomGenerator.integer(9999);
  final testFrozen = faker.randomGenerator.boolean();
  final dummyCard = CreditCard(
      id: testId,
      isFrozen: testFrozen,
      companyName: testCompany,
      cardNumber: testCardNo,
      customerId: testCustomerId,
      expiryDate: testDate,
      fullName: testName);

  var mockRepository = MockRepository();
  var mockConnectionChecker = MockConnectionChecker();
  setUpAll(() {
    // initialise service provider for mock repo
    GetIt.instance.registerSingleton<RepositoryInterface>(mockRepository);
    GetIt.instance
        .registerSingleton<InternetConnectionChecker>(mockConnectionChecker);
  });

  group('Account bloc test group', () {
    test('[ShowCards] event emits [CardsDisplay] state when successful', () {
      final bloc = AccountBloc();
      when(() => mockRepository.fetchUserCards(any()))
          .thenAnswer((_) async => [dummyCard]);

      bloc.add(ShowCards(0));

      expectLater(
          bloc.stream,
          emitsInOrder([
            CardsDisplay(cardList: [dummyCard]),
          ]));
    });

    test(
        '[ShowCards] event emits [NoConnection] state when there is no internet connection',
        () {
      final bloc = AccountBloc();
      when(() => mockRepository.fetchUserCards(any()))
          .thenThrow(ConnectionException());
      when(() => mockConnectionChecker.hasConnection.then((_) async => false));

      bloc.add(ShowCards(0));

      expectLater(
          bloc.stream,
          emitsInOrder([
            NoDataConnection(),
          ]));
    });
  });
}
