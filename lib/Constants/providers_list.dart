import 'package:flutter_interview_task_1/Providers/home_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProvidersList {
  static List<SingleChildWidget> getProviders() {
    return [
      ChangeNotifierProvider(
        create: (ctx) => HomeDataProvider(),
      ),
    ];
  }
}
