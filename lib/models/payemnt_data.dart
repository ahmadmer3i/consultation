class PaymentData {
  String? id;
  String? status;
  String? amount;
  String? amountFormat;
  String? createdAt;
  Source? source;
  PaymentData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    status = json["status"];
    amount = json["amount"];
    createdAt = json["created_at"];
    source = Source.fromJson(json);
  }
}

class Source {
  String? type;
  String? company;
  String? name;
  String? number;
  String? transactionUrl;
  Source.fromJson(Map<String, dynamic> json) {
    type = json["type"];
    company = json["company"];
    name = json["name"];
    number = json["number"];
    transactionUrl = json["transaction_url"];
  }
}
