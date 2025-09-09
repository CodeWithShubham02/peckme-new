import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:peckme/controller/forgot_otp_password.dart';
import 'package:peckme/view/auth/new_password.dart';


import '../../utils/app_constant.dart';
import 'login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String userId;
  String responseMsg = '';

  void requestOtp() async {
    final mobile = userId.trim();
    if (mobile.isNotEmpty) {
      final result = await ForgotOtpPasswordService.getOtp(
        mobile: mobile,
      );
      setState(() {
        if(result.success==1){
          Get.snackbar(
            "Success!",
            "OTP sent successfully (Test OTP: ${result.otp ?? ''})",
            icon:  Image.asset(
              "assets/logo/cmp_logo.png",
              height: 30,
              width: 30,
            ),
            shouldIconPulse: true,     // Small animation on the icon
            backgroundColor:AppConstant.appSnackBarBackground,
            colorText: AppConstant.appTextColor,
            snackPosition: SnackPosition.BOTTOM, // or TOP
            borderRadius: 15,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            duration: const Duration(seconds: 3),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
          Get.to(()=>NewPasswordScreen(userId: mobile,otp:result.otp ?? ''));
          //showCustomBottomSheet(userId,token.userToken.toString(),result.message.toString());
        }else{
          Get.snackbar(
            "Failed!",
            "Something went wrong please connect to the office, Thank You!!",
            icon:  Image.asset(
              "assets/logo/cmp_logo.png",
              height: 30,
              width: 30,
            ),
            shouldIconPulse: true,     // Small animation on the icon
            backgroundColor:AppConstant.appSnackBarBackground,
            colorText: AppConstant.appTextColor,
            snackPosition: SnackPosition.BOTTOM, // or TOP
            borderRadius: 15,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            duration: const Duration(seconds: 3),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeOutBack,
          );
        }
      });
    } else {
      setState(() {
        responseMsg = 'Please enter the fields';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                 Navigator.pop(context);
                },
              ),
              SizedBox(height: 30),
              Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                onChanged: (value){
                  userId=value;
                },
                maxLength: 10,
                validator: (value){
                  if(value!.isEmpty){
                    return 'enter your number';
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'UserId',
                  hintText: 'Your Phone Number',
                  border: OutlineInputBorder(),

                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: InkWell(
                  onTap: () {
                    if(_formKey.currentState!.validate()) {
                      requestOtp();
                    }
                  },
                  child:  Container(
                    height: 50,
                    width: 330,
                    decoration: BoxDecoration(
                        color: AppConstant.appSecondaryColor,
                        borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text('Forgot',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'sens-serif'),)),
                  )
                ),
              ),
              Spacer(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account? "),
                    GestureDetector(
                      onTap: () {
                        // Navigate to login screen
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Login();
                        }));
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
