import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/models/usermodel.dart';
import 'package:hall_booking_app/routes/app_routes.dart';

class AuthController extends GetxController{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
  }

  bool get isLoggedIn => firebaseUser.value != null;

    //SignUp
    Future<void> createAccount(String name, String email, String password, String phone) async {
    try {
      isLoading.value = true;

      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = Usermodel(
        name: name,
        email: email,
        phonenumber: phone,
      );

      await firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(userModel.toJson());

      Get.snackbar("Success", "Account created successfully");
      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Get.snackbar("Error", "This email is already registered. Please log in.",backgroundColor:Colors.red.shade300,colorText: Colors.white);
      }
      else {
        Get.snackbar("Error", e.message ?? "Account creation failed",backgroundColor:Colors.red.shade300,colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  //Login
   Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Success", "Logged in successfully",backgroundColor: Colors.green,colorText: Colors.white);
      Get.offAllNamed(AppRoutes.home);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login failed",backgroundColor: Colors.red.shade300,colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    await auth.signOut();
  }
}