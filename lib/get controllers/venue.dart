import 'package:get/get.dart';
import 'package:hall_booking_app/models/venuemodel.dart';

class VenueController extends GetxController {
  var venues = <VenueModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadVenues();
  }

  void loadVenues() {
    venues.value = [
      VenueModel(
        id: "1",
        name: "Royal Palace Banquet",
        location: "Downtown, Mumbai",
        capacity: "500 guests",
        price: "₹1,50,000",
        rating: 4.8,
        imageUrl: "assets/venue_images/venue_one.jpg",
        facilities: ["AC", "Parking", "Catering", "Decoration"],
        available: true,
      ),
      VenueModel(
        id: "2",
        name: "Sunset Garden",
        location: "Bandra, Mumbai",
        capacity: "300 guests",
        price: "₹90,000",
        rating: 4.5,
        imageUrl: "assets/venue_images/venue_two.jpeg",
        facilities: ["Catering", "Decoration"],
        available: false,
      ),
    ];
  }
}
