import 'package:flutter/material.dart';
import 'package:flutter_interview_task_1/Providers/home_data_provider.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../Config/size_config.dart';
import '../../Constants/colors.dart';
import '../../Widgets/spacers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _position;

  bool _isLoading = false;
  bool _hasGotError = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    setState(() {
      _isLoading = true;
      _hasGotError = false;
    });
    await getUserCurrentLocation();

    var response = await Provider.of<HomeDataProvider>(context, listen: false)
        .fetchAndSetData(
      context: context,
      latitude: _position!.latitude,
      longitude: _position!.longitude,
    );

    if (response['status'] != 'success') {
      setState(() {
        _isLoading = false;
        _hasGotError = true;
      });
    } else {
      setState(() {
        _isLoading = false;
        _hasGotError = false;
      });
    }
  }

  Future<void> getUserCurrentLocation() async {
    // print('object');
    if (await Permission.location.serviceStatus.isEnabled) {
    } else {
      openAppSettings();
    }
    var status = await Permission.location.status;

    if (status.isPermanentlyDenied) return;
    status = await Permission.location.request();

    var position = await Geolocator.getCurrentPosition(
        // desiredAccuracy: LocationAccuracy.high,
        );

    _position = position;
  }

  @override
  Widget build(BuildContext context) {
    var homeDataProvider = Provider.of<HomeDataProvider>(context);

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.kSecondaryColor,
            ),
          )
        : _hasGotError
            ? Center(
                child: Column(
                  children: const [
                    Text(
                        'An Error Occurred. Please Check your internet connection and Try again.')
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacer(30),
                    // Icon(),
                    Text(
                      'Air Quality Index',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    verticalSpacer(5),
                    Text(
                      '${homeDataProvider.homeDataResponseModel!.city}, ${homeDataProvider.homeDataResponseModel!.state}, ${homeDataProvider.homeDataResponseModel!.country}',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.grey,
                          ),
                    ),

                    verticalSpacer(
                      getProportionateScreenHeight(0.15).toInt(),
                    ),
                    Center(
                      child: _circleWidget(
                        value: homeDataProvider
                            .homeDataResponseModel!.current!.pollution!.aqius,
                      ),
                    ),
                    verticalSpacer(30),
                    const Spacer(),
                    _customContainer(
                      context: context,
                      iconContainerColor: AppColors.kSecondaryColor,
                      icon: Icons.air,
                      text: 'Air Quality is ${homeDataProvider.airQuality}',
                      isAirQualityContainer: true,
                    ),
                    _customContainer(
                      context: context,
                      iconContainerColor: Color(0xFF4990E1),
                      text: 'Recommendations',
                      subtitleText: 'Air polution poses little or no risk',
                      icon: Icons.webhook_outlined,
                    ),
                  ],
                ),
              );
  }

  Container _circleWidget({
    required int? value,
  }) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [
            AppColors.kSecondaryColor.withOpacity(0.1),
            AppColors.kSecondaryColor.withOpacity(0.2),
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.grey,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              spreadRadius: 5,
              color: Colors.white.withOpacity(0.1),
              offset: Offset(-20, -10),
            ),
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 10,
              color: Colors.grey.withOpacity(0.08),
              offset: Offset(10, 20),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.kSecondaryColor,
          ),
        ),
      ),
    );
  }

  Container _customContainer({
    required BuildContext? context,
    required Color? iconContainerColor,
    required String? text,
    String? subtitleText,
    IconData? icon,
    bool isAirQualityContainer = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            spreadRadius: 10,
            color: Colors.grey.withOpacity(0.1),
            // offset: Offset(-20, -10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: iconContainerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.white,
            ),
          ),
          horizontalSpacer(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text!,
                style: Theme.of(context!).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (!isAirQualityContainer)
                Text(
                  subtitleText!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
