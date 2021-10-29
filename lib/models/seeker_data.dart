class SeekerData {
  String? email;
  String? date;
  String? gender;
  String? name;
  String? username;
  String? password;
  String? uid;

  SeekerData({
    required this.email,
    required this.gender,
    required this.date,
    required this.name,
    required this.uid,
    required this.username,
    required this.password,
  });

  SeekerData.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    password = json["password"];
    gender = json["gender"];
    uid = json["uid"];
    email = json["email"];
    date = json["dateOfBirth"];
  }
}
