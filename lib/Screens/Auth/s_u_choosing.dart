import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasel/Screens/Auth/sign_up_customer.dart';
import 'package:tasel/theme/colors.dart';
import 'login.dart';
import 'sign_up_provider.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.keyboard_backspace_sharp),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            const Text(
              "We're glad you're here!",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const Text(
              "Thank you for joining us!",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Choose what type of user are you:",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.yellow,
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                    label:  Text(
                      'Customer',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColors.grey
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide.none
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(AppColors.yellow),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpProvider(),
                            ),
                          );
                    },
                    icon: const Icon(
                      Icons.store_mall_directory_sharp,
                      color: Colors.white,
                      size: 40,
                    ),
                    label:  Text(
                      'Provider',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: AppColors.yellow,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                        RoundedRectangleBorder(
                          side: BorderSide(width: 2,color:AppColors.yellow ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(const Color.fromRGBO(48, 48, 48, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ),
              ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
