class Category {
  final String id;
  final String name;
  final String icon;

  Category({this.id, this.name, this.icon});
}

final List<Category> categories = [
  Category(
    id: "keyboard",
    name: "Keyboard",
    icon: "assets/icons/keyboard_ver2.svg",
  ),
  Category(
    id: "mouse",
    name: "Mouse",
    icon: "assets/icons/mouse.svg",
  ),
  Category(
    id: "headphone",
    name: "Headphone",
    icon: "assets/icons/headphones.svg",
  ),
  Category(
    id: "screen",
    name: "Screen",
    icon: "assets/icons/display.svg",
  ),
];
