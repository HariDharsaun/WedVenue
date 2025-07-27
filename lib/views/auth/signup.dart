import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double media_height = MediaQuery.of(context).size.height;
    double media_width = MediaQuery.of(context).size.width;
    ColorScheme theme = Theme.of(context).colorScheme;
    TextEditingController name_controller = TextEditingController();
    TextEditingController phone_controller = TextEditingController();
    TextEditingController loc_controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding : EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(20),
              alignment: Alignment.topCenter,
              width: media_width*0.9,
              height: media_height*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: BoxBorder.all(
                  width: .5,
                  color: Colors.grey.shade500
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Join WedVenue",),
                  Text('Create your account to start booking venues',style: TextStyle(color:Colors.grey.shade600)),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Full Name"),
                       textfield("Enter your full Name",name_controller,TextInputType.text)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Phone Number"),
                       textfield("+91 123 456 7890",phone_controller,TextInputType.phone)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Location (optional)"),
                       textfield("City , State",loc_controller,TextInputType.text)
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  sendotpButton((){}),
                  Expanded(child: SizedBox(height: double.infinity,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account ?',style: TextStyle(color: Colors.grey.shade600)),
                      SizedBox(width: 5,),
                      GestureDetector(onTap:(){}, child: Text('Sign in',style: TextStyle(color: Colors.grey),))
                    ],
                  )
                ],
              ),
            ),
            ),
          ),
      ]
      )
    );
  }

  Widget sendotpButton(Callback func)
  {
    return GestureDetector(
      onTap: func,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("Send OTP",style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget textfield(String content,TextEditingController controller,TextInputType inputtype)
  {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: content,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 2
        ), 
      ),
      ),
      keyboardType: inputtype,
    );
  }
}