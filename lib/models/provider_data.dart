class ProviderData {
  String? email;
  String? name;
  String? password;
  String? uid;
  bool? isApproved;
  double? price;

  ProviderData({
    required this.password,
    required this.email,
    required this.name,
    required this.uid,
    required this.isApproved,
    required this.price,
  });

  ProviderData.fromJson(Map<String, dynamic> json) {
    password = json["password"];
    email = json["email"];
    name = json["name"];
    uid = json["uid"];
    isApproved = json["isApproved"];
    price = json["price"] as double;
  }
}
