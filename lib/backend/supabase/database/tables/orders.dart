import '../database.dart';

class OrdersTable extends SupabaseTable<OrdersRow> {
  @override
  String get tableName => 'orders';

  @override
  OrdersRow createRow(Map<String, dynamic> data) => OrdersRow(data);
}

class OrdersRow extends SupabaseDataRow {
  OrdersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OrdersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get customerProfile => getField<String>('customer_profile');
  set customerProfile(String? value) =>
      setField<String>('customer_profile', value);

  double? get totalCost => getField<double>('total_Cost');
  set totalCost(double? value) => setField<double>('total_Cost', value);

  DateTime? get dateOfService => getField<DateTime>('date_of_service');
  set dateOfService(DateTime? value) =>
      setField<DateTime>('date_of_service', value);

  bool? get forThirdparty => getField<bool>('for_thirdparty');
  set forThirdparty(bool? value) => setField<bool>('for_thirdparty', value);

  String? get thirdParyName => getField<String>('third_pary_name');
  set thirdParyName(String? value) =>
      setField<String>('third_pary_name', value);

  String? get thirdParyNumber => getField<String>('third_pary_number');
  set thirdParyNumber(String? value) =>
      setField<String>('third_pary_number', value);

  int? get mastersID => getField<int>('mastersID');
  set mastersID(int? value) => setField<int>('mastersID', value);

  String? get orderStatus => getField<String>('orderStatus');
  set orderStatus(String? value) => setField<String>('orderStatus', value);

  String? get paymentStatus => getField<String>('paymentStatus');
  set paymentStatus(String? value) => setField<String>('paymentStatus', value);

  String? get assignmentStatus => getField<String>('assignment_status');
  set assignmentStatus(String? value) =>
      setField<String>('assignment_status', value);

  List<int> get services => getListField<int>('services');
  set services(List<int>? value) => setListField<int>('services', value);

  double? get latitude => getField<double>('latitude');
  set latitude(double? value) => setField<double>('latitude', value);

  double? get longitude => getField<double>('longitude');
  set longitude(double? value) => setField<double>('longitude', value);

  String? get city => getField<String>('city');
  set city(String? value) => setField<String>('city', value);

  String? get address => getField<String>('address');
  set address(String? value) => setField<String>('address', value);

  bool? get cash => getField<bool>('cash');
  set cash(bool? value) => setField<bool>('cash', value);
}
