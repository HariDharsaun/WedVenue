import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hall_booking_app/services/auth_services/auth_service.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  // final String phoneNumber;
  // final String verificationId;
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double media_height = MediaQuery.of(context).size.height;
    double media_width = MediaQuery.of(context).size.width;
    ColorScheme theme = Theme.of(context).colorScheme;
    TextEditingController otp_controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(
                  color: Colors.grey
                )
              ),
              width: media_width*0.8,
              height: media_height*0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Verify OTP'),
                  Text('Enter the 4-digit code sent to 9489664261',style: TextStyle(color: Colors.grey.shade500),),
                  SizedBox(height: 30),
                  Text("OTP Code"),
                  textfield("1234", otp_controller, TextInputType.number),
                  SizedBox(height: 40),
                  verifyotpButton((){}),
                  Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: (){},
                      child: Text('Resend OTP',style: TextStyle(color: theme.primary),)
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget verifyotpButton(Callback func) {
    return GestureDetector(
      onTap: func,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Verify & Create Account",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget textfield(String content, TextEditingController controller, TextInputType inputtype) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.grey,
      keyboardType: inputtype,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: content,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
    );
  }
}