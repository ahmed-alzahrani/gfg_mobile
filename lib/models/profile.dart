// Models a User's Profile in Firebase Firestore
class Profile {
  String birthday;
  String country;
  String email;
  String first;
  String last;
  UserStats stats;

  Profile(this.birthday, this.country, this.email, this.first, this.last, this.stats);
}

class UserStats {
  String topScorer;
  List<Goal> allGoals;
  List<dynamic> charities;
  String topCharity;
  List<dynamic> scorers;
  int goals;

  UserStats(this.topScorer, this.allGoals, this.charities, this.topCharity, this.scorers, this.goals);
}

class Goal {
  String charityName;
  String charity;
  String player;
  String playerName;
  String teamName;
  String team;
  String time;

  Goal(this.charityName, this.charity, this.player, this.playerName, this.teamName, this.team, this.time);
}