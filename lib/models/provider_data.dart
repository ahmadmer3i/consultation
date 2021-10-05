class ProviderData {
  String? email;
  String? name;
  String? password;
  String? uid;

  ProviderData({
    required this.password,
    required this.email,
    required this.name,
    required this.uid,
  });

  ProviderData.fromJson(Map<String, dynamic> json) {
    password = json["password"];
    email = json["email"];
    name = json["name"];
    uid = json["uid"];
  }
}
