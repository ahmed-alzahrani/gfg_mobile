import 'package:dio/dio.dart';
import 'dart:async';
import'package:firebase_auth/firebase_auth.dart';

class DataService {
  DataService();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final dio = new Dio();

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
      return response.data;
    } catch (error) {
      print("error! $error");
      return [];
    }
  }

  Future<List> getMatches () async {
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

  Future<List> playerMatches (teamId) async {
    try {
      final url = 'http://10.0.2.2:8080/playerMatches/' + teamId;
      final response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error: $error");
      return [];
    }
  }

}