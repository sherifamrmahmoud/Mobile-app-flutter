import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors_manager.dart';
import '../data/repos/profile_repo.dart';
import '../logic/profile_cubit.dart';
import '../logic/profile_state.dart';
import 'widgets/profile_header.dart';
import 'widgets/quick_stats_card.dart';
import 'widgets/summary_section.dart';
import 'widgets/settings_list_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // نداء مباشر لجلب البيانات عند بناء الشاشة
      create: (context) => ProfileCubit(ProfileRepository())..getUserProfile(),
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        appBar: AppBar(
          backgroundColor: ColorsManager.background,
          elevation: 0,
          title: const Text(
            'MEDI CALL',
            style: TextStyle(
              color: ColorsManager.textPrimary, 
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushReplacementNamed(context, '/loginScreen');
            } else if (state is LogoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error), 
                  backgroundColor: ColorsManager.error
                ),
              );
            }
          },
          builder: (context, state) {
            // لو البيانات لسه بتحمل، نعرض Spinner في نص الشاشة
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator(color: ColorsManager.primary));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // هنا الـ ProfileHeader هيعرض البيانات اللي في الـ state
                  const ProfileHeader(),
                  const SizedBox(height: 24),
                  
                  const Row(
                    children: [
                      Expanded(
                        child: QuickStatsCard(
                          title: 'My Appointments',
                          subtitle: '2 Upcoming',
                          icon: Icons.calendar_today,
                          iconColor: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: QuickStatsCard(
                          title: 'Medical Records',
                          subtitle: 'Updated 2d ago',
                          icon: Icons.assignment,
                          iconColor: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const SummarySection(),
                  const SizedBox(height: 24),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Account Settings",
                      style: TextStyle(
                        color: ColorsManager.textSecondary,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  SettingsListItem(icon: Icons.person_outline, title: "Personal Information", onTap: () {}),
                  SettingsListItem(icon: Icons.payment_outlined, title: "Payment Methods", onTap: () {}),
                  SettingsListItem(icon: Icons.settings_outlined, title: "Settings", onTap: () {}),
                  SettingsListItem(icon: Icons.help_outline, title: "Help & Support", onTap: () {}),
                  SettingsListItem(icon: Icons.privacy_tip_outlined, title: "Privacy Policy", onTap: () {}),
                  
                  const SizedBox(height: 24),
                  
                  state is LogoutLoading
                      ? const CircularProgressIndicator(color: ColorsManager.primary)
                      : TextButton.icon(
                          onPressed: () {
                            context.read<ProfileCubit>().logout();
                          },
                          icon: const Icon(Icons.logout, color: ColorsManager.error),
                          label: const Text(
                            "Logout",
                            style: TextStyle(
                              color: ColorsManager.error, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}