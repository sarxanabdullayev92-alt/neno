// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductIntricaciesStruct extends BaseStruct {
  ProductIntricaciesStruct({
    String? productType,
    String? productName,
    int? numbers,
  })  : _productType = productType,
        _productName = productName,
        _numbers = numbers;

  // "ProductType" field.
  String? _productType;
  String get productType => _productType ?? '';
  set productType(String? val) => _productType = val;

  bool hasProductType() => _productType != null;

  // "ProductName" field.
  String? _productName;
  String get productName => _productName ?? '';
  set productName(String? val) => _productName = val;

  bool hasProductName() => _productName != null;

  // "numbers" field.
  int? _numbers;
  int get numbers => _numbers ?? 0;
  set numbers(int? val) => _numbers = val;

  void incrementNumbers(int amount) => numbers = numbers + amount;

  bool hasNumbers() => _numbers != null;

  static ProductIntricaciesStruct fromMap(Map<String, dynamic> data) =>
      ProductIntricaciesStruct(
        productType: data['ProductType'] as String?,
        productName: data['ProductName'] as String?,
        numbers: castToType<int>(data['numbers']),
      );

  static ProductIntricaciesStruct? maybeFromMap(dynamic data) => data is Map
      ? ProductIntricaciesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'ProductType': _productType,
        'ProductName': _productName,
        'numbers': _numbers,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'ProductType': serializeParam(
          _productType,
          ParamType.String,
        ),
        'ProductName': serializeParam(
          _productName,
          ParamType.String,
        ),
        'numbers': serializeParam(
          _numbers,
          ParamType.int,
        ),
      }.withoutNulls;

  static ProductIntricaciesStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ProductIntricaciesStruct(
        productType: deserializeParam(
          data['ProductType'],
          ParamType.String,
          false,
        ),
        productName: deserializeParam(
          data['ProductName'],
          ParamType.String,
          false,
        ),
        numbers: deserializeParam(
          data['numbers'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'ProductIntricaciesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProductIntricaciesStruct &&
        productType == other.productType &&
        productName == other.productName &&
        numbers == other.numbers;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([productType, productName, numbers]);
}

ProductIntricaciesStruct createProductIntricaciesStruct({
  String? productType,
  String? productName,
  int? numbers,
}) =>
    ProductIntricaciesStruct(
      productType: productType,
      productName: productName,
      numbers: numbers,
    );
