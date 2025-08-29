import 'package:get/get.dart';
import 'package:hall_booking_app/models/venuemodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VenueController extends GetxController {
  var venues = <VenueModel>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
 void onInit() {
  super.onInit();
  _checkAndSaveVenues();
}

Future<void> _checkAndSaveVenues() async {
  var snapshot = await _firestore.collection('venues').get();

  if (snapshot.docs.isEmpty) {
    await saveVenuesToFirestore();
  }
  // await saveVenuesToFirestore();
  await fetchVenues();
}

  Future<void> saveVenuesToFirestore() async {
    final demoVenues = [
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
        phno: '98857 84984',
        about: 'Elegant banquet hall perfect for grand weddings.',
        bookedDates: [DateTime(2025, 8, 31)],
      ),
      VenueModel(
        id: "2",
        name: "Sunset Garden",
        location: "Bandra, Mumbai",
        capacity: "300 guests",
        price: "₹90,000",
        rating: 4.5,
        imageUrl: "assets/venue_images/venue_two.jpeg",
        facilities: ["Catering", "Decoration", "AC", "Parking"],
        available: false,
        phno: '78934 12345',
        about: 'Grand wedding hall best suitable for weddings.',
        bookedDates: []
      ),
    ];

    for (var venue in demoVenues) {
      await _firestore.collection("venues").doc(venue.id).set(venue.toJson());
    }
  }

  Future<void> fetchVenues() async {
    var snapshot = await _firestore.collection("venues").get();
    venues.value =
        snapshot.docs.map((doc) => VenueModel.fromJson(doc.data())).toList();
  }
}