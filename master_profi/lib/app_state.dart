import 'package:flutter/material.dart';
import 'backend/supabase/supabase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _city = prefs.getString('ff_city') ?? _city;
    });
    _safeInit(() {
      _myMasterId = prefs.getInt('ff_myMasterId') ?? _myMasterId;
    });
    _safeInit(() {
      _isOnShift = prefs.getBool('ff_isOnShift') ?? _isOnShift;
    });
    _safeInit(() {
      _activeOrderId = prefs.getInt('ff_activeOrderId') ?? _activeOrderId;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _city = 'Москва';
  String get city => _city;
  set city(String value) {
    _city = value;
    prefs.setString('ff_city', value);
  }

  int _myMasterId = 0;
  int get myMasterId => _myMasterId;
  set myMasterId(int value) {
    _myMasterId = value;
    prefs.setInt('ff_myMasterId', value);
  }

  double _myLat = 0.0;
  double get myLat => _myLat;
  set myLat(double value) {
    _myLat = value;
  }

  double _myLng = 0.0;
  double get myLng => _myLng;
  set myLng(double value) {
    _myLng = value;
  }

  bool _isOnShift = false;
  bool get isOnShift => _isOnShift;
  set isOnShift(bool value) {
    _isOnShift = value;
    prefs.setBool('ff_isOnShift', value);
  }

  int _activeOrderId = 0;
  int get activeOrderId => _activeOrderId;
  set activeOrderId(int value) {
    _activeOrderId = value;
    prefs.setInt('ff_activeOrderId', value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
