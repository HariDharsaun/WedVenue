import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/get controllers/booking.dart';
import 'package:lottie/lottie.dart';

class BookingHistoryPage extends StatelessWidget {
  final booking_History controller = Get.put(booking_History());

  BookingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Bookings"),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.purple,
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Current"),
              Tab(text: "Previous"),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.loading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            children: [
              // Current Bookings
              _buildBookingList(controller.curr_bookings, screenWidth, screenHeight),

              // Previous Bookings
              _buildBookingList(controller.prev_bookings, screenWidth, screenHeight),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildBookingList(List bookings, double screenWidth, double screenHeight) {
    if (bookings.isEmpty) {
      return Center(child: Lottie.asset(
        "assets/lotties/no result found.json",
        width: screenWidth,   // 60% of screen width
        height: screenHeight, // 30% of screen height
        fit: BoxFit.contain,
      ),);
    }

    return ListView.builder(
      padding: EdgeInsets.all(screenWidth * 0.04),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        var booking = bookings[index];
        return Card(
          margin: EdgeInsets.only(bottom: screenHeight * 0.02),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Venue Name
                Text(
                  booking["name"],
                  style: TextStyle(
                    fontSize: screenWidth * 0.044,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Location
                Row(
                  children: [
                    Icon(Icons.location_on, size: screenWidth * 0.045, color: Colors.red),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        booking["location"],
                        style: TextStyle(fontSize: screenWidth * 0.034, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),

                // Price
                Row(
                  children: [
                    Icon(Icons.attach_money, size: screenWidth * 0.045, color: Colors.green),
                    SizedBox(width: 6),
                    Text(
                      booking["price"],
                      style: TextStyle(
                        fontSize: screenWidth * 0.036,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),

                // Date
                Row(
                  children: [
                    Icon(Icons.calendar_month, size: screenWidth * 0.045, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(
                      booking["bookedDate"].toString().split("T")[0],
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),

                // Phone
                Row(
                  children: [
                    Icon(Icons.phone, size: screenWidth * 0.045, color: Colors.purple),
                    SizedBox(width: 6),
                    Text(
                      booking["managerPhone"],
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
