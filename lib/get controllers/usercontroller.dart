import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Usercontroller extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var username  = "".obs;
  var email = "".obs;
  var phno = "".obs;
  // var avatarPath = "".obs;
  var isEditing = false.obs;
  var isLoading = false.obs;

  // List<String> default_avatars = [];

  @override
  onInit()
  {
    super.onInit();
    loadUser();
  }
  Future<void> loadUser () async 
  {
    isLoading(true);
    final String? uid = auth.currentUser?.uid;
    final doc = await firestore.collection("Users").doc(uid).get();
    if(doc.exists)
    {
      username.value = doc['name'];
      email.value = doc['email'];
      phno.value = doc['phonenumber'];
    }
    isLoading(false);
  }

  Future<void> editProfile(String name)async
  {
    final String uid = auth.currentUser!.uid;
    await firestore.collection('Users').doc(uid).update({
      'name': name,
    });
    username.value = name;
    isEditing(false);
  }

  // void selectAvatar(String path) {
  //   avatarPath.value = path;
  // }
}
