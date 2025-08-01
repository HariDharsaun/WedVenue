class HallModel {
  final String name;
  final String address;
  final String capacity;
  final String price;
  final String ratings;
  final List<String> facilities;
  final bool isBooked;

  HallModel({
    required this.name,
    required this.address,
    required this.capacity,
    required this.price,
    required this.ratings,
    required this.facilities,
    required this.isBooked,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'capacity': capacity,
      'price': price,
      'ratings': ratings,
      'facilities': facilities,
      'isBooked': isBooked,
    };
  }

  factory HallModel.fromMap(Map<String, dynamic> map) {
    return HallModel(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      capacity: map['capacity'] ?? '',
      price: map['price'] ?? '',
      ratings: map['ratings'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      isBooked: map['isBooked'] ?? false,
    );
  }
}
