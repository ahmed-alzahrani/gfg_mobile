class Player {
  String id;
  String name;
  String age;
  String position;
  String team;
  String teamName;
  String league;
  int number;
  Stats stats;

  Player(String id, String name, String age, String position, String team, String teamName, String league, int number, Stats stats) {
    this.id = id;
    this.name = name;
    this.age = age;
    this.position = position;
    this.team = team;
    this.teamName = teamName;
    this.league = league;
    this.number = number;
    this.stats = stats;
  }
}

class Stats {
  int appearences;
  int goals;
  int assits;
  int yellowCards;
  int redCards;

  Stats(String appearences, String goals, String assits, String yellowCards, String redCards) {
    this.appearences = int.parse(appearences);
    this.goals = int.parse(goals);
    this.assits = int.parse(assits);
    this.yellowCards = int.parse(yellowCards);
    this.redCards = int.parse(redCards);
  }
}