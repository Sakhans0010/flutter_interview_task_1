import 'package:flutter/material.dart';

var this_year = DateTime.now().year.toString();

class AppConfig {
  static String app_name =
      "Air Quality Index"; //this shows in the splash screen

  static const bool HTTPS = true;

  static const String API_KEY = "933574a3-5e5e-482b-b2d9-6babf217abf5";

//   http://api.airvisual.com/v2/nearest_city?
// lat=35.98&lon=140.33&key=

  static const DOMAIN_PATH =
      "api.airvisual.com"; // directly inside the public folder

  //do not configure these below
  static const String API_ENDPATH = "v2";
  static const String PROTOCOL = 'http://';

  // HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
}
