import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/api_requests/api_manager.dart';
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
      _WhatProduct = prefs.getString('ff_WhatProduct') ?? _WhatProduct;
    });
    _safeInit(() {
      _TheProductList = prefs
              .getStringList('ff_TheProductList')
              ?.map((x) {
                try {
                  return NumberAndPricesStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _TheProductList;
    });
    _safeInit(() {
      _whatProductList =
          prefs.getStringList('ff_whatProductList') ?? _whatProductList;
    });
    _safeInit(() {
      _productTypeList =
          prefs.getStringList('ff_productTypeList') ?? _productTypeList;
    });
    _safeInit(() {
      _comment = prefs.getString('ff_comment') ?? _comment;
    });
    _safeInit(() {
      _nameOfThirdParty =
          prefs.getString('ff_nameOfThirdParty') ?? _nameOfThirdParty;
    });
    _safeInit(() {
      _NumberOfThirdParty =
          prefs.getString('ff_NumberOfThirdParty') ?? _NumberOfThirdParty;
    });
    _safeInit(() {
      _datePicked = prefs.containsKey('ff_datePicked')
          ? DateTime.fromMillisecondsSinceEpoch(prefs.getInt('ff_datePicked')!)
          : _datePicked;
    });
    _safeInit(() {
      _aFutureOrder = prefs.getBool('ff_aFutureOrder') ?? _aFutureOrder;
    });
    _safeInit(() {
      _city = prefs.getString('ff_city') ?? _city;
    });
    _safeInit(() {
      _orderLat = prefs.getDouble('ff_orderLat') ?? _orderLat;
    });
    _safeInit(() {
      _orderLng = prefs.getDouble('ff_orderLng') ?? _orderLng;
    });
    _safeInit(() {
      _orderAddress = prefs.getString('ff_orderAddress') ?? _orderAddress;
    });
    _safeInit(() {
      _activeOrderId = prefs.getInt('ff_activeOrderId') ?? _activeOrderId;
    });
    _safeInit(() {
      _activeMasterId = prefs.getInt('ff_activeMasterId') ?? _activeMasterId;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _WhatProduct = '';
  String get WhatProduct => _WhatProduct;
  set WhatProduct(String value) {
    _WhatProduct = value;
    prefs.setString('ff_WhatProduct', value);
  }

  List<NumberAndPricesStruct> _TheProductList = [
    NumberAndPricesStruct.fromSerializableMap(jsonDecode(
        '{\"Quantity\":\"4\",\"costper1\":\"3.0\",\"measurement\":\"\",\"productName\":\"\",\"productType\":\"\"}'))
  ];
  List<NumberAndPricesStruct> get TheProductList => _TheProductList;
  set TheProductList(List<NumberAndPricesStruct> value) {
    _TheProductList = value;
    prefs.setStringList(
        'ff_TheProductList', value.map((x) => x.serialize()).toList());
  }

  void addToTheProductList(NumberAndPricesStruct value) {
    TheProductList.add(value);
    prefs.setStringList('ff_TheProductList',
        _TheProductList.map((x) => x.serialize()).toList());
  }

  void removeFromTheProductList(NumberAndPricesStruct value) {
    TheProductList.remove(value);
    prefs.setStringList('ff_TheProductList',
        _TheProductList.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromTheProductList(int index) {
    TheProductList.removeAt(index);
    prefs.setStringList('ff_TheProductList',
        _TheProductList.map((x) => x.serialize()).toList());
  }

  void updateTheProductListAtIndex(
    int index,
    NumberAndPricesStruct Function(NumberAndPricesStruct) updateFn,
  ) {
    TheProductList[index] = updateFn(_TheProductList[index]);
    prefs.setStringList('ff_TheProductList',
        _TheProductList.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInTheProductList(int index, NumberAndPricesStruct value) {
    TheProductList.insert(index, value);
    prefs.setStringList('ff_TheProductList',
        _TheProductList.map((x) => x.serialize()).toList());
  }

  List<String> _whatProductList = [''];
  List<String> get whatProductList => _whatProductList;
  set whatProductList(List<String> value) {
    _whatProductList = value;
    prefs.setStringList('ff_whatProductList', value);
  }

  void addToWhatProductList(String value) {
    whatProductList.add(value);
    prefs.setStringList('ff_whatProductList', _whatProductList);
  }

  void removeFromWhatProductList(String value) {
    whatProductList.remove(value);
    prefs.setStringList('ff_whatProductList', _whatProductList);
  }

  void removeAtIndexFromWhatProductList(int index) {
    whatProductList.removeAt(index);
    prefs.setStringList('ff_whatProductList', _whatProductList);
  }

  void updateWhatProductListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    whatProductList[index] = updateFn(_whatProductList[index]);
    prefs.setStringList('ff_whatProductList', _whatProductList);
  }

  void insertAtIndexInWhatProductList(int index, String value) {
    whatProductList.insert(index, value);
    prefs.setStringList('ff_whatProductList', _whatProductList);
  }

  List<String> _generalListOfService = ['nothing'];
  List<String> get generalListOfService => _generalListOfService;
  set generalListOfService(List<String> value) {
    _generalListOfService = value;
  }

  void addToGeneralListOfService(String value) {
    generalListOfService.add(value);
  }

  void removeFromGeneralListOfService(String value) {
    generalListOfService.remove(value);
  }

  void removeAtIndexFromGeneralListOfService(int index) {
    generalListOfService.removeAt(index);
  }

  void updateGeneralListOfServiceAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    generalListOfService[index] = updateFn(_generalListOfService[index]);
  }

  void insertAtIndexInGeneralListOfService(int index, String value) {
    generalListOfService.insert(index, value);
  }

  List<String> _productTypeList = [''];
  List<String> get productTypeList => _productTypeList;
  set productTypeList(List<String> value) {
    _productTypeList = value;
    prefs.setStringList('ff_productTypeList', value);
  }

  void addToProductTypeList(String value) {
    productTypeList.add(value);
    prefs.setStringList('ff_productTypeList', _productTypeList);
  }

  void removeFromProductTypeList(String value) {
    productTypeList.remove(value);
    prefs.setStringList('ff_productTypeList', _productTypeList);
  }

  void removeAtIndexFromProductTypeList(int index) {
    productTypeList.removeAt(index);
    prefs.setStringList('ff_productTypeList', _productTypeList);
  }

  void updateProductTypeListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    productTypeList[index] = updateFn(_productTypeList[index]);
    prefs.setStringList('ff_productTypeList', _productTypeList);
  }

  void insertAtIndexInProductTypeList(int index, String value) {
    productTypeList.insert(index, value);
    prefs.setStringList('ff_productTypeList', _productTypeList);
  }

  String _comment = '';
  String get comment => _comment;
  set comment(String value) {
    _comment = value;
    prefs.setString('ff_comment', value);
  }

  String _nameOfThirdParty = '';
  String get nameOfThirdParty => _nameOfThirdParty;
  set nameOfThirdParty(String value) {
    _nameOfThirdParty = value;
    prefs.setString('ff_nameOfThirdParty', value);
  }

  String _NumberOfThirdParty = '';
  String get NumberOfThirdParty => _NumberOfThirdParty;
  set NumberOfThirdParty(String value) {
    _NumberOfThirdParty = value;
    prefs.setString('ff_NumberOfThirdParty', value);
  }

  DateTime? _datePicked;
  DateTime? get datePicked => _datePicked;
  set datePicked(DateTime? value) {
    _datePicked = value;
    value != null
        ? prefs.setInt('ff_datePicked', value.millisecondsSinceEpoch)
        : prefs.remove('ff_datePicked');
  }

  bool _aFutureOrder = false;
  bool get aFutureOrder => _aFutureOrder;
  set aFutureOrder(bool value) {
    _aFutureOrder = value;
    prefs.setBool('ff_aFutureOrder', value);
  }

  String _city = 'Москва';
  String get city => _city;
  set city(String value) {
    _city = value;
    prefs.setString('ff_city', value);
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

  double _orderLat = 0.0;
  double get orderLat => _orderLat;
  set orderLat(double value) {
    _orderLat = value;
    prefs.setDouble('ff_orderLat', value);
  }

  double _orderLng = 0.0;
  double get orderLng => _orderLng;
  set orderLng(double value) {
    _orderLng = value;
    prefs.setDouble('ff_orderLng', value);
  }

  String _orderAddress = '';
  String get orderAddress => _orderAddress;
  set orderAddress(String value) {
    _orderAddress = value;
    prefs.setString('ff_orderAddress', value);
  }

  int _activeOrderId = 0;
  int get activeOrderId => _activeOrderId;
  set activeOrderId(int value) {
    _activeOrderId = value;
    prefs.setInt('ff_activeOrderId', value);
  }

  int _activeMasterId = 0;
  int get activeMasterId => _activeMasterId;
  set activeMasterId(int value) {
    _activeMasterId = value;
    prefs.setInt('ff_activeMasterId', value);
  }

  List<String> _ProductNameALone = [''];
  List<String> get ProductNameALone => _ProductNameALone;
  set ProductNameALone(List<String> value) {
    _ProductNameALone = value;
  }

  void addToProductNameALone(String value) {
    ProductNameALone.add(value);
  }

  void removeFromProductNameALone(String value) {
    ProductNameALone.remove(value);
  }

  void removeAtIndexFromProductNameALone(int index) {
    ProductNameALone.removeAt(index);
  }

  void updateProductNameALoneAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    ProductNameALone[index] = updateFn(_ProductNameALone[index]);
  }

  void insertAtIndexInProductNameALone(int index, String value) {
    ProductNameALone.insert(index, value);
  }

  String _addressDetails = '';
  String get addressDetails => _addressDetails;
  set addressDetails(String value) {
    _addressDetails = value;
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
