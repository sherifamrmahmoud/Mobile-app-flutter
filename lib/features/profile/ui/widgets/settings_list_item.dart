import 'package:flutter/material.dart';
import 'package:nti5/core/theme/colors_manager.dart' show ColorsManager;

class SettingsItemModel {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  SettingsItemModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
class SettingsListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorsManager.background, 
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: ColorsManager.textPrimary, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: ColorsManager.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: ColorsManager.textSecondary,
      ),
    );
  }
}