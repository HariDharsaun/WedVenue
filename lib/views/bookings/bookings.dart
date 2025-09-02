import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/get%20controllers/booking.dart';
import 'package:hall_booking_app/models/venuemodel.dart';

class BookingPage extends StatelessWidget {
  final VenueModel venue;
  final DateTime bookedDate;
  // ignore: non_constant_identifier_names
  final Bookings_controller = Get.find<booking_History>();

  BookingPage({super.key, required this.venue, required this.bookedDate});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking Details"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent, // matches VenueDetailsPage
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Venue Image
            Container(
              color: Colors.blueGrey,
              height: screenHeight * 0.23,
              width: double.infinity,
              child: Text("Hall Image"),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Venue Name
            Text(
              venue.name,
              style: TextStyle(
                fontSize: screenWidth * 0.048, // same as VenueDetails
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),
            Divider(thickness: 1, color: Colors.grey.shade300),

            SizedBox(height: screenHeight * 0.02),

            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: screenWidth * 0.045,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    venue.location,
                    style: TextStyle(
                      fontSize: screenWidth * 0.036,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            // Price
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.green,
                  size: screenWidth * 0.045,
                ),
                const SizedBox(width: 8),
                Text(
                  venue.price,
                  style: TextStyle(
                    fontSize: screenWidth * 0.044,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            // Phone Number
            Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.purple,
                  size: screenWidth * 0.045,
                ),
                const SizedBox(width: 8),
                Text(
                  venue.phno,
                  style: TextStyle(fontSize: screenWidth * 0.036),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),

            // Booked Date
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                  size: screenWidth * 0.045,
                ),
                const SizedBox(width: 8),
                Text(
                  "${bookedDate.day}-${bookedDate.month}-${bookedDate.year}",
                  style: TextStyle(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.04),

            // Soft card summary
            Container(
              padding: EdgeInsets.all(screenWidth * 0.035),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.event_available,
                    color: Colors.purple,
                    size: screenWidth * 0.06,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Get ready! Tap confirm to finalize your booking.",
                      style: TextStyle(
                        fontSize: screenWidth * 0.034,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Get.defaultDialog(
              title: "Confirm Booking",
              middleText: "Do you want to confirm booking for ${venue.name}?",
              textConfirm: "Confirm",
              textCancel: "Cancel",
              confirmTextColor: Colors.white,
              cancelTextColor: Colors.purple,
              buttonColor: Colors.purple,
              onConfirm: () async {
                Get.back();

                Get.snackbar(
                  "Booking",
                  "Saving your booking...",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.blue,
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(12),
                  borderRadius: 12,
                  duration: const Duration(seconds: 1),
                );

                try {
                  await Bookings_controller.bookVenue(venue, bookedDate);

                  AwesomeDialog(
                    context: Get.context!,
                    dialogType: DialogType.success,
                    animType: AnimType.bottomSlide,
                    title: 'Booking Confirmed',
                    desc: 'Your booking is successfully saved!',
                    btnOkOnPress: () {},
                  ).show();

                } catch (e) {
                  Get.snackbar(
                    "Error",
                    "Failed to save booking: $e",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(12),
                    borderRadius: 12,
                  );
                }
              },
              onCancel: () => Get.back(),
            );
          },
          child: Text(
             "Confirm Booking",
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
