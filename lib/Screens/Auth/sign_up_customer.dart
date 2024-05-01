import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasel/Widgets/my_button.dart';
import 'package:tasel/Widgets/my_text_field.dart';
import '../../service/auth_service.dart';
import '../../theme/colors.dart';
import 'login.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:validators/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController phoneNumController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController conPasswordController = TextEditingController();

  bool isEmailCorrect = false;
  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;
  bool match = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          alignment: Alignment.topLeft,
          child: ListView(
            padding: const EdgeInsets.all(7),
            shrinkWrap: false,
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
                  'Do you want to join us as a User?',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.topLeft,
                child: const Text(
                  "So, welcome... Register here",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyTextField(
                    controller: _nameController,
                    title: 'UserName',
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(Icons.person),
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
                        keyboardType: TextInputType.emailAddress,
                        style: AppFont.textFieldStyle,
                        controller: emailController,
                        onChanged: (val) {
                          setState(() {
                            isEmailCorrect = isEmail(val);
                          });
                        },
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(
                                color: AppColors.grey,
                              ),
                            ),
                            hintText: 'E-mail',
                            hintStyle: TextStyle(
                              color: AppColors.lightGrey,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            prefixIcon: const Icon(Icons.email),
                            prefixIconColor: AppColors.yellow,
                            suffixIcon: isEmailCorrect == false
                                ? null
                                : const Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.darkYellow),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            fillColor: Colors.grey[850],
                            filled: true),
                        cursorColor: AppColors.darkYellow,
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
                      child: IntlPhoneField(
                        showCountryFlag: false,
                        style: AppFont.textFieldStyle,
                        controller: phoneNumController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              color: AppColors.grey,
                            ),
                          ),
                          hintText: 'Phone Number',
                          counterText: '',
                          hintStyle: TextStyle(
                            color: AppColors.lightGrey,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.darkYellow,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          fillColor: Colors.grey[850],
                          filled: true,
                        ),
                        initialCountryCode: 'SY',
                        cursorColor: AppColors.darkYellow,
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
                                  borderSide: BorderSide(
                                      color: Colors.green, width: 1.0),
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

                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Button(
                        text: 'Sign Up',
                        onPressed: () async {
                          if (_nameController.text.isEmpty ||
                              phoneNumController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              passwordController.text.isEmpty ||
                              conPasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please fill in all fields")),
                            );
                            return;
                          }
                          if (_nameController.text.length < 4) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "User Name Can't Be Less Than 4 characters")),
                            );
                            return;
                          }
                          if (!isEmailCorrect) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Email is not correct")),
                            );
                            return;
                          }

                          if (phoneNumController.text.length < 9) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Invalid Mobile Number")),
                            );
                            return;
                          }

                          if (passwordController.text ==
                              conPasswordController.text) {
                            var status = await signup(
                                _nameController.text,
                                emailController.text,
                                phoneNumController.text,
                                5185,
                                5487,
                                passwordController.text);

                            if (status[0] == true) {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("${status[1]}")));
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("$status")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Please reconfirm your password")));
                          }
                        },
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
