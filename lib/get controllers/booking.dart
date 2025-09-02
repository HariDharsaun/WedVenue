import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/models/venuemodel.dart';

class booking_History extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  var curr_bookings = [].obs;
  var prev_bookings = [].obs;
  var loading = false.obs;
  var isBookedToday = false.obs;

  @override
  void onInit() {
    fetchBookings();
    super.onInit();
  }

  Future<void> bookVenue(VenueModel venue, DateTime date) async {
      loading(true);
      String uid = _auth.currentUser!.uid;

      Map<String, dynamic> bookingData = {
        "name": venue.name,
        "location": venue.location,
        "price": venue.price,
        "managerPhone": venue.phno,
        "bookedDate": date.toIso8601String(),
        "image": venue.imageUrl
      };

      await _firestore.collection('Users').doc(uid).set({
        "bookings": FieldValue.arrayUnion([bookingData])
      }, SetOptions(merge: true));

      await _firestore.collection('venues').doc(venue.id).set(
        {
          "bookedDates": FieldValue.arrayUnion([date.toIso8601String()])
        }, SetOptions(merge: true)
      );
      loading(false);
      fetchBookings(); 
  }


  void fetchBookings() async {
    String uid = _auth.currentUser!.uid;
    final snapshot = await _firestore.collection('Users').doc(uid).get();

    if (snapshot.exists && snapshot.data()!.containsKey("bookings")) {
      List bookings = snapshot["bookings"];

      curr_bookings.clear();
      prev_bookings.clear();

      DateTime today = DateTime.now();

      for (var b in bookings) {

        DateTime bookedDate = DateTime.parse(b["bookedDate"]);

        if(_isSameOrAfter(bookedDate, today)) {
          curr_bookings.add(b);
        } else {
          prev_bookings.add(b);
        }
      }
    }
  }

  bool _isSameOrAfter(DateTime date, DateTime today) {
    DateTime d1 = DateTime(date.year, date.month, date.day);
    DateTime d2 = DateTime(today.year, today.month, today.day);
    return d1.isAtSameMomentAs(d2) || d1.isAfter(d2);
  }
}