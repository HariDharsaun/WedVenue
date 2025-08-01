import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/get%20controllers/usercontroller.dart';

class ProfilePage extends StatelessWidget {
  final Usercontroller userController = Get.find<Usercontroller>();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          Obx(() => IconButton(
                icon: Icon(userController.isEditing.value ? Icons.close : Icons.edit),
                onPressed: () {
                  userController.isEditing.value = !userController.isEditing.value;
                },
              )),
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userController.avatarPath.value.isNotEmpty
                        ? AssetImage(userController.avatarPath.value)
                        : null,
                    child: userController.avatarPath.value.isEmpty
                        ? Text(
                            userController.username.isNotEmpty
                                ? userController.username.value[0].toUpperCase()
                                : "?",
                            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),
                  SizedBox(height: 20),
                  userController.isEditing.value
                      ? TextField(
                          controller: TextEditingController(text: userController.username.value),
                          onChanged: (val) => userController.username.value = val,
                          decoration: InputDecoration(labelText: "Username"),
                        )
                      : Text(userController.username.value,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(userController.email.value, style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 5),
                  Text(userController.phno.value, style: TextStyle(color: Colors.grey[600])),

                  SizedBox(height: 20),
                  if (userController.isEditing.value)
                    Column(
                      children: [
                        Text("Select Avatar"),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          children: userController.default_avatars.map((avatar) {
                            return GestureDetector(
                              onTap: () => userController.selectAvatar(avatar),
                              child: Obx(() => Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: userController.avatarPath.value == avatar
                                            ? Colors.blue
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(avatar),
                                    ),
                                  )),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                userController.editProfile(
                                  userController.username.value,
                                );
                              },
                              child: Text("Save Changes"),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {
                                userController.isEditing.value = false;
                                userController.loadUser();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
