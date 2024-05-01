import 'package:flutter/material.dart';
import 'package:tasel/Screens/Auth/verification_page.dart';
import 'package:tasel/Widgets/my_button.dart';
import '../../service/auth_service.dart';
import '../../theme/colors.dart';
import 'login.dart';
import 'package:validators/validators.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  bool isEmailCorrect = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

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
                  'Forgot password?',
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
                child: Text(
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
                          fontSize: 20,
                        ),
                        prefixIcon: const Icon(Icons.email),
                        suffixIcon: isEmailCorrect == false
                            ? null
                            : const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.darkYellow),
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
              Container(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Button(
                      text: 'Next',
                      onPressed: () async {
                        if (emailController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please fill in all fields")),
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
                        var status = await forgetPassword(emailController.text);
                        if (status[0] == true) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerificationPage(
                                  email: emailController.text,
                                      nameController: emailController,
                                    )),
                          );
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(status[1])));
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(status[1])));
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
