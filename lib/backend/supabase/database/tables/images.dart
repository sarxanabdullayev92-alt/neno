import '../database.dart';

class ImagesTable extends SupabaseTable<ImagesRow> {
  @override
  String get tableName => 'images';

  @override
  ImagesRow createRow(Map<String, dynamic> data) => ImagesRow(data);
}

class ImagesRow extends SupabaseDataRow {
  ImagesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ImagesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get imageURL => getField<String>('Image_URL');
  set imageURL(String? value) => setField<String>('Image_URL', value);
}
