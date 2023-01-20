abstract class BaseModel extends Object {
  BaseModel();

  BaseModel.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return toJson().toString();
  }
}
