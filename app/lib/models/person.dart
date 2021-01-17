enum Relation {
  friend,
  coworker,
  family,
  unknown
}

Person isaiah = Person(name: "Isaiah", relation: Relation.friend, description: "Pro coder, and insomnomaniac (ex google intern)");
Person detected = isaiah;

class Person {
  String name = "Unknown";
  String description = "";
  Relation relation = Relation.unknown;
  String lastLocation = "";

  Person({this.name, this.description, this.relation, this.lastLocation})
}