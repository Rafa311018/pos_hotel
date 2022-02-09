import 'dart:ui';

class MenuEntity {
  const MenuEntity(
      {this.backgroundColor,
      this.name,
      this.assetIcon,
      required this.routePage});

  final Color? backgroundColor;
  final String? name;
  final String? assetIcon;
  final String routePage;
}
