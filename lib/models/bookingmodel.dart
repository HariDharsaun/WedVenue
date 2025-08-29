class Booking {
  final String id;
  final String name;
  final String price;
  final String location;
  final String imageUrl;
  final String phno;
  final String date;

  Booking({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.phno,
    required this.date,
  });

  factory Booking.fromMap(Map<String, dynamic> map, String documentId) {
    return Booking(
      id: documentId,
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      phno: map['phno'] ?? '',
      date: map['date'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'location': location,
      'imageUrl': imageUrl,
      'phno': phno,
      'date': date,
    };
  }
}
