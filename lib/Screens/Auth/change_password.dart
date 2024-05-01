import 'package:flutter/material.dart';
import 'package:tasel/Widgets/my_button.dart';
import '../../service/auth_service.dart';
import '../../theme/colors.dart';
import 'login.dart';

class ChangePasswordPage extends StatefulWidget {
  final TextEditingController nameController;

  final String code;
  final String email;
  const ChangePasswordPage(
      {super.key, required this.nameController, required this.code, required this.email});
  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController conPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;
  bool match = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  icon: const Icon(Icons.keyboard_backspace_sharp),
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Change Your Password',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.topLeft,
                child: const Text(
                  "Don't worry about your account",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.grey,
                        ),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: AppColors.lightGrey,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.darkYellow),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: AppColors.yellow,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      fillColor: Colors.grey[850],
                      filled: true,
                    ),
                    obscureText: !isPasswordVisible,
                    style: AppFont.textFieldStyle,
                    cursorColor: AppColors.yellow,
                    onSubmitted: (_) {
                      //todo _signInButtonPressed();
                    },
                  ),
                ),
              ),
              //////////////////////////////////*
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        if (value == passwordController.text) {
                          match = true;
                        } else {
                          match = false;
                        }
                      });
                    },
                    controller: conPasswordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50),
                        ),
                        borderSide: BorderSide(
                          color: AppColors.grey,
                        ),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(
                        color: AppColors.lightGrey,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: AppColors.yellow,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                      focusedBorder: match
                          ? const OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 1.0),
                            )
                          : OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(
                                  color: AppColors.yellow, width: 1.0),
                            ),
                      fillColor: Colors.grey[850],
                      filled: true,
                    ),
                    obscureText: !isPasswordVisible,
                    style: AppFont.textFieldStyle,
                    cursorColor: AppColors.yellow,
                    onSubmitted: (_) {
                      //todo _signInButtonPressed();
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Button(
                    text: 'Submit',
                    onPressed: () async {
                      if (passwordController.text.isEmpty ||
                          conPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please fill in all fields")),
                        );
                        return;
                      } else if (match != true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please reconfirm your password")),
                        );
                        return;
                      } else {
                        var status = await changePassword(widget.email,
                            widget.code, passwordController.text);
                            print(widget.email);
                            print(widget.code);
                        if (status[0] == true) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("The Password Changed Successfully")),
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$status")),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
