import 'dart:convert';
import 'package:blood_bank/models/donor.dart';
import 'package:blood_bank/models/person_donor.dart';
import 'package:blood_bank/models/user.dart';
import 'package:blood_bank/screen/home.dart';
import 'package:blood_bank/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginProvider with ChangeNotifier {
  static User _user = new User();
  List<PersonDonor> _personDonor = [];
  bool logInLoading = false;
  static String _token = "";
  User get user {
    return _user;
  }

  List<PersonDonor> get personDonor => [..._personDonor];

  Future<void> login(
      String email, String password, BuildContext context) async {
    var response;

    try {
      logInLoading = true;
      notifyListeners();
      response = await http.post(
          Uri.parse('http://bloodbanksystemapp.herokuapp.com/api/login'),
          body: {
            'email': email,
            'password': password,
          },
          headers: {
            'accept': 'application/json'
          });

      if (response.statusCode == 200) {
        logInLoading = false;
        final Map<String, dynamic> extractData =
            json.decode(response.body) as Map<String, dynamic>;
        print("extractData $extractData");
        _token = extractData['access_token'];
        _user = data(extractData['data'], _token);
      } else {
        logInLoading = false;
        notifyListeners();
        return;
      }
    } catch (e) {
      throw e;
    }

    notifyListeners();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return Home();
      }),
      (route) => false,
    );
  }

  User data(Map<String, dynamic> myData, String accessToken) {
    final newUser = User(
      id: myData['user']['id'],
      name: myData['user']['name'],
      email: myData['user']['email'],
      createdAt: myData['user']['created_at'],
      accessToken: accessToken,
      phone: myData['user']['phone'],
      updatedAt: myData['user']['updated_at'],
      donor: myData['donor'] == null
          ? new Donor()
          : new Donor(
              userId: myData['donor']['user_id'],
              firstName: myData['donor']['firstName'],
              lastName: myData['donor']['lastName'],
              address: myData['donor']['address'],
              phone: myData['donor']['phone'],
              donorID: myData['donor']['donorID'],
              bloodType: myData['donor']['bloodType'],
              createdAt: myData['donor']['created_at'],
              updatedAt: myData['donor']['updated_at'],
              dateOfBirth: myData['donor']['dateOfBirth'],
              identityNumber: myData['donor']['identityNumber'],
            ),
    );

    return newUser;
  }

  Future<List<PersonDonor>> getDonor() async {
    try {
      Map<String, String> header = {
        'Authorization': 'Bearer ' + _token,
      };
      final http.Response response = await http.get(
          Uri.parse(
              'http://bloodbanksystemapp.herokuapp.com/api/donor/donation'),
          headers: header);
      if (response.statusCode == 200) {
        final Map<String, dynamic> extractData =
            json.decode(response.body) as Map<String, dynamic>;
        print(extractData);
        _personDonor.addAll(getDataDonor(extractData['data']));
      }
    } catch (e) {
      throw e;
    }
    return _personDonor;
  }

  List<PersonDonor> getDataDonor(List data) {
    final List<PersonDonor> loadedItems = [];
    if (data.isEmpty) return [];
    data.forEach(
      (item) {
        loadedItems.add(
          new PersonDonor(
            bloodID: item['bloodID'],
            donorID: item['donorID'],
            dateDonated: item['dateDonated'],
            quantity: item['quantity'],
            updatedAt: item['updated_at'],
            createdAt: item['created_at'],
          ),
        );
      },
    );

    return loadedItems;
  }

  void logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
      return Login();
    }), (route) => false);
  }
}
// hassansammoer@gmail.com