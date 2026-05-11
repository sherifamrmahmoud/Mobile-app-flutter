import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';
import 'settings_list_item.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Account Settings",
            style: TextStyle(
              color: ColorsManager.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsManager.border),
          ),
          child: Column(
            children: [
              SettingsListItem(icon: Icons.person_outline, title: "Personal Information", onTap: () {}),
              const Divider(height: 1, indent: 50, color: ColorsManager.border), 
              SettingsListItem(icon: Icons.payment_outlined, title: "Payment Methods", onTap: () {}),
              const Divider(height: 1, indent: 50, color: ColorsManager.border),
              SettingsListItem(icon: Icons.settings_outlined, title: "Settings", onTap: () {}),
              const Divider(height: 1, indent: 50, color: ColorsManager.border),
              SettingsListItem(icon: Icons.help_outline, title: "Help & Support", onTap: () {}),
              const Divider(height: 1, indent: 50, color: ColorsManager.border),
              SettingsListItem(icon: Icons.privacy_tip_outlined, title: "Privacy Policy", onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}