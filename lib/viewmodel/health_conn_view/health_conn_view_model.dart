import 'package:flutter/cupertino.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/step.dart';

class HealthConnViewModel extends ChangeNotifier {
  // Properties
  String _message = '';
  bool _authorize = false;
  Map<String, dynamic> _step = {};
  List<StepData> _weeklyStep = [];
  List<StepData> _monthlyStep = [];
  String tst = "";

  // Getters
  String get message => _message;
  bool get authorize => _authorize;
  Map<String, dynamic> get step => _step;
  List<StepData> get weeklyStep => _weeklyStep;
  List<StepData> get monthlyStep => _monthlyStep;
  String get test => tst;

  // Constructor
  HealthFactory health = HealthFactory();
  static var types = [HealthDataType.STEPS];
  static var permissions = types.map((e) => HealthDataAccess.READ).toList();

  // Commands
  void updateMessage(String newMessage) {
    _message = newMessage;
    notifyListeners();
  }

  Future<bool> getAuthorize() async {
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
    // notifyListeners();
    // getSteps();
    return authorized;
  }

  void getSteps() async {
    if (authorize) {
      int? step = 0;
      DateTime endTime = DateTime.now();
      DateTime startTime = DateTime(endTime.year, endTime.month, endTime.day);

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
    } else {
      DateTime endTime = DateTime.now();
      DateTime startTime = DateTime(endTime.year, endTime.month, endTime.day);
      _step = {
        'step': 0,
        'startTime': startTime,
        'endTime': endTime,
        'response': 'fail',
      };
      notifyListeners();
    }
  }

  Future<void> getWeeklyStep() async {
    // _weeklyStep = await _getStepsByDate();

    // Get weekly date
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // Adjust startOfWeek to Sunday
    if (startOfWeek.weekday != DateTime.sunday) {
      startOfWeek = startOfWeek.subtract(Duration(days: startOfWeek.weekday));
    }

    // Adjust endOfWeek to Saturday
    if (endOfWeek.weekday != DateTime.saturday) {
      endOfWeek =
          endOfWeek.add(Duration(days: DateTime.saturday - endOfWeek.weekday));
    }
    // Logger().i('Start of the week: ${startOfWeek.toString()}');
    // Logger().i('End of the week: ${endOfWeek.toString()}');

    final difference = endOfWeek.difference(startOfWeek).inDays;

    List<StepData> steps = [];
    for (int i = 0; i < 7; i++) {
      final target =
          DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day + i);
      final next = DateTime(
          startOfWeek.year, startOfWeek.month, startOfWeek.day + i + 1);
      int? step = await health.getTotalStepsInInterval(target, next);
      int stepInt = step ?? 0;
      String dayOfWeek = DateFormat('EEE').format(target);
      steps.add(StepData(dayOfWeek, stepInt));
    }

    _weeklyStep = steps;
    notifyListeners();
  }

  Future<void> getMonthlyStep() async {
    // Get monthly date range
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

    List<StepData> steps = [];
    for (int i = 0; i < endOfMonth.day; i++) {
      final target = DateTime(now.year, now.month, i + 1);
      final next = DateTime(now.year, now.month, i + 2);
      int? step = await health.getTotalStepsInInterval(target, next);
      int stepInt = step ?? 0;
      String dayOfWeek = DateFormat('EEE').format(target);
      steps.add(StepData(dayOfWeek, stepInt));
    }

    // for (int i = 0; i < steps.length; i++) {
    //   Logger().i('Date: ${steps[i].x} . Step: ${steps[i].y}');
    // }

    _monthlyStep = steps;
    notifyListeners();
  }
}
