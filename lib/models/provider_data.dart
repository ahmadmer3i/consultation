class ProviderData {
  String? email;
  String? name;
  String? password;
  String? uid;
  bool? isInstance;
  bool? isScheduled;
  bool? isApproved;
  double? price;
  String? gender;
  String? birthOfDate;
  double? rate;
  String? experience;
  String? iban;
  List<dynamic>? topics;
  ProviderData({
    required this.birthOfDate,
    required this.password,
    required this.email,
    required this.name,
    required this.uid,
    required this.isApproved,
    required this.price,
    this.topics,
    this.experience,
    this.iban,
    this.rate = 5,
    this.isInstance,
    this.isScheduled,
  });
// Custom Constructor
  ProviderData.fromJson(Map<String, dynamic> json) {
    password = json["password"];
    iban = json["iban"];
    email = json["email"];
    name = json["name"];
    uid = json["uid"];
    isInstance = json["instant"];
    isScheduled = json["scheduled"];
    birthOfDate = json["dateOfBirth"];
    gender = json["gender"];
    experience = json["experience"];
    isApproved = json["isApproved"];
    price = double.parse(json["price"].toString());
    rate = double.parse(json["rate"].toString());
    topics = json["topics"];
  }
}

class Topic {
  String? topic;

  Topic.fromJson(Map<String, dynamic> json) {
    topic = json["topics"];
  }
}
