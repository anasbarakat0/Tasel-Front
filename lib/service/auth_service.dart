import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasel/service/profile_service.dart';
import '../../main.dart';
import 'Injections/get_it_inject.dart';

final uri = Uri.parse(url);
final headers = {
  'Content-Type': 'application/json',
};

class UserLogin {
  late final String email;
  late final String password;

  UserLogin(this.email, this.password);
  Map<String, dynamic>? toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

login(String email, String password) async {
  final uri = Uri.parse('$url/login');
  final user = UserLogin(email, password);
  final jsonString = jsonEncode(user.toJson());

  try {
    final response = await http.post(uri, headers: headers, body: jsonString);

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      getIt
          .get<SharedPreferences>()
          .setString('token', '${responseJson['token']}');

      userId = responseJson['id'];
      // getData();
      return true;
    } else {
      final responseBody = json.decode(response.body);
      final message = responseBody['message'];
      return [false, message];
    }
  } 
  catch (e) {
    return 'An error occurred during login.';
  }
}

// signup (String name,String password, String phone,String address) async{
//   final response = await http.post(uri,body: {"name":name,"password":password,"phone":phone,"address":address});
// }

class User {
  late final String name;
  late final String password;
  late final String phone;
  late final double latitude;
  late final double longitude;

  User(this.name, this.password, this.phone, this.latitude, this.longitude);
  Map<String, dynamic>? toJson() {
    return {
      'name': name,
      'password': password,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

signup(
  String name,
  String email,
  String phone,
  double latitude,
  double longitude,
  String password,
) async {
  final uri = Uri.parse('$url/register');

  final user = User(name, password, phone, latitude, longitude);
  final jsonString = jsonEncode(user.toJson());

  try {
    final response = await http.post(uri, headers: headers, body: jsonString);

    final responseBody = json.decode(response.body);
    final message = responseBody['message'];

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', name);
      prefs.setString('password', password);
      prefs.setString('phone', phone);
      prefs.setDouble('latitude', latitude);
      prefs.setDouble('longitude', longitude);
      return [true, message];
    } else {
      return message;
    }
  } catch (e) {
    return 'An error occurred during signup.';
  }
}

forgetPassword(String email) async {
  final uri = Uri.parse('$url/forgot-password');
  final body = jsonEncode({'email': email});
  try {
    final response = await http.post(uri, headers: headers, body: body);
    final responseBody = json.decode(response.body);
    final message = responseBody['message'];
    if (response.statusCode == 200 || response.statusCode == 500 ) {
      return [true, message, responseBody['random']];
    } else {
      return [false,message];
    }
  } catch (e) {
    return 'An error occurred during the process';
  }
}

changePassword(String email,String code, String password) async {
  final uri = Uri.parse('$url/change-password');
  final body =
      jsonEncode({'phone': email, 'randomCode': code, 'newPassword': password});
  try {
    final response = await http.post(uri, headers: headers, body: body);
    final responseBody = json.decode(response.body);
    final message = responseBody['message'];
    if (response.statusCode == 200) {
      return [true, message];
    } else if (response.statusCode == 404) {
      return [false, message];
    } else {
      return [false, message];
    }
  } catch (e) {
    return 'An error occurred during the process';
  }
}
