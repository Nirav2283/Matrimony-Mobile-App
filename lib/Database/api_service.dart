import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/Database/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = "https://6671937fe083e62ee43c341e.mockapi.io/Matrimony";

  Future<bool> _isInternetAvailable(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog(context);
      return false;
    }

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      _showNoInternetDialog(context);
      return false;
    }
    return true;
  }

  void _showNoInternetDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("No Internet" , style: TextStyle(fontFamily: 'Poppins'),),
        content: Text("Internet is not available. Please check your connection."),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK" , style: TextStyle(fontFamily: 'Poppins'),),
          ),
        ],
      ),
    );
  }

  Future<List<User>> getAllUser(BuildContext context) async {
    if (!await _isInternetAvailable(context)) return []; // Return an empty list if no internet

    var res = await http.get(Uri.parse(baseUrl));
    List<dynamic> data = jsonDecode(res.body);
    List<User> users = [];
    data.forEach((element) {
      users.add(User.toUser(element));
    });
    return users;
  }

  Future<void> addUser(User user, BuildContext context) async {
    if (!await _isInternetAvailable(context)) return;

    var res = await http.post(Uri.parse(baseUrl), body: user.toMap());
    print(res.statusCode);
  }

  Future<void> deleteUser(String id, BuildContext context) async {
    if (!await _isInternetAvailable(context)) return;

    var res = await http.delete(Uri.parse("$baseUrl/$id"));
    if (res.statusCode == 200) {
      print("User deleted successfully");
    } else {
      throw Exception("Failed to delete user");
    }
  }

  Future<void> updateUser(User user, BuildContext context) async {
    if (!await _isInternetAvailable(context)) return;

    var res = await http.put(Uri.parse("$baseUrl/${user.id}"), body: user.toMap());
    print(res.statusCode);
  }
}
