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
  });
}
