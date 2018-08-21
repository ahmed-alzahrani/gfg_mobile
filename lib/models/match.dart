// Models incoming Match information from the GFG-Webapp server
class Match{
  String id;
  String compId;
  String date;
  String season;
  String week;
  String venue;
  String venueId;
  String venueCity;
  String status;
  String timer;
  String time;
  String localTeamId;
  String localTeamName;
  String localTeamScore;
  String visitorTeamId;
  String visitorTeamName;
  String visitorTeamScore;
  String htScore;
  String ftScore;
  String etScore;
  String penaltyLocal;
  String penaltyVisitor;

  Match(this.id, this.compId, this.date, this.season, this.week, this.venue, this.venueId, this.venueCity, this.status, this.timer, this.time, this.localTeamId, this.localTeamName, this.localTeamScore, this.visitorTeamId, this.visitorTeamName, this.visitorTeamScore, this.htScore, this.ftScore, this.etScore, this.penaltyLocal, this.penaltyVisitor);
}