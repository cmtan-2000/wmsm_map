import 'package:flutter/cupertino.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthConnViewModel extends ChangeNotifier {
  // Properties
  String _message = '';
  bool _authorize = false;
  Map<String, dynamic> _step = {};

  // Getters
  String get message => _message;
  bool get authorize => _authorize;
  Map<String, dynamic> get step => _step;

  // Constructor
  HealthFactory health = HealthFactory();
  static var types = [HealthDataType.STEPS];
  static var permissions = types.map((e) => HealthDataAccess.READ).toList();

  // Commands
  void updateMessage(String newMessage) {
    _message = newMessage;
    notifyListeners();
  }

  void getAuthorize() async {
    await Permission.activityRecognition.request();
    await Permission.location.request();

    bool? hasPermissions =
        await health.hasPermissions(types, permissions: permissions);
    hasPermissions = false;
    bool authorized = false;
    if (!hasPermissions) {
      try {
        authorized =
            await health.requestAuthorization(types, permissions: permissions);
        _authorize = authorized;
      } catch (e) {
        throw Exception('Exception in authorize: $e');
      }
    }
    notifyListeners();
  }

  void getSteps() async {
    int? step = 0;
    DateTime endTime = DateTime.now();
    DateTime startTime = DateTime(endTime.year, endTime.month, endTime.day);

    bool request =
        await health.requestAuthorization(types, permissions: permissions);

    if (request == false) {
      _step = {
        'step': null,
        'startTime': null,
        'endTime': null,
        'response': 'fail',
      };
      notifyListeners();
      return;
    }

    try {
      step = await health.getTotalStepsInInterval(startTime, endTime);
      _step = {
        'step': step,
        'startTime': startTime,
        'endTime': endTime,
        'response': 'success',
      };
      notifyListeners();
    } catch (e) {
      throw Exception('Exception in getSteps: $e');
    }
  }
}
