import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/get%20controllers/venue.dart';
import 'package:hall_booking_app/routes/app_routes.dart';

class VenueListPage extends StatelessWidget {
  final VenueController venueController = Get.put(VenueController());

  VenueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Find Your Venue"),
        centerTitle: true,
      ),
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.all(screenWidth * 0.03),
          itemCount: venueController.venues.length,
          itemBuilder: (context, index) {
            final venue = venueController.venues[index];
            return Card(
              margin: EdgeInsets.only(bottom: screenHeight * 0.02),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Venue Image
                  Stack(
                    children: [
                      //Venue Images
                      // ClipRRect(
                      //   borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      //   child: Image.asset(
                      //     venue.imageUrl,
                      //     height: screenHeight * 0.25,
                      //     width: double.infinity,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      Container(
                        color: Colors.blueGrey,
                        height: screenHeight * 0.25,
                        width: double.infinity,
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02,
                            vertical: screenHeight * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: venue.available ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            venue.available ? "Available" : "Booked",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.035, // responsive font
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Venue Details
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue.name,
                          style: TextStyle(
                            fontSize: screenWidth * 0.042, // responsive font
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: screenWidth * 0.045, color: Colors.grey),
                            SizedBox(width: screenWidth * 0.02),
                            Expanded(
                              child: Text(
                                venue.location,
                                style: TextStyle(fontSize: screenWidth * 0.032),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Icon(Icons.people, size: screenWidth * 0.045, color: Colors.grey),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              venue.capacity,
                              style: TextStyle(fontSize: screenWidth * 0.032),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Icon(Icons.star, size: screenWidth * 0.045, color: Colors.amber),
                            SizedBox(width: screenWidth * 0.02),
                            Text("${venue.rating}",
                                style: TextStyle(fontSize: screenWidth * 0.035)),
                            SizedBox(width: screenWidth * 0.04),
                            Text(
                              venue.price,
                              style: TextStyle(
                                fontSize: screenWidth * 0.040,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),

                        // Facilities
                        Wrap(
                          spacing: screenWidth * 0.02,
                          children: venue.facilities.map((f) {
                            return Chip(
                              side: BorderSide(
                                style: BorderStyle.none,
                              ),
                              label: Text(
                                f,
                                style: TextStyle(fontSize: screenWidth * 0.025,color: Colors.black),
                              ),
                              backgroundColor: Colors.grey.shade200,
                            );
                          }).toList(),
                        ),

                        SizedBox(height: screenHeight * 0.015),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.010,
                              ),
                              backgroundColor: Colors.purple
                            ),
                            onPressed: () {
                              Get.toNamed(AppRoutes.viewDetails,arguments: venue);
                            },
                            child: Text(
                              "View Details",
                              style: TextStyle(fontSize: screenWidth * 0.025,color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
