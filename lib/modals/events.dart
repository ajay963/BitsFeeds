class Events {
  String imageUrl;
  String userName;
  String eventName;
  DateTime dateTime;
  String brief;
  String details;
  String rounds;
  String contactsName1;
  String contactsName2;
  String contacts1;
  String contacts2;

  Events(
      {this.userName,
      this.dateTime,
      this.imageUrl,
      this.eventName,
      this.brief,
      this.details,
      this.rounds,
      this.contacts1,
      this.contacts2,
      this.contactsName1,
      this.contactsName2});

  Events.fromMap(Map snapshot, String id)
      : userName = snapshot['dateTime'] ?? '',
        imageUrl = snapshot['ImageUrl'] ?? '',
        eventName = snapshot['ImageUrl'] ?? '',
        dateTime = snapshot['userName'] ?? '',
        brief = snapshot['brief'] ?? '',
        rounds = snapshot['dateTime'] ?? '',
        contacts1 = snapshot['ImageUrl'] ?? '',
        contacts2 = snapshot['userName'] ?? '',
        contactsName1 = snapshot['brief'] ?? '',
        contactsName2 = snapshot['brief'] ?? '';

  toJson() {
    return {
      "userName": userName,
      "imageUrl": imageUrl,
      "dateTime": dateTime,
      "description": eventName,
      "brief": brief,
      "rounds": rounds,
      "contactsName1": contactsName1,
      "contactsName2": contactsName2,
      "contacts1": contacts1,
      "contacts2": contacts2,
    };
  }
}
