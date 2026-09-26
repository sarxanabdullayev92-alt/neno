import '../database.dart';

class ServicesTable extends SupabaseTable<ServicesRow> {
  @override
  String get tableName => 'services';

  @override
  ServicesRow createRow(Map<String, dynamic> data) => ServicesRow(data);
}

class ServicesRow extends SupabaseDataRow {
  ServicesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ServicesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('Name');
  set name(String? value) => setField<String>('Name', value);

  String? get image => getField<String>('Image');
  set image(String? value) => setField<String>('Image', value);

  String? get descriptions => getField<String>('Descriptions');
  set descriptions(String? value) => setField<String>('Descriptions', value);

  String? get navigationtext => getField<String>('Navigationtext');
  set navigationtext(String? value) =>
      setField<String>('Navigationtext', value);
}
