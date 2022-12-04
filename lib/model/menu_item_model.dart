class MenuItemModel {
  late int id;
  late String label;

  MenuItemModel.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    label = data[label];
  }
}