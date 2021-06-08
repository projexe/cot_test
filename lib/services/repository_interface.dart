import 'package:capitalontap_coding_test/models/credit_card.dart';
import 'package:capitalontap_coding_test/services/api_interface.dart';
import 'package:capitalontap_coding_test/models/user.dart';

/// Interface for defining a repository service, serving data to the app
abstract class RepositoryInterface {
  ApiInterface get api;
  User? get currentUser;
  set currentUser(User? _user);
  /// Return true if has connection to the internet
  bool get hasConnection;
  Future<User?> createUser(User user);
  Future<User> fetchUserById(int customerId);
  Future<List<CreditCard>> fetchUserCards(int customerId);
  Future<bool> freeze(CreditCard creditCard, bool isFrozen);
}