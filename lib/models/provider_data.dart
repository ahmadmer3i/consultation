class ProviderData {
  String? email;
  String? name;
  String? password;

  ProviderData({
    required this.password,
    required this.email,
    required this.name,
  });

  ProviderData.fromJson(Map<String, dynamic> json) {
    password = json["password"];
    email = json["email"];
    name = json["name"];
  }
}
