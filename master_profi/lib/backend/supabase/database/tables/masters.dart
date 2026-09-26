import '../database.dart';

class MastersTable extends SupabaseTable<MastersRow> {
  @override
  String get tableName => 'masters';

  @override
  MastersRow createRow(Map<String, dynamic> data) => MastersRow(data);
}

class MastersRow extends SupabaseDataRow {
  MastersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MastersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get userProfile => getField<String>('user_profile');
  set userProfile(String? value) => setField<String>('user_profile', value);

  String get services => getField<String>('services')!;
  set services(String value) => setField<String>('services', value);

  String? get district => getField<String>('district');
  set district(String? value) => setField<String>('district', value);

  String? get phonenumber => getField<String>('phonenumber');
  set phonenumber(String? value) => setField<String>('phonenumber', value);

  String? get currentLocation => getField<String>('currentLocation');
  set currentLocation(String? value) =>
      setField<String>('currentLocation', value);

  double? get latitude => getField<double>('latitude');
  set latitude(double? value) => setField<double>('latitude', value);

  double? get longitude => getField<double>('longitude');
  set longitude(double? value) => setField<double>('longitude', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);

  bool get isOnline => getField<bool>('is_online')!;
  set isOnline(bool value) => setField<bool>('is_online', value);

  double? get heading => getField<double>('heading');
  set heading(double? value) => setField<double>('heading', value);

  DateTime? get locationUpdatedAt => getField<DateTime>('location_updated_at');
  set locationUpdatedAt(DateTime? value) =>
      setField<DateTime>('location_updated_at', value);
}
