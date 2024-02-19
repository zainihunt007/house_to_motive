import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:house_to_motive/utils/utils.dart';
import 'package:house_to_motive/views/login/loginwith_email.dart';
import '../../widgets/custom_field.dart';
import '../../widgets/custom_socialbutton.dart';
import '../../widgets/loginbutton.dart';

class UserModel {
  late String userName;
  late String email;
  late String profilePic;

  UserModel({
    required this.userName,
    required this.email,
    required this.profilePic,
  });
}

class SignupController extends GetxController {
  static SignupController get instance => Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      UserModel newUser = UserModel(
        userName: userNameController.text.trim(),
        email: userCredential.user!.email!,
        profilePic: '', // You can set the profile picture here
      );

      await addUserDetails(newUser);
      Get.offAll(() => LoginWithEmailScreen());
      Utils().ToastMessage('Registered successfully');
    } catch (error) {
      Utils().ToastMessage(error.toString());
    }
  }

  Future<void> addUserDetails(UserModel user) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      'User Name': user.userName,
      'Email': user.email,
      'profilePic': user.profilePic,
    });
  }
}

class SignupScreen extends StatefulWidget {
   SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  static final RegExp alphaExp = RegExp('[a-zA-Z]');

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final controller = Get.put(SignupController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: signupFormKey,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.31,
                child: Stack(
                  children: [
                    Opacity(opacity: 0.1,child: Image.asset('assets/pngs/htmimage1.png',),),
                    Positioned(
                      bottom: 80,
                      right: 120,
                      child: SvgPicture.asset(
                        'assets/svgs/splash-logo.svg',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 50,
                      child: InkWell(
                          onTap: () {
                            // Get.back();
                          },
                          child: SvgPicture.asset(
                            'assets/svgs/back_btn.svg',
                          )),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Column(children: [
                  const Text(
                    'Login To Continue',
                    style: TextStyle(
                      fontFamily: 'Mont',
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff025B8F),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    'Welcome back to HouseToMotive!',
                    style: TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff424B5A),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSocialButton(
                          svg: "assets/svgs/social/fb.svg", ontap: () {}),
                      const SizedBox(width: 20),
                      CustomSocialButton(
                          svg: "assets/svgs/social/google.svg", ontap: () {}),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  const Text(
                    'Or with Email',
                    style: TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff424B5A),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.08,
                    child: TextFormField(
                      validator: (value) => value!.isEmpty
                          ? 'Enter Your Name'
                          : (alphaExp.hasMatch(value)
                          ? null
                          : 'Only Alphabets are allowed in a username'),
                      controller: controller.userNameController,
                      decoration: const InputDecoration(
                        hintText: 'User Name',
                        hintStyle: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7390A1),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomEmailField(
                    textEditingController: controller.emailController,
                    title: 'Email',
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomPasswordField(
                    title: 'Enter password',
                    textEditingController: controller.passwordController,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  CustomButton(
                    title: "Continue",
                    ontap: () {
                      if (signupFormKey.currentState!.validate()) {
                        controller.signUp();
                      }
                      // Get.to(() => const SignupWithPhoneNumberScreen());
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Have an Account? ',
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff424B5A),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => LoginWithEmailScreen());
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff025B8F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class UserModel {
//   final String id;
//   final String username;
//   final String email;
//
//   UserModel({
//     required this.id,
//     required this.username,
//     required this.email,
//   });
// }


