import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/models/venuemodel.dart';
import 'package:hall_booking_app/routes/app_routes.dart';
import 'package:table_calendar/table_calendar.dart';

class VenueDetailsPage extends StatefulWidget {
  final VenueModel venue;

  const VenueDetailsPage({super.key, required this.venue});

  @override
  State<VenueDetailsPage> createState() => _VenueDetailsPageState();
}

class _VenueDetailsPageState extends State<VenueDetailsPage> {
  DateTime focused_Day = DateTime.now();
  DateTime Selected_Day = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Venue Details",),
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
                      color: widget.venue.available ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.venue.available ? "Available" : "Booked",
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
              widget.venue.name,
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
                    widget.venue.location,
                    style: TextStyle(fontSize: screenWidth * 0.036, color: Colors.black87),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Icon(Icons.people, color: Colors.grey, size: screenWidth * 0.045),
                SizedBox(width: screenWidth * 0.012),
                Text(
                  widget.venue.capacity,
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
                  "${widget.venue.rating}",
                  style: TextStyle(fontSize: screenWidth * 0.036, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  widget.venue.price,
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
              widget.venue.about,
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
              children: widget.venue.facilities.map((f) {
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
            TableCalendar(
              focusedDay: focused_Day,
              firstDay: DateTime.now(),
              lastDay: DateTime(DateTime.now().year, DateTime.now().month + 5, DateTime.now().day),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),

              selectedDayPredicate: (day) { 
                return isSameDay(Selected_Day, day);
              },

              onDaySelected: (selectedDay, focusedDay) {
                 bool isBooked = widget.venue.bookedDates.any((bookedDay)=>isSameDay(selectedDay, bookedDay));
                if(isBooked){
                  Get.snackbar(
                    'Unavailable', 'This Date is already booked!',
                    snackPosition: SnackPosition.BOTTOM,
                    snackStyle: SnackStyle.FLOATING,
                    backgroundColor: Colors.red.shade400,
                    colorText: Colors.white
                  );
                  return;
                }
                setState(() {
                  focused_Day = focusedDay;
                  Selected_Day = selectedDay;
                });
              },

              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  for (var booked in widget.venue.bookedDates) {
                    if (day.year == booked.year &&
                        day.month == booked.month &&
                        day.day == booked.day) {
                      return Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  }
                  return null;
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            // CalendarDatePicker(
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime.now(),
            //   lastDate: DateTime(DateTime.now().year,DateTime.now().month+6,DateTime.now().day),
            //   selectableDayPredicate: (day){
            //     for(var date in venue.bookedDates){
            //       if(date.year == day.year && date.month == day.month && date.day == day.day) return false;
            //     }
            //     return true;
            //   },
            //   onDateChanged: (date) {
            //     print("Selected Date: $date");
            //   },
            // ),
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
                subtitle: Text(widget.venue.phno, style: TextStyle(fontSize: screenWidth * 0.032)),
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
            // Get.snackbar("Booking", "Venue booked successfully!",
            //     snackPosition: SnackPosition.BOTTOM,
            //     backgroundColor: Colors.green,
            //     colorText: Colors.white);

            Get.toNamed(AppRoutes.booking,arguments: {'venue':widget.venue,'selectedDate':Selected_Day});
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
