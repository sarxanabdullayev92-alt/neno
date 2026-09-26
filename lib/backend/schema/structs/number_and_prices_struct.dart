// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NumberAndPricesStruct extends BaseStruct {
  NumberAndPricesStruct({
    int? quantity,
    double? costper1,
    String? measurement,
    String? productName,
    String? productType,
  })  : _quantity = quantity,
        _costper1 = costper1,
        _measurement = measurement,
        _productName = productName,
        _productType = productType;

  // "Quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "costper1" field.
  double? _costper1;
  double get costper1 => _costper1 ?? 0.0;
  set costper1(double? val) => _costper1 = val;

  void incrementCostper1(double amount) => costper1 = costper1 + amount;

  bool hasCostper1() => _costper1 != null;

  // "measurement" field.
  String? _measurement;
  String get measurement => _measurement ?? '';
  set measurement(String? val) => _measurement = val;

  bool hasMeasurement() => _measurement != null;

  // "productName" field.
  String? _productName;
  String get productName => _productName ?? '';
  set productName(String? val) => _productName = val;

  bool hasProductName() => _productName != null;

  // "productType" field.
  String? _productType;
  String get productType => _productType ?? '';
  set productType(String? val) => _productType = val;

  bool hasProductType() => _productType != null;

  static NumberAndPricesStruct fromMap(Map<String, dynamic> data) =>
      NumberAndPricesStruct(
        quantity: castToType<int>(data['Quantity']),
        costper1: castToType<double>(data['costper1']),
        measurement: data['measurement'] as String?,
        productName: data['productName'] as String?,
        productType: data['productType'] as String?,
      );

  static NumberAndPricesStruct? maybeFromMap(dynamic data) => data is Map
      ? NumberAndPricesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'Quantity': _quantity,
        'costper1': _costper1,
        'measurement': _measurement,
        'productName': _productName,
        'productType': _productType,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'costper1': serializeParam(
          _costper1,
          ParamType.double,
        ),
        'measurement': serializeParam(
          _measurement,
          ParamType.String,
        ),
        'productName': serializeParam(
          _productName,
          ParamType.String,
        ),
        'productType': serializeParam(
          _productType,
          ParamType.String,
        ),
      }.withoutNulls;

  static NumberAndPricesStruct fromSerializableMap(Map<String, dynamic> data) =>
      NumberAndPricesStruct(
        quantity: deserializeParam(
          data['Quantity'],
          ParamType.int,
          false,
        ),
        costper1: deserializeParam(
          data['costper1'],
          ParamType.double,
          false,
        ),
        measurement: deserializeParam(
          data['measurement'],
          ParamType.String,
          false,
        ),
        productName: deserializeParam(
          data['productName'],
          ParamType.String,
          false,
        ),
        productType: deserializeParam(
          data['productType'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'NumberAndPricesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is NumberAndPricesStruct &&
        quantity == other.quantity &&
        costper1 == other.costper1 &&
        measurement == other.measurement &&
        productName == other.productName &&
        productType == other.productType;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([quantity, costper1, measurement, productName, productType]);
}

NumberAndPricesStruct createNumberAndPricesStruct({
  int? quantity,
  double? costper1,
  String? measurement,
  String? productName,
  String? productType,
}) =>
    NumberAndPricesStruct(
      quantity: quantity,
      costper1: costper1,
      measurement: measurement,
      productName: productName,
      productType: productType,
    );
