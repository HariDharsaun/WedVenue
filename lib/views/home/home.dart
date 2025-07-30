import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController search_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Find Your Venue"),
                    subtitle: Text("Perfect spaces for your special day",style: TextStyle(color: Colors.grey.shade500),),
                    trailing: Icon(Icons.person_outlined),
                  ),
                  searchBar(),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Divider(
                      thickness: .5,
                      color: Colors.grey.shade400,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

 Widget searchBar() {
  return Padding(
    padding: EdgeInsets.only(left: 12,right: 12),
    child: TextField(
      controller: search_Controller,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.grey,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
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
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    ),
  );
}

}