import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../url_config/urls.dart';

class AuthRequest {

  static Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      if (username.isEmpty || password.isEmpty) {
        // Handle empty username or password
        return null;
      }

      var regBody = {"username": username, "password": password};
      var response = await http.post(
        Uri.parse(Urls.loginUser),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('access_token') &&
            jsonResponse.containsKey('refresh_token') &&
            (jsonResponse.containsKey('student') ||
                jsonResponse.containsKey('staff') ||
                jsonResponse.containsKey('admin'))) {

          var myAccessToken = jsonResponse['access_token'];
          var refreshToken = jsonResponse['refresh_token'];
          var userData;
          if(jsonResponse.containsKey('staff')){
            userData = jsonResponse['staff'];
          }
          if(jsonResponse.containsKey('student')){
            userData = jsonResponse['student'];
          }
          if(jsonResponse.containsKey('admin')){
            userData = jsonResponse['admin'];
          }
          pref.setString('token', myAccessToken);
          pref.setString('refresh_token', refreshToken);

          // Return both student and access_token
          return {
           'access_token': myAccessToken,
           'user_data':userData
          };
        } else {
          // Handle missing fields in the response
          return null;
        }
      } else {
        // Handle non-200 status codes
        print("Login failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      // Handle unexpected errors
      print("Error during login: $error");
      return null;
    }
  }

  static Future<void> logout(String token) async {
    // Clear the JWT token or any other authentication-related data
    // You can add more logic here, such as notifying the server about the logout
    var jwtToken = token;
    final response = await http.get(
      Uri.parse(Urls.logoutUser),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print('LOGOUTED');
    }
    // Clear the token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  static Future<String?> refreshTheToken() async {
    print("Hi from RefreshFunction");
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('refresh_token');
    final response = await http.get(
      Uri.parse(Urls.refreshToken),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var myAccessToken = jsonResponse['access_token'];
      var refreshToken = jsonResponse['refresh_token'];
      pref.setString('token', myAccessToken);
      pref.setString('refresh_token', refreshToken);
      return myAccessToken;
    }
    return null;
  }

}
