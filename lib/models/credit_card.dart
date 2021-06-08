/// Data class representing a user credit card
class CreditCard {
  int id;
  String fullName = '';
  String companyName = '';
  String cardNumber = '';
  DateTime? expiryDate;
  int customerId;
  bool isFrozen;

  CreditCard(
      {this.id = 0,
      this.fullName = '',
      this.companyName = '',
      this.cardNumber = '',
      this.expiryDate,
      this.customerId = 0,
      this.isFrozen = true});

  CreditCard.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fullName = json['fullName'],
        companyName = json['companyName'],
        cardNumber = json['cardNumber'],
        expiryDate = DateTime.tryParse(json['expiryDate'] ?? ''),
        customerId = json['customerId'],
        isFrozen = json['isFrozen'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullname': fullName,
        'companyName': companyName,
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'customerId': customerId,
        'isFrozen': isFrozen,
      };
}
