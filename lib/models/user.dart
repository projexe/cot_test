class User {
  int? id;
  String firstName = '';
  String lastName = '';
  String companyName = '';
  String postCode = '';
  int annualTurnover = 0;
  String mobileNumber = '';

  User(
      {this.id,
      this.firstName = '',
      this.lastName = '',
      this.companyName = '',
      this.postCode = '',
      this.annualTurnover = 0,
      this.mobileNumber = ''});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        companyName = json['companyName'],
        postCode = json['postCode'],
        annualTurnover = json['annualTurnover'],
        mobileNumber = json['mobileNumber'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'companyName': companyName,
        'postCode': postCode,
        'annualTurnover': annualTurnover,
        'mobileNumber': mobileNumber,
      };
}
