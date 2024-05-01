import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasel/Screens/home_page.dart';
import 'service/Injections/get_it_inject.dart';
import 'Screens/Auth/login.dart';
import 'theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getItInject();

  final sharedPreferences = getIt<SharedPreferences>();
  bool isAuthenticated = sharedPreferences.getBool('isAuthenticated') ?? false;

  runApp(MyApp(isAuthenticated: isAuthenticated));
}

const url = 'http://localhost:3003';
String userId = '';

class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({Key? key, required this.isAuthenticated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasel',
      themeMode: ThemeMode.dark, 
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        primaryColorDark: AppColors.yellow,
        textTheme: ThemeData.dark(useMaterial3: true).textTheme.copyWith(
          bodyLarge: const TextStyle(
            fontFamily: 'Cairo', 
          ),
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.yellow),
        fontFamily: 'Cairo',
        useMaterial3: true,
        primaryColorDark: AppColors.yellow,
      ),
      home: /*isAuthenticated ? const HomePage() :*/ const LoginPage(),
    );
  }
}
