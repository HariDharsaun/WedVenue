class Usermodel {
  final String name;
  final String email;
  final String phonenumber;

  Usermodel({
    required this.name,
    required this.email,
    required this.phonenumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    };
  }

  factory Usermodel.fromJson(Map<String, dynamic> map) {
    return Usermodel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
    );
  }
}
