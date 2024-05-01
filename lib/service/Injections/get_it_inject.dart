import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> getItInject() async {
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
}
