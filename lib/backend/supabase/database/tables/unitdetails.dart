import '../database.dart';

class UnitdetailsTable extends SupabaseTable<UnitdetailsRow> {
  @override
  String get tableName => 'unitdetails';

  @override
  UnitdetailsRow createRow(Map<String, dynamic> data) => UnitdetailsRow(data);
}

class UnitdetailsRow extends SupabaseDataRow {
  UnitdetailsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UnitdetailsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get unitMeasure => getField<String>('unitMeasure');
  set unitMeasure(String? value) => setField<String>('unitMeasure', value);

  double? get price => getField<double>('price');
  set price(double? value) => setField<double>('price', value);

  int? get quantity => getField<int>('quantity');
  set quantity(int? value) => setField<int>('quantity', value);

  String? get productName => getField<String>('productName');
  set productName(String? value) => setField<String>('productName', value);

  String? get productType => getField<String>('productType');
  set productType(String? value) => setField<String>('productType', value);

  int? get orderId => getField<int>('order_id');
  set orderId(int? value) => setField<int>('order_id', value);
}
