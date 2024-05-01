import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasel/Screens/Auth/sign_up_customer.dart';
import 'package:tasel/Screens/home_page.dart';
import 'package:tasel/Widgets/my_button.dart';
import 'package:tasel/Widgets/my_text_field.dart';
import '../../service/Injections/get_it_inject.dart';
import '../../theme/colors.dart';
import '../../service/auth_service.dart';
import 'forget_password.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import 's_u_choosing.dart';
import 'sign_up_provider.dart';

TextEditingController name = TextEditingController();
TextEditingController password = TextEditingController();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = false;
  bool type = true;

  void _signInButtonPressed() async {
    var status = await login(name.text, password.text);

    if (status == true) {
      getIt.get<SharedPreferences>().setBool('isAuthenticated', true);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (status[0] == false) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${status[1]}")),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$status")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/tasel.png', height: 120),
              const Text(
                'Welcome back!',
                style: TextStyle(
                    // color: AppColors.yellow,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontSize: 35),
              ),
              const Text(
                'Log in to your existant account',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              LiteRollingSwitch(
                value: type,
                colorOn: AppColors.grey,
                colorOff: AppColors.yellow,
                textOn: 'Customer',
                textOff: 'Provider',
                textOnColor: Colors.white,
                iconOn: Icons.person,
                iconOff: Icons.store_mall_directory_sharp,
                onTap: () {
                  type = !type;
                },
                onDoubleTap: () {
                  type = !type;
                },
                onSwipe: () {
                  type = !type;
                },
                onChanged: (type) {
                  print("the button is $type");
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTextField(
                      controller: name,
                      title: 'E-mail',
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
                          controller: password,
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
                              borderSide:
                                  BorderSide(color: AppColors.darkYellow),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[850],
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
                          ),
                          obscureText: !isPasswordVisible,
                          style: AppFont.textFieldStyle,
                          cursorColor: AppColors.yellow,
                          onSubmitted: (_) {
                            _signInButtonPressed();
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordPage(),
                                ),
                              );
                            },
                            child:
                                Text('Forgot password?', style: AppFont.cairoS),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Button(
                          text: 'Log In',
                          onPressed: _signInButtonPressed,
                        )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ?",
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      if (type) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      } else if (type == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpProvider(),
                          ),
                        );
                      }
                    },
                    child: Text('Sing Up', style: AppFont.cairoS),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
