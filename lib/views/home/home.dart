import 'package:flutter/material.dart';
import 'package:hall_booking_app/models/hallmodel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController search_Controller = TextEditingController();

  final List<HallModel> halls = [
    HallModel(
      name: "Royal Palace Banquet",
      address: "Downtown, Mumbai",
      capacity: "500",
      price: "1,50,000",
      ratings: "4.8",
      facilities: ['AC', 'Parking', 'Catering', 'Decoration'],
      isBooked: false,
    ),
    HallModel(
      name: "Garden Paradise Resort",
      address: "Suburbs, Mumbai",
      capacity: "300",
      price: "2,00,000",
      ratings: "4.9",
      facilities: ['Garden', 'Pool', 'AC', 'Parking'],
      isBooked: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Header
            ListTile(
              title: const Text("Find Your Venue"),
              subtitle: Text(
                "Perfect spaces for your special day",
                style: TextStyle(color: Colors.grey.shade500),
              ),
              trailing: const Icon(Icons.person_outlined),
            ),

            // Search bar
            searchBar(),
            const SizedBox(height: 5),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: .5,
                color: Colors.grey.shade400,
              ),
            ),

            Expanded(
              child: halls.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.no_accounts),
                          SizedBox(height: 10),
                          Text("No halls available to book."),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: halls.length,
                      itemBuilder: (context, index) {
                        final hall = halls[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          elevation: 3,
                          child: ListTile(
                            title: Text(hall.name),
                            subtitle: Text("${hall.address}\nCapacity: ${hall.capacity}"),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("₹${hall.price}"),
                                Text(
                                  "⭐ ${hall.ratings}",
                                  style: const TextStyle(color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: search_Controller,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.grey,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: "Search venues, locations...",
          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    );
  }
}
