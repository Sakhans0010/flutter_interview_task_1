import 'dart:convert';

import '../Config/app_config.dart';
import '../Services/Api Services/http_client.dart';

class HomeDataRepository {
  Future getData({
    required double? latitude,
    required double? longitude,
  }) async {
    String url =
        "${AppConfig.BASE_URL}/nearest_city?lat=$latitude&lon=$longitude&key=${AppConfig.API_KEY}";
    final response = await HttpClient().get(url);

    // final loadedData = jsonDecode(response.body) as Map<String, dynamic>;

    return response;
  }
}
