import 'dart:convert';
import 'package:casestudy/entity/participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../entity/user.dart';
import '../sharedpreferences/sharedprefence.dart';
class HttpController {
    var tokenProvider ;

  Future<List<User>> getAllUser() async {
    List<User> users = [];
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON data
      var jsonData = json.decode(response.body);

      if (jsonData.containsKey('data')) {
        // Check if the 'data' key exists in the JSON response
        var userJsonList = jsonData['data'];

        for (var userJson in userJsonList) {
          // Iterate over the list of user JSON data and create User objects
          User user = await User.fromJson(
              userJson); // You should have a User.fromJson constructor
          users.add(user);
        }
      } else {
        throw Exception('Invalid JSON format: Missing "data" key.');
      }
    } else {
      // Handle errors here
      throw Exception('Failed to fetch data.');
    }

    return users;
  }

  Future<List<Participant>> getparticip() async {
    List<Participant> partic = [];
    final response = await http.get(Uri.parse('https://reqres.in/api/login'));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON data
      var jsonData = json.decode(response.body);
      print(jsonData['data']);
      var particJsonList = jsonData['data'];

      for (var particJson in particJsonList) {
        // Iterate over the list of user JSON data and create User objects
        Participant participant = Participant.fromJson(
            particJson); // You should have a User.fromJson constructor
        partic.add(participant);
      }

    } else {
      // Handle errors here
      throw Exception('Failed to fetch data.');
    }

    return partic;
  }


  Future<bool> LoginUser(String email, String pass, context) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {
        'email': email,
        'password': pass,
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data.containsKey("token")) {
        await SharedPref().initialize();
        // token riverpod a eklendi
         tokenProvider = StateProvider<String?>((ref) =>data["token"]);

        // sharedPref e   token eklendi
        await SharedPref().saveToken(data["token"]);
        snackbar(context, "Kullanıcı girişi başarılı");
        return true;
      } else {
        snackbar(context, "Bilinmeyen bir hata oluştu");
        return false;
      }
    } else {
      var msj =jsonDecode(response.body);
      snackbar(context, msj["error"].toString());
      return false;
    }
  }

  }


snackbar(BuildContext context, var message, {duration = 3}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: duration),
    content: Text(message),
  ));
}