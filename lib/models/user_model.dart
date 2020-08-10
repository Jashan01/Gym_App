class UserModel {
  String id;
  String name;
  String phoneNumber;
  String accessToken;

  UserModel({
    this.name = '',
    this.id = '',
    this.phoneNumber = '',
    this.accessToken = '',
  });

  UserModel.fromMap(Map<dynamic, dynamic> record) {
    name = record['name'] != null ? record['name'] : '';
    id = record['_id'] != null ? record['_id'] : '';
    phoneNumber = record['phone'] != null ? record['phone'] : '';
    accessToken = record['accessToken'] != null ? record['accessToken'] : '';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'phone': phoneNumber,
      'accessToken': accessToken,
    };
  }
}
