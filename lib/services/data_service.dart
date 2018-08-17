import 'package:dio/dio.dart';
import 'dart:async';
import'package:firebase_auth/firebase_auth.dart';
import 'package:gfg_mobile/services/auth_service.dart';

class DataService {
  DataService();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final dio = new Dio();
  final authService = new AuthService();

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

  Future<List> countries() async {
    try {
      final response = await dio.get('http://10.0.2.2:8080/countries');
      return response.data;
    } catch (error) {
      print("error! $error");
      return [];
    }
  }

  Future<List> matches () async {
    try {
      final user = await auth.currentUser();
      final url = 'http://10.0.2.2:8080/matches/' + user.uid;
      final response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error! $error");
      return [];
    }
  }

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

  Future<List> subscriptions() async {
    // make a call to the localServer at /subscriptions/:userId
    final uid = await authService.currentUser();
    try{
      final url = 'http://10.0.2.2:8080/subscriptions/' + uid;
      final response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error: $error");
      return [];
    }
  }

  Future<List> participants(String localTeamId, String visitorTeamId) async {
    final uid = await authService.currentUser();
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

  Future<bool> updateProfile (String first, String last, String country) async {
    try {
      final user = await auth.currentUser();
      final url = 'http://10.0.2.2:8080/updateProfile/' + user.uid;
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