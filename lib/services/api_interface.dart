import 'package:capitalontap_coding_test/models/user.dart';

/// Interface for Api

abstract class ApiInterface {
  String get restUrl;
  set restUrl(String endPoint);

  /// Get user data for the [id]
  Future<String> getUserData(int id);
  Future<String> getCardData(int id);

  /// Post user data
  Future<User> postUserData(String userJson);
  Future<bool> updateCardFreeze(int cardId, int custId, bool isFrozen);
}
