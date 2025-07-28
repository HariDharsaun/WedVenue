import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hall_booking_app/routes/app_routes.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  void sendOtp(String phoneNumber) {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.toNamed(AppRoutes.otp, arguments: {
          'phoneNumber': phoneNumber,
          'verificationId': verificationId,
        });
        Get.snackbar("OTP Sent", "OTP sent to ${phoneNumber}");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOtp(String verificationId,String otp) async
  {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp
    );

    try{
      await auth.signInWithCredential(credential);
      Get.snackbar("LoggedIn","You loggedin  succesfully!");
      Get.offAll(AppRoutes.home);
      print("User logged In!");
    }
    catch(e)
    {
      Get.snackbar("Invalid OTP", "OTP you have entered is invalid");
    }
  }
}