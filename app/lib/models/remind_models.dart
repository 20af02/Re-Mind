// enum Relation { friend, coworker, family, unknown }

Person isaiah = Person(
  name: "Isaiah",
  relation: "friend",
  description: "Pro coder, and insomnomaniac (ex google intern)",
  url: "https://media-exp1.licdn.com/dms/image/C5603AQFCZy9hRxCfXw/profile-displayphoto-shrink_400_400/0/1517064676278?e=1616630400&v=beta&t=lDruCrMSpzmAZmNb1_oKjQQ8OxDB2YUlnI5uK9rSzJk"
);


Person detected = isaiah;

List<Person> people = [
  isaiah,
];

void rememberPerson(Person person) {
  people.add(person);
}

class Person {
  String name = "Unknown";
  String description = "";
  String relation = "friend";
  String lastLocation = "";
  String url;
  String path;

  Person({this.name, this.description, this.relation, this.lastLocation, this.url, this.path});
}

class Item {
  String name = "";
  String lastLocation = "94 Stanley Street, London Ontario";
  String lastLocationUrl = "";
  String notes = "";
  String path;

  Item({this.name, this.lastLocation, this.lastLocationUrl, this.notes, this.path});
}

List<Item> items = [];
void rememberItem(Item item) {
  items.add(item);
}
