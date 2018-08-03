import 'package:dio/dio.dart';
import 'dart:async';
import'package:firebase_auth/firebase_auth.dart';

class SubscriptionService {
  SubscriptionService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final dio = new Dio();

  Future<bool> checkSubscription (String player) async {
    try {
      final user = await auth.currentUser();
      Response response = await dio.post(
        "http://10.0.2.2:8080/amISubscribed",
        data: {
          'uid': user.uid,
          'playerId': player
        },
      );
      return response.data.result;
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  Future<bool> addSubscription (String player, String playerName, String team, String teamName, String charityName, String charity) async {
    try {
      final user = await auth.currentUser();
      Response response = await dio.post(
        "http://10.0.2.2:8080/subscribe",
        data: {
          'uid': user.uid,
          'playerId': player,
          'name': playerName,
          'team': team,
          'teamName': teamName,
          'charityName': charityName,
          'charityId': charity
        }
      );
      return response.data.result;
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  Future<bool> removeSubscription (String player) async {
    try {
      final user = await auth.currentUser();
      Response response = await dio.post(
        'http://10.0.2.2:8080/unsubscribe',
        data: {
          'uid': user.uid,
          'playerId': player
        }
      );
      return response.data.result;
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  Future<bool> updateSubscription (String player, String charity, String charityId) async {
    try {
      final user = await auth.currentUser();
      Response response = await dio.post(
        'http://10.0.2.2:8080/updateSubscription',
        data: {
          'uid': user.uid,
          'playerId': player,
          'charityName': charity,
          'charityId': charityId,
        }
      );
      return response.data.result;
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  Future<List> getSubscriptions () async {
    try {
      final user = await auth.currentUser();
      final url = 'http://10.0.2.2:8080/subscriptions' + user.uid;
      Response response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error: $error");
      return [];
    }
  }
}