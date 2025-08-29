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
  final String about;
  final List<DateTime> bookedDates;

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
    required this.phno,
    required this.about,
    required this.bookedDates

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
      'phno': phno,
      'about':about,
      'bookedDates': bookedDates.map((d) => d.toIso8601String()).toList(),
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
      phno: map['phno']??'',
      about: map['about']??'',
      bookedDates: (map['bookedDates'] as List<dynamic>? ?? [])
        .map((d) => DateTime.parse(d as String))
        .toList(),
    );
  }
}
