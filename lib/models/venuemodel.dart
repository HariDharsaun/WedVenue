class VenueModel {
  final String id;
  final String name;
  final String location;
  final String capacity;
  final String price;
  final double rating;
  final String imageUrl;
  final List<String> facilities;
  final bool available;
  final String phno;

  VenueModel({
    required this.id,
    required this.name,
    required this.location,
    required this.capacity,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.facilities,
    required this.available,
    required this.phno
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'capacity': capacity,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'facilities': facilities,
      'available': available,
      'phno': phno
    };
  }

  factory VenueModel.fromJson(Map<String, dynamic> map) {
    return VenueModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'] ?? '',
      capacity: map['capacity'] ?? '',
      price: map['price'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      facilities: List<String>.from(map['facilities'] ?? []),
      available: map['available'] ?? false,
      phno: map['phno']??''
    );
  }
}
