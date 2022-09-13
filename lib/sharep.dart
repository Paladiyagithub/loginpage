

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

get()
{
  bool resulte = InternetConnectionChecker().hasConnection as bool;

  return resulte;
}

class share
{
  static SharedPreferences? sp;
}