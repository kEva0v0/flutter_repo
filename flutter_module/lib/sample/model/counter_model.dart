
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' as developer;
/// A simple model that uses a [MethodChannel] as the source of truth for the
/// state of a counter.
///
/// Rather than storing app state data within the Flutter module itself (where
/// the native portions of the app can't access it), this module passes messages
/// back to the containing app whenever it needs to increment or retrieve the
/// value of the counter.
class CounterModel extends ChangeNotifier {
  CounterModel() {
    _channel.setMethodCallHandler(_handleMessage);
    _channel.invokeMethod<void>('requestCounter');
  }

  final _channel = const MethodChannel('dev.flutter.example/counter');

  int _count = 0;

  int get count => _count;

  void increment() {
    _channel.invokeMethod<void>('incrementCounter');
    int? aa;
    developer.log("${aa!}");
  }

  Future<dynamic> _handleMessage(MethodCall call) async {
    if (call.method == 'reportCounter') {
      _count = call.arguments as int;
      notifyListeners();
    }
  }
}