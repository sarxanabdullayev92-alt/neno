import '../database.dart';

class ProfileTable extends SupabaseTable<ProfileRow> {
  @override
  String get tableName => 'profile';

  @override
  ProfileRow createRow(Map<String, dynamic> data) => ProfileRow(data);
}

class ProfileRow extends SupabaseDataRow {
  ProfileRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfileTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get phoneNumber => getField<String>('phoneNumber');
  set phoneNumber(String? value) => setField<String>('phoneNumber', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get address => getField<String>('address');
  set address(String? value) => setField<String>('address', value);

  String? get usersLongANDLat => getField<String>('usersLongANDLat');
  set usersLongANDLat(String? value) =>
      setField<String>('usersLongANDLat', value);

  double? get latitude => getField<double>('latitude');
  set latitude(double? value) => setField<double>('latitude', value);

  double? get longitude => getField<double>('longitude');
  set longitude(double? value) => setField<double>('longitude', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);
}
