class ProviderData {
  String? email;
  String? name;
  String? password;
  String? uid;
  bool? isApproved;
  double? price;
  double? rate;
  String? experience;
  List<dynamic>? topics;
  ProviderData({
    required this.password,
    required this.email,
    required this.name,
    required this.uid,
    required this.isApproved,
    required this.price,
    this.topics,
    this.experience,
    this.rate = 5,
  });
// Custom Constructor
  ProviderData.fromJson(Map<String, dynamic> json) {
    password = json["password"];
    email = json["email"];
    name = json["name"];
    uid = json["uid"];
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
