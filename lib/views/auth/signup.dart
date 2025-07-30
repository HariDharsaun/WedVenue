import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hall_booking_app/get%20controllers/auth.dart';
import 'package:hall_booking_app/routes/app_routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isPhone = true;
  bool _obscurePassword = true;

  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController pwd_controller = TextEditingController();
  final auth_controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    double media_height = MediaQuery.of(context).size.height;
    double media_width = MediaQuery.of(context).size.width;

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
                padding: EdgeInsets.all(10),
                width: media_width * 0.9,
                height: media_height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: .5, color: Colors.grey.shade500),
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

                    //Full Name
                    Text("Full Name"),
                    textfield("eg: John Doe", name_controller, TextInputType.text),
                    SizedBox(height: 10),

                    //Email
                    Text("Email"),
                    textfield("example@gmail.com", email_controller, TextInputType.emailAddress),
                    SizedBox(height: 10),

                    //Password
                    Text("Password"),
                    TextField(
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Colors.black),
                      controller: pwd_controller,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "eg: John@123",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    //Phone
                    Text("Phone Number"),
                    textfield("+91 123 456 7890", phone_controller, TextInputType.phone),
                    SizedBox(height: 20),

                    // //Location
                    // Text("Location (optional)"),
                    // textfield("City, State", loc_controller, TextInputType.text),
                    // SizedBox(height: 30),

                    registerButton(() {
                      if (signupValidation()) {
                        auth_controller.createAccount(name_controller.text.trim(), email_controller.text.trim(), pwd_controller.text.trim(), phone_controller.text.trim());
                      }
                    }),

                    Expanded(child: SizedBox()),

                    //Login text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?', style: TextStyle(color: Colors.grey.shade600)),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed(AppRoutes.login);
                          },
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

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');
    return regex.hasMatch(password);
  }

  bool isValidPhone(String phone)
  {
    final phoneRegex = RegExp(r'^[0-9]+$');
    return phone.length == 10 && phoneRegex.hasMatch(phone);
  }

  bool signupValidation()
  {
    if(name_controller.text.isEmpty || email_controller.text.isEmpty || phone_controller.text.isEmpty)
    {
      Get.snackbar("Empty Field", "All fields are required!",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red.shade300,colorText: Colors.white,);
      return false;
    }
    else if(!isValidEmail(email_controller.text.trim()))
    {
      Get.snackbar("Invalid Email", "Please enter a valid email",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red.shade300,colorText: Colors.white);
      return false;
    }
    else if(!isValidPassword(pwd_controller.text.trim()))
    {
      if(pwd_controller.text.trim().length < 6)
      {
       Get.snackbar("Invalid password", "Password must contains atleast 6 characters",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red.shade300,colorText: Colors.white); 
      }
      else{
        Get.snackbar("Invalid password", "Password must contains 1 special character with letters & numbers",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red.shade300,colorText: Colors.white);
      }
      return false;
    }
    else if(!isValidPhone(phone_controller.text.trim()))
    {
      Get.snackbar("Invalid phone", "Please enter a valid phone number",snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red.shade300,colorText: Colors.white);
      return false;
    }
    return true;
  }

  Widget registerButton(Callback func) {
    return GestureDetector(
      onTap: func,
      child: Obx(()=>Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(10),
        ),
        child: auth_controller.isLoading.value? CircularProgressIndicator(color: Colors.white,): Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),)
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
