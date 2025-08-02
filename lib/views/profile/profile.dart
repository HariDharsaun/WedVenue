import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/get%20controllers/auth.dart';
import 'package:hall_booking_app/get%20controllers/usercontroller.dart';

class ProfilePage extends StatelessWidget {
  final Usercontroller userController = Get.find<Usercontroller>();
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController username_controller = TextEditingController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    username_controller.text = userController.username.value;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                userController.isEditing.value ? Icons.close : Icons.edit,
              ),
              onPressed: () {
                userController.isEditing.value =
                    !userController.isEditing.value;
              },
            ),
          ),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Card
              userController.isEditing.value ? 
              //Editing card
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFFd053d4),
                          child: Text(
                            _getInitials(userController.username.value),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: textfield("Enter new username", username_controller, TextInputType.name)
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.email_outlined,color: Colors.purple),
                              SizedBox(width: 20,),
                              Text(userController.email.value,style: TextStyle(color: Colors.grey.shade700,),)
                            ]
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Icon(Icons.phone_outlined,color: Colors.purple,),
                              SizedBox(width: 20,),
                              Text(userController.phno.value,style: TextStyle(color: Colors.grey.shade700),)
                            ]
                          ),
                        ],
                      ),
                      ]
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              userController.editProfile(username_controller.text.trim());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFFd053d4),
                              ),
                              child: Text("Save Changes",style: TextStyle(color: Colors.white),),
                            ),
                          )
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              userController.isEditing.value = false;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: BoxBorder.all(
                                  color: Colors.black54,
                                  width: 1
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                              ),
                              child: Text("Cancel",style: TextStyle(color: Colors.black),),
                            ),
                          )
                        ),
                      ],
                    )
                  ]
                  ),
                ),
              )
              // Profile Card
              :Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xFFd053d4),
                        child: Text(
                          _getInitials(userController.username.value),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userController.username.value,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(Icons.email_outlined,color: Colors.purple,),
                                SizedBox(width: 15,),
                                Text(
                                userController.email.value,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              ]
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone,color: Colors.purple,),
                                SizedBox(width: 15,),
                                Text(
                                userController.phno.value,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              ]
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Booking Statistics
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Booking Statistics",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          statColumn("3", "Total Bookings"),
                          statColumn("2", "Upcoming"),
                          statColumn("5", "Favorites"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Settings Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Column(
                  children: [
                    SwitchListTile(
                      value: true,
                      onChanged: (val) {},
                      title: Text("Notifications"),
                      secondary: Icon(Icons.notifications_outlined),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.location_on_outlined),
                      title: Text("Saved Locations"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.favorite_border),
                      title: Text("Favorite Venues"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text("Settings"),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60),
              // Sign Out section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.logout,color: Colors.red),
                  title: Text("Sign Out",style: TextStyle(color: Colors.red),),
                  onTap: () {
                    authController.logout();
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget textfield(String content, TextEditingController controller, TextInputType inputtype) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.grey,
      keyboardType: inputtype,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: content,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }

  Widget statColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }

  /// Function to get initials (First + Last character in uppercase)
  String _getInitials(String name) {
    if (name.isEmpty) return "?";
    List<String> parts = name.trim().split(" ");
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    } else {
      return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
          .toUpperCase();
    }
  }
}
