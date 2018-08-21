// Models a subscription a User holds in the Firebase Firestore
class Subscription {
  String id;
  String charity;
  String charityId;
  int goals;
  String name;
  String teamName;
  String time;

  Subscription(this.id, this.charity, this.charityId, this.goals, this.name, this.teamName, this.time);
}