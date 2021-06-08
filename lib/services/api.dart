import 'dart:convert';
import 'package:capitalontap_coding_test/core/exceptions.dart';
import 'package:capitalontap_coding_test/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'api_interface.dart';

class Api implements ApiInterface {
  Api(this.restUrl);

  final customer_endpoint = 'Customer';
  final card_endpoint = 'Cards';

  @override
  String restUrl;

  @override
  Future<User> postUserData(String userJson) async {
    final _response;

    if (!await InternetConnectionChecker().hasConnection) {
      throw ConnectionException();
    }

    try {
      _response = await http.post(
          Uri.https(
            restUrl,
            customer_endpoint,
          ),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: userJson);
    } catch (_) {
      throw ApiException();
    }

    if (_response.statusCode == 200) {
      var _customer = User.fromJson(jsonDecode(_response.body));
      return _customer;
    } else {
      throw ApiException();
    }
  }

  @override
  Future<String> getUserData(int id) async {
    final _response;
    try {
      _response = await http.get(Uri.https(restUrl, '$customer_endpoint/$id'));
    } catch (ex) {
      throw Exception('Error reading data for id $id');
    }

    return (_validApiResponse(_response.statusCode))
        ? _response.body
        : throw Exception('Could not find data for id $id');
  }

  @override
  Future<String> getCardData(int id) async {
    final _response;

    if (!await InternetConnectionChecker().hasConnection) {
      throw ConnectionException();
    }

    try {
      _response = await http
          .get(Uri.https(restUrl, '$customer_endpoint/$id/$card_endpoint'));
    } catch (ex) {
      throw ApiException();
    }

    return (_validApiResponse(_response.statusCode))
        ? _response.body
        : ApiException();
  }

  bool _validApiResponse(int response) => response >= 200 && response <= 299;

  @override
  Future<bool> updateCardFreeze(int cardId, int custId, bool isFrozen) async {
    final _response;

    var json = '{"isFrozen":${isFrozen.toString()}}';

    if (!await InternetConnectionChecker().hasConnection) {
      throw ConnectionException();
    }

    try {
      _response = await http.put(
          Uri.https(
            restUrl,
            '$customer_endpoint/$custId/$card_endpoint/$cardId',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json);
    } catch (_) {
      throw ApiException();
    }

    if (_response.statusCode == 200) {
      return true;
    } else {
      throw ApiException();
    }
  }
}
