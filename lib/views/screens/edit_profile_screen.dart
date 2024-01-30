import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/controller/event_controller.dart';
import 'package:house_to_motive/widgets/custom_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../widgets/loginbutton.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final userNameController = TextEditingController();
  final emailController = TextEditingController();

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      var userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();

      return userDocument.data();
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  XFile? _imageFile;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? selected = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = selected;
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> uploadImage() async {
    if (_imageFile == null) return;

    File imageFile = File(_imageFile!.path);
    String fileName = 'profile/${DateTime.now().millisecondsSinceEpoch}_${_imageFile!.name}';

    try {
      await FirebaseStorage.instance
          .ref(fileName)
          .putFile(imageFile);
      final String downloadUrl = await FirebaseStorage.instance
          .ref(fileName)
          .getDownloadURL();

      Future<void> addUserDetails() async {
        Map<String, dynamic> updateData = {};

        // Only add field to updateData if it's changed
        if (userNameController.text.isNotEmpty) {
          updateData['User Name'] = userNameController.text;
        }
        if (emailController.text.isNotEmpty) {
          updateData['Email'] = emailController.text;
        }
        updateData['profilePic'] = downloadUrl;

        if (updateData.isNotEmpty || downloadUrl.isEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(auth.currentUser!.uid)
              .update(updateData).then((value) {
                Get.snackbar('Status', 'Profile Updated');
          });
        }
      }

      addUserDetails();
      print('Download URL: $downloadUrl');
    } on FirebaseException catch (e) {
      // Handle any errors
    }
  }


  @override
  Widget build(BuildContext context) {
    TicketController ticketController = Get.put(TicketController());
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 19,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff025B8F),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Stack(
              children: [
                FutureBuilder(
                  future: fetchUserData(),
                  builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      String? profilePicUrl = snapshot.data?['profilePic'];
                      return profilePicUrl != null
                          ? CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        child: _imageFile != null
                            ? CircleAvatar(
                          radius: 35,
                          backgroundImage: FileImage(File(_imageFile!.path))
                        )
                            : CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(profilePicUrl),
                        ),
                      ) : CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        child: _imageFile != null
                            ? CircleAvatar(
                            radius: 35,
                            backgroundImage: FileImage(File(_imageFile!.path))
                        )
                            : CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/pngs/user_profile.png'),
                        ),
                      );
                    } else {
                      return Text("No user data available");
                    }
                  },
                ),
                // if (_imageFile != null) Image.file(File(_imageFile!.path)),
                Positioned(
                  top: 60,
                  right: 10,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: InkWell(
                      onTap: (){
                        // ticketController.pickedImage();
                        pickImage();
                      },
                      child: const CircleAvatar(
                        // backgroundImage: AssetImage('assets/images/2.jpg'),
                        radius: 8,
                        backgroundColor: Color(0xff025B8F),
                        child: Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            CustomEmailField(title: 'User name',textEditingController: userNameController),
            CustomEmailField(title: 'Email',textEditingController: emailController),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.068,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffD9D9D9)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(
                          number.phoneNumber);
                    },
                    onInputValidated: (bool value) {

                      print(value);
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    // initialValue: _phoneNumber,
                    textFieldController: TextEditingController(),
                    formatInput: false,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    inputDecoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(
                        fontFamily: 'ProximaNova',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff7390A1),),
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(),
                      // ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              title: "Update Profile",
              ontap: () {
                uploadImage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
