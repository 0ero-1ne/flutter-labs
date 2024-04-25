import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

abstract class BatteryEvents {}

class BatteryGetStateEvent extends BatteryEvents {}

class BatteryBloc extends Bloc<BatteryEvents, String> {
  final logger = Logger();
  final _platform = const MethodChannel('samples.flutter.dev/battery');

  BatteryBloc() : super('Tap to update battery level info') {
    on<BatteryGetStateEvent>((BatteryEvents event, Emitter<String> emitter) async {
      String batteryLevel;
      try {
        final result = await _platform.invokeMethod<int>('getBatteryLevel');
        batteryLevel = 'Battery level: $result %';
      } on PlatformException catch (e) {
        batteryLevel = "Failed to get battery level: '${e.message}'";
      }
      
      emitter(batteryLevel);
    });
  }

  @override
  void onChange(Change<String> change) {
    super.onChange(change);
    logger.d(change);
  }
}