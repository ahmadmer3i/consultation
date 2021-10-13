class ProviderData {
  String? email;
  String? name;
  String? password;
  String? uid;
  bool? isApproved;
  double? price;
  double? rate;
  List<dynamic>? topics;
  ProviderData({
    required this.password,
    required this.email,
    required this.name,
    required this.uid,
    required this.isApproved,
    required this.price,
    this.topics,
    this.rate = 5,
  });

  ProviderData.fromJson(Map<String, dynamic> json) {
    password = json["password"];
    email = json["email"];
    name = json["name"];
    uid = json["uid"];
    isApproved = json["isApproved"];
    price = double.parse(json["price"].toString());
    rate = json["rate"] as double;
    topics = json["topics"];
  }
}

class Topic {
  String? topic;

  Topic.fromJson(Map<String, dynamic> json) {
    topic = json["topics"];
  }
}
