import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
//
class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "Password",
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}


class CustomEmailField extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();
  RxBool showTick = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(()=> SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            // Hint text for the TextFormField
            hintText: "Email",
            contentPadding: EdgeInsets.all(10),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            // Display an icon based on the condition
            suffixIcon: showTick.value
                ? const Icon(
              Icons.check,
              color: Colors.green,
            )
                : null,
          ),
          validator: (value) {
            // Define a regular expression for email validation
            RegExp regex = RegExp(
              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
            );

            // Check if the entered email is valid
            if (value == null || value.isEmpty) {
              return 'Email is required';
            } else if (!regex.hasMatch(value)) {
              return 'Enter a valid email address';
            } else {
              return null; // Return null if the email is valid
            }
          },
          onChanged: (value) {
              // Update the showTick variable based on email validity
              showTick.value = textEditingController.text.isNotEmpty &&
                  RegExp(
                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                  ).hasMatch(textEditingController.text);
          },
        ),
    ),
    );
  }
}