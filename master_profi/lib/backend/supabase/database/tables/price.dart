import '../database.dart';

class PriceTable extends SupabaseTable<PriceRow> {
  @override
  String get tableName => 'price';

  @override
  PriceRow createRow(Map<String, dynamic> data) => PriceRow(data);
}

class PriceRow extends SupabaseDataRow {
  PriceRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PriceTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get nameOptions => getField<String>('Name Options');
  set nameOptions(String? value) => setField<String>('Name Options', value);

  String? get unit => getField<String>('unit');
  set unit(String? value) => setField<String>('unit', value);

  double? get price => getField<double>('price');
  set price(double? value) => setField<double>('price', value);

  String? get parametr => getField<String>('parametr');
  set parametr(String? value) => setField<String>('parametr', value);
}
