import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/models/venuemodel.dart';

class VenueDetailsPage extends StatelessWidget {
  final VenueModel venue;

  const VenueDetailsPage({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Venue Details", style: TextStyle(fontSize: 16)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Venue Image
            Stack(
              children: [
                Container(
                  color: Colors.blueGrey,
                  height: screenHeight * 0.23,
                  width: double.infinity,
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: venue.available ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      venue.available ? "Available" : "Booked",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.032,
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            // Venue Name
            Text(
              venue.name,
              style: TextStyle(
                fontSize: screenWidth * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Location & Capacity
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey, size: screenWidth * 0.045),
                SizedBox(width: screenWidth * 0.012),
                Expanded(
                  child: Text(
                    venue.location,
                    style: TextStyle(fontSize: screenWidth * 0.036, color: Colors.black87),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Icon(Icons.people, color: Colors.grey, size: screenWidth * 0.045),
                SizedBox(width: screenWidth * 0.012),
                Text(
                  venue.capacity,
                  style: TextStyle(fontSize: screenWidth * 0.036, color: Colors.black87),
                ),
              ],
            ),

            SizedBox(height: screenHeight * 0.03),

            // Rating & Price
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.045),
                SizedBox(width: screenWidth * 0.012),
                Text(
                  "${venue.rating}",
                  style: TextStyle(fontSize: screenWidth * 0.036, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  venue.price,
                  style: TextStyle(
                    fontSize: screenWidth * 0.044,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(" / event",
                    style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.032)),
              ],
            ),

            SizedBox(height: screenHeight * 0.045),

            // About
            Text("About this venue",
                style: TextStyle(fontSize: screenWidth * 0.044, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.012),
            Text(
              "Elegant banquet hall perfect for grand weddings with modern facilities and beautiful ambiance.",
              style: TextStyle(fontSize: screenWidth * 0.034, color: Colors.black87, height: 1.5),
            ),

            SizedBox(height: screenHeight * 0.04),

            // Amenities
            Text("Amenities",
                style: TextStyle(fontSize: screenWidth * 0.044, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.015),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: venue.facilities.map((f) {
                return Chip(
                  label: Text(
                    f,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.034,
                        fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: Colors.grey.shade200,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                );
              }).toList(),
            ),

            SizedBox(height: screenHeight * 0.05),

            // Calendar
            Text("Check Availability",
                style: TextStyle(fontSize: screenWidth * 0.044, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.015),
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year,DateTime.now().month+6,DateTime.now().day),
              onDateChanged: (date) {
                print("Selected Date: $date");
              },
            ),
            SizedBox(height: screenHeight * 0.012),
            Text("Available dates are highlighted",
                style: TextStyle(color: Colors.green, fontSize: screenWidth * 0.032)),

            SizedBox(height: screenHeight * 0.045),

            // Contact
            Text("Contact Venue",
                style: TextStyle(fontSize: screenWidth * 0.044, fontWeight: FontWeight.bold)),
            SizedBox(height: screenHeight * 0.015),
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.035, vertical: screenHeight * 0.012),
                leading: Icon(Icons.phone, size: screenWidth * 0.06, color: Colors.purple),
                title: Text("Venue Manager", style: TextStyle(fontSize: screenWidth * 0.036)),
                subtitle: Text(venue.phno, style: TextStyle(fontSize: screenWidth * 0.032)),
                trailing: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  child: Text("Call",
                      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.034)),
                ),
              ),
            ),
          ],
        ),
      ),

      // Book Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Get.snackbar("Booking", "Venue booked successfully!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white);
          },
          child: Text(
            "Book This Venue",
            style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
