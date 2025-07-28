import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hall_booking_app/routes/app_routes.dart';
import 'package:hall_booking_app/services/auth_services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isPhone = true;
  AuthService auth_service = AuthService();

  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController loc_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double media_height = MediaQuery.of(context).size.height;
    double media_width = MediaQuery.of(context).size.width;
    ColorScheme theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.topCenter,
                width: media_width * 0.9,
                height: media_height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: .5,
                    color: Colors.grey.shade500,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Join WedVenue"),
                    Text(
                      'Create your account to start booking venues',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Full Name"),
                        textfield("Enter your full name", name_controller, TextInputType.text),
                      ],
                    ),
                    SizedBox(height: 10),
                    toggle(theme.secondary),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(isPhone ? "Phone Number" : "Email"),
                        textfield(
                          isPhone ? "+91 123 456 7890" : "example@gmail.com",
                          isPhone ? phone_controller : email_controller,
                          isPhone ? TextInputType.phone : TextInputType.emailAddress,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location (optional)"),
                        textfield("City, State", loc_controller, TextInputType.text),
                      ],
                    ),
                    SizedBox(height: 30),
                    sendotpButton(() {
                      // String phone = phone_controller.text.trim();
                      // if (phone.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phone)) {
                      //   auth_service.sendOtp("+91$phone");
                      // } else {
                      //   Get.snackbar("Invalid Phone", "Enter a valid 10-digit phone number");
                      // }
                      Get.toNamed(AppRoutes.otp);
                    }),
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?', style: TextStyle(color: Colors.grey.shade600)),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {},
                          child: Text('Log in', style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget toggle(Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isPhone = true),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isPhone ? color : Colors.transparent,
                ),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.phone_outlined,color: Colors.black),
                    SizedBox(width: 20,),
                    Text('Phone',style: TextStyle(color: Colors.black),)
                  ]
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isPhone = false),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: !isPhone ? color: Colors.transparent,
                ),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(Icons.email_outlined,color: Colors.black,),
                    SizedBox(width: 20,),
                    Text('Email',style: TextStyle(color: Colors.black))
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sendotpButton(Callback func) {
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
          "Send OTP",
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
