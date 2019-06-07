import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:demo/src/view/main_component.dart';
import 'package:http/http.dart';
import 'package:demo/src/model/person.dart';

class UserService {
  // request to middlemand
  UserService(this._http);

  static final _headers = {'Content-Type': 'application/json'};
  static const _userUrl = host+'/user'; // URL to web API
  final Client _http;

  ///Liest die Daten aus einer Response
  dynamic _extractData(Response resp) => json.decode(resp.body);

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return Exception('Server error; cause: $e');
  }

  ///Erstellt einen neuen User mit gegebenem Namen, Email und Passwort
  Future<User> create(User user) async {
    try {
      final response = await _http.post(_userUrl,
          headers: _headers, body: json.encode(user.toJson()));
      return User.fromJson(
          _extractData(response as Response) as Map<String, dynamic>);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<User>> getAll() async {
    final Response response = await _http.get('$_userUrl') as Response;
    return (_extractData(response) as List)
        .map((value) => User.fromJson(value as Map<String, dynamic>))
        .toList();
  }

  Future<User> get(String contactCode) async {
    final Response response = await _http.get('$_userUrl/$contactCode') as Response;
    return User.fromJson(_extractData(response) as Map<String, dynamic>);
  }

  Future login(username, password) async {
    var response =
    await _http.post(_userUrl, body: {'username': username, 'password': password}) as Response;
    Map<String,dynamic> mappedResponse = json.decode(response.body) as Map<String,dynamic>;
    window.localStorage.addAll({"token": mappedResponse["key"]as String});
  }
  Future check_authentification () async {
    String _headers_key = "Authorization";
    String _headers_value =  "Token "+window.localStorage["token"];
    var response = await _http.get("http://127.0.0.1:8000/auth/user/", headers: {_headers_key: _headers_value})as Response;
    Map<String,dynamic> jsonMap = json.decode(response.body) as Map<String,dynamic>;
    print(response.statusCode);
  }



  /*Future<User> getLoginEmail(String password, String email) async {
    final Response response = await _http.get('$_userUrl/$password/$email');
    return User.fromJson(_extractData(response) as Map<String, dynamic>);
  }

  Future<User> getLoginNickname(String password, String username) async {
    final Response response = await _http.get('$_userUrl/$password/$nickname');
    return User.fromJson(_extractData(response) as Map<String, dynamic>);
  }*/

  /*///Updatet einen bereits existierenden User
  Future<User> update(User user) async {
    for (var mockUser in mockUsers) {
      if (mockUser.contactCode == user.contactCode) {
        mockUser = user;
      }
      return mockUser;
    }
  }*/
}
