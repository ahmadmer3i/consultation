class PaymentData {
  String? id;
  String? status;
  int? amount;
  String? amountFormat;
  String? createdAt;
  Source? source;
  PaymentData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    status = json["status"];
    amount = json["amount"];
    createdAt = json["created_at"];
    amountFormat = json["amount_format"];
    source = Source.fromJson(json);
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "payment_status": "success",
      "amountFormat": amountFormat,
      "createdAt": createdAt,
      "sourceType": source!.type,
      "sourceCompany": source!.company,
      "sourceName": source!.name,
      "sourceNumber": source!.number,
      "transactionUrl": source!.transactionUrl,
    };
  }
}

class Source {
  String? type;
  String? company;
  String? name;
  String? number;
  String? transactionUrl;
  Source.fromJson(Map<String, dynamic> json) {
    type = json["source"]["type"];
    company = json["source"]["company"];
    name = json["source"]["name"];
    number = json["source"]["number"];
    transactionUrl = json["source"]["transaction_url"];
  }
}
