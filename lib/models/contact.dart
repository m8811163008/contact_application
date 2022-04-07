class Contact {
  int? id;
  late String name;
  late String mobile;
  static const String tableName = 'contacts';
  static const String colId = 'colId';
  static const String colName = 'colName';
  static const String colMobile = 'colMobile';
  Contact({this.id, required this.name, required this.mobile});
  //for retrieve data from database we use name constructor
  Contact.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
    mobile = map[colMobile];
  }
  //SQLite use map so we need toMap method
  Map<String, dynamic> toMap() {
    Map<String, dynamic> _mapData = {
      colName: name,
      colMobile: mobile,
    };
    if (id != null) _mapData[colId] = id;
    return _mapData;
  }
}
