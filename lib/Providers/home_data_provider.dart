import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_interview_task_1/Repositories/home_date_repository.dart';

import '../Config/app_config.dart';

import 'package:http/http.dart' as http;

import '../Data Models/home_data_response_model.dart';
import '../Services/Api Services/http_client.dart';

class HomeDataProvider with ChangeNotifier {
  HomeDataResponseModel? homeDataResponseModel;

  String? airQuality = '';

  Future fetchAndSetData({
    required BuildContext? context,
    required double? latitude,
    required double? longitude,
  }) async {
    var response = await HomeDataRepository().getData(
      latitude: latitude,
      longitude: longitude,
    );
    print(response);
    homeDataResponseModel = HomeDataResponseModel.fromJson(response['data']);
    // print(homeDataResponseModel!.city);

    var airQualityInFigure = homeDataResponseModel!.current!.pollution!.aqius!;

    if (airQualityInFigure < 50) {
      airQuality = 'Satisfactory';
    } else if (airQualityInFigure > 50 && airQualityInFigure < 100) {
      airQuality = 'harmful';
    } else {
      airQuality = 'Extremely Harmful';
    }
    notifyListeners();
    return response;
  }
}
