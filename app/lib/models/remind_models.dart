// enum Relation { friend, coworker, family, unknown }

Person isaiah = Person(
  name: "Isaiah",
  relation: "friend",
  description: "Pro coder, and insomnomaniac (ex google intern)",
  url: "https://media-exp1.licdn.com/dms/image/C5603AQFCZy9hRxCfXw/profile-displayphoto-shrink_400_400/0/1517064676278?e=1616630400&v=beta&t=lDruCrMSpzmAZmNb1_oKjQQ8OxDB2YUlnI5uK9rSzJk"
);

Person ammaar = Person(
  name: "Ammaar",
  relation: "friend",
  description: "Tech savaunt Linux Master, will virtualize your environments",
  url: "https://media-exp1.licdn.com/dms/image/C5603AQEbfpe_VSnhxg/profile-displayphoto-shrink_800_800/0/1601511888885?e=1616630400&v=beta&t=K9tudeQay1BDgOk29oypOAA-unltuNkT3_HkQfvB4Nk"
);

Person emily = Person(
  name: "Emily",
  relation: "friend",
  description: "One of the greatest to ever through (Dart) and make them Flutter",
  url: "https://media-exp1.licdn.com/dms/image/C5603AQFQHjJAWq_Xrw/profile-displayphoto-shrink_800_800/0/1597199216318?e=1616630400&v=beta&t=Qr7wcT97YbUJQp_YN44gG7pDYsLMGHcuOy-6JW1VXMc"
);

Person muntaser = Person(
  name: "Muntaser",
  relation: "friend",
  description: "This Guy Hacks",
  url: "https://media-exp1.licdn.com/dms/image/C4E03AQHroMBQkQzTLg/profile-displayphoto-shrink_800_800/0/1603581812423?e=1616630400&v=beta&t=rSUHyW_mUFLyLZhkB21WswIQMD_HZXG_ZVHZLxUfxaY"
);

Person detected = isaiah;

List<Person> people = [
  isaiah, ammaar, emily, muntaser
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
