import 'package:dio/dio.dart';
import 'dart:async';
import 'package:gfg_mobile/services/auth_service.dart';

class SubscriptionService {
  SubscriptionService();
  final dio = new Dio();
  final auth = new AuthService();

  // returns a future that resolves to a bool that indicates whether or not the user is subscribed to a specific player
  Future<bool> checkSubscription (String player) async {
    try {
      final uid = await auth.currentUser();
      Response response = await dio.post(
        "http://10.0.2.2:8080/amISubscribed",
        data: {
          'uid': uid,
          'playerId': player
        },
      );
      return response.data['result'];
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  // returns a future that resolves to a bool that indicates whether or not a subscription was successfully added to Firebase Firestore
  Future<bool> addSubscription (String player, String playerName, String team, String teamName, String charityName, String charity) async {
    try {
      final uid = await auth.currentUser();
      Response response = await dio.post(
        "http://10.0.2.2:8080/subscribe",
        data: {
          'uid': uid,
          'playerId': player,
          'name': playerName,
          'team': team,
          'teamName': teamName,
          'charityName': charityName,
          'charityId': charity
        }
      );
      print('returning ${response.data['result']}');
      return response.data['result'];
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  // returns a promise that resolves to a bool that reports whether a subscription was successfully removed from Firebase Firestore
  Future<bool> removeSubscription (String player) async {
    try {
      final uid = await auth.currentUser();
      Response response = await dio.delete(
        'http://10.0.2.2:8080/unsubscribe',
        data: {
          'uid': uid,
          'playerId': player
        }
      );
      return response.data['result'];
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  // returns a promise that resolves to a bool that reports whether a subscription was successfully removed from Firebase Firestore
  Future<bool> updateSubscription (String player, String charity, String charityId) async {
    try {
      final uid = await auth.currentUser();
      Response response = await dio.put(
        'http://10.0.2.2:8080/updateSubscription',
        data: {
          'uid': uid,
          'playerId': player,
          'charityName': charity,
          'charityId': charityId,
        }
      );
      return response.data['result'];
    } catch (error) {
      print("error: $error");
      return false;
    }
  }

  // returns a promise that resovles to a List of subscriptions held by the currently logged in user
  Future<List> getSubscriptions () async {
    try {
      final uid = await auth.currentUser();
      final url = 'http://10.0.2.2:8080/subscriptions' + uid;
      Response response = await dio.get(url);
      return response.data;
    } catch (error) {
      print("error: $error");
      return [];
    }
  }
}