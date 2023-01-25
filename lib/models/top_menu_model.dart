class TopMenuModel {
  TopMenuModel({
    required this.id,
    required this.iconPath,
    required this.title,
    this.selected = false
  });

  int id;
  String iconPath;
  String title;
  bool selected;

  factory TopMenuModel.fromJson(Map<String, dynamic> json) => TopMenuModel(
    id: json["id"],
    iconPath: json["iconPath"],
    title: json["title"],
    selected: false
  );
}