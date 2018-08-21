import 'package:dio/dio.dart';
import 'dart:async';
import 'package:gfg_mobile/services/auth_service.dart';

// Data Service is responsibly for querying the server for stored JSON resources
class DataService {
  DataService();

  final dio = new Dio(); // dio for our POST requests
  final auth = new AuthService();

  // returns a promise that resolves to a list of all the players available for subscription
  Future<List> allPlayers () async {
    try {
      final response = await dio.get('http://10.0.2.2:8080/players');
      return (response.data);
    } catch (error) {
      print("error! $error");
      return [];
    }
  }

  // should be working, API-Football is currently broken when querying a single player
  // when it works, it returns a Promise tha resolves to a detailed player object
  Future<Object> player (String id) async {
    try {
      String url = 'http://10.0.2.2:8080/player/' + id;
      final response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error! $error");
      return {};
    }
  }

  Future<List> charities () async {
    try {
      final response = await dio.get('http://10.0.2.2:8080/charities');
      //print(response.data);
      return response.data;
    } catch (error) {
      print("error! $error");
      return [];
    }
  }

  // returns a promise that resolves to a list of all countries available for the user to pick from on their profile page
  Future<List> countries() async {
    try {
      final response = await dio.get('http://10.0.2.2:8080/countries');
      return response.data;
    } catch (error) {
      print("error! $error");
      return [];
    }
  }

  // returns a promise that resolves to a list of Matches that feature players the user is subscribed to for the upcoming 3 months
  Future<List> matches () async {
    try {
      final uid = await auth.currentUser();
      final url = 'http://10.0.2.2:8080/matches/' + uid;
      final response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error! $error");
      return [];
    }
  }

  // returns a promise that resolves to a list of Matches a specific player is featuring in the next 3 months
  Future<List> playerMatches (String teamId) async {
    try {
      final url = 'http://10.0.2.2:8080/playerMatches/' + teamId;
      final response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error: $error");
      return [];
    }
  }

  // returns a promise that resolves to a list of subscriptions held by the currently logged in user
  Future<List> subscriptions() async {
    // make a call to the localServer at /subscriptions/:userId
    final uid = await auth.currentUser();
    try{
      final url = 'http://10.0.2.2:8080/subscriptions/' + uid;
      final response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error: $error");
      return [];
    }
  }

  // returns a promise that resolves to a list of players that play for teams participating in a specific match
  Future<List> participants(String localTeamId, String visitorTeamId) async {
    final uid = await auth.currentUser();
    try {
      final url = 'http://10.0.2.2:8080/participants/' + uid;
      Response response = await dio.post(
        url,
        data: {
          'localTeamId': localTeamId,
          'visitorTeamId': visitorTeamId,
        }
      );
      return response.data;
    } catch (error) {
      print("error: $error");
      return [];
    }
  }

  // returns a promise that resolves to a bool that reports the success of updating a user profile in Firebase Firestore
  Future<bool> updateProfile (String first, String last, String country) async {
    try {
      final uid = await auth.currentUser();
      final url = 'http://10.0.2.2:8080/updateProfile/' + uid;
      Response response = await dio.put(
        url,
        data: {
          'first': first,
          'last': last,
          'country': country
        }
      );
      return response.data['result'];
    } catch (error) {
      print('error: $error');
      return false;
    }
  }
}