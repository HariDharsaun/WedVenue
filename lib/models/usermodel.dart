class Usermodel {
  final String name;
  final String email;
  final String phonenumber;
  final List<Map<String,dynamic>> bookings;

  Usermodel({
    required this.name,
    required this.email,
    required this.phonenumber,
    required this.bookings
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
      'bookings':bookings
    };
  }

  factory Usermodel.fromJson(Map<String, dynamic> map) {
    return Usermodel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phonenumber: map['phonenumber'] ?? '',
      bookings: map['bookings'] ?? []
    );
  }
}
