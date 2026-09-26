import '../database.dart';

class OrderdetailsTable extends SupabaseTable<OrderdetailsRow> {
  @override
  String get tableName => 'orderdetails';

  @override
  OrderdetailsRow createRow(Map<String, dynamic> data) => OrderdetailsRow(data);
}

class OrderdetailsRow extends SupabaseDataRow {
  OrderdetailsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OrderdetailsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get nameOfProduct => getField<String>('nameOfProduct');
  set nameOfProduct(String? value) => setField<String>('nameOfProduct', value);

  double? get price => getField<double>('price');
  set price(double? value) => setField<double>('price', value);

  List<int> get pricedetailList => getListField<int>('pricedetailList');
  set pricedetailList(List<int>? value) =>
      setListField<int>('pricedetailList', value);
}
