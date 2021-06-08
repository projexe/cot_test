import 'dart:convert';
import 'package:capitalontap_coding_test/models/credit_card.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

final testId = faker.randomGenerator.integer(9999);
final testName = faker.person.name().toString();
final testCompany = faker.company.name().toString();
final testCardNo = faker.randomGenerator.fromPattern(['############']);
final testDate = faker.date.dateTime();
final testCustomerId = faker.randomGenerator.integer(9999);
final testFrozen = faker.randomGenerator.boolean();

final validCardJson = '{"id": $testId, "fullName": "$testName",'
     '"companyName": "$testCompany","cardNumber": "$testCardNo",'
    '"expiryDate": "$testDate","customerId": $testCustomerId,'
    '"isFrozen": $testFrozen}';

void main() {
  setUpAll(() {});

  group('Test Card data class', () {

    test('Contruct a card from valid json instantiates a valid card', () {
      final jsonMap = json.decode(validCardJson);
      final testCard = CreditCard.fromJson(jsonMap);
      expect(testCard.fullName, testName);
      expect(testCard.isFrozen, testFrozen);
      expect(testCard.cardNumber, testCardNo);
      expect(testCard.companyName, testCompany);
      expect(testCard.customerId, testCustomerId);
      expect(testCard.expiryDate, testDate);
    });
  });
}
