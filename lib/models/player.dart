class Player {
  String id;
  String name;
  String age;
  String position;
  String team;
  String teamName;
  String league;
  int number;
  String injured;
  Stats stats;

  Player(this.id, this.name, this.age, this.position, this.team, this.teamName, this.league, this.number, this.injured, this.stats);
}

class Stats {
  int appearences;
  int goals;
  int assits;
  int yellowCards;
  int redCards;

  Stats(this.appearences, this.goals, this.assits, this.yellowCards, this.redCards);
}