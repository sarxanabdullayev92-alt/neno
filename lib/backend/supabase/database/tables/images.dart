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

  String? get imageurl1 => getField<String>('Imageurl1');
  set imageurl1(String? value) => setField<String>('Imageurl1', value);

  String? get orderName => getField<String>('orderName');
  set orderName(String? value) => setField<String>('orderName', value);

  String? get imageurl2 => getField<String>('imageurl2');
  set imageurl2(String? value) => setField<String>('imageurl2', value);

  String? get imageUrl3 => getField<String>('imageUrl3');
  set imageUrl3(String? value) => setField<String>('imageUrl3', value);
}
