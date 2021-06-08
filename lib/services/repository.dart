import 'dart:convert';

import 'package:capitalontap_coding_test/core/exceptions.dart';
import 'package:capitalontap_coding_test/models/credit_card.dart';
import 'package:capitalontap_coding_test/services/api_interface.dart';
import 'package:capitalontap_coding_test/services/repository_interface.dart';
import 'package:capitalontap_coding_test/models/user.dart';

class Repository implements RepositoryInterface {
  Repository(this.api);

  @override
  final ApiInterface api;

  @override
  User? currentUser;

  @override
  // TODO: implement hasConnection
  bool get hasConnection => throw UnimplementedError();

  /// Create a user record. Call api to write user data to server. Return [User]
  /// if successful or rethrow exception from api object
  @override
  Future<User> createUser(User user) async {
    User _newUser;
    try {
      _newUser = await api.postUserData(jsonEncode(user.toJson()));
    } on Exception {
      rethrow;
    }
    currentUser = _newUser;
    return _newUser;
  }

  /// Fetch user data from the api. Returns User instance or throws exception
  @override
  Future<User> fetchUserById(int customerId) async {
    final json;
    try {
      json = await api.getUserData(customerId);
    } on ApiException {
      rethrow;
    }
    return User.fromJson(jsonDecode(json));
  }

  @override
  Future<List<CreditCard>> fetchUserCards(int customerId) async {
    final _jsonCardString;
    try {
      _jsonCardString = await api.getCardData(customerId);
    } on Exception {
      rethrow;
    }

    final _jsonCardList = jsonDecode(_jsonCardString) as List;
    var cardList = <CreditCard>[];
    _jsonCardList.forEach((i) {
      try {
        cardList.add(CreditCard.fromJson(i));
      } catch (e) {
        throw ApiException();
      }
    });

    return cardList;
  }

  @override
  Future<bool> freeze(CreditCard creditCard, bool isFrozen) async {
    return await api.updateCardFreeze(
        creditCard.id, creditCard.customerId, isFrozen);
  }
}
