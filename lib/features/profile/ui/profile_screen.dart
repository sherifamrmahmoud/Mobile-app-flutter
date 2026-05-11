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
      // تهيئة الـ Cubit واستدعاء بيانات المستخدم فوراً عند فتح الصفحة
      create: (context) => ProfileCubit(ProfileRepository())..getUserProfile(),
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        appBar: AppBar(
          backgroundColor: ColorsManager.background,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'MEDI CALL',
            style: TextStyle(
              color: ColorsManager.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            // التعامل مع حالة تسجيل الخروج بنجاح
            if (state is LogoutSuccess) {
              Navigator.pushReplacementNamed(context, '/login');
            }
            // عرض رسالة خطأ في حالة فشل تسجيل الخروج
            else if (state is LogoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: ColorsManager.error,
                ),
              );
            }
          },
          builder: (context, state) {
            // عرض مؤشر تحميل أثناء جلب البيانات
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorsManager.primary),
              );
            }

            // عرض رسالة خطأ في حالة فشل جلب بيانات البروفايل
            if (state is ProfileError) {
              return Center(child: Text(state.message));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // 1. الجزء العلوي (الصورة، الاسم، الإيميل)
                  const ProfileHeader(),
                  const SizedBox(height: 24),

                  // 2. كروت المواعيد والسجلات الطبية (Quick Actions)
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pushNamed(context, '/appointment');
                          },
                          child: const QuickStatsCard(
                            title: 'My Appointments',
                            subtitle: '2 Upcoming',
                            icon: Icons.calendar_today,
                            iconColor: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pushNamed(context, '/medicale_record');
                          },
                          child: const QuickStatsCard(
                            title: 'Medical Records',
                            subtitle: 'Updated 2d ago',
                            icon: Icons.assignment,
                            iconColor: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 3. قسم الملخص الطبي (Latest Summary)
                  // ملاحظة: الزرار داخله مربوط بمسار '/summary'
                  const SummarySection(),

                  const SizedBox(height: 24),

                  // 4. إعدادات الحساب (Settings List)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Account Settings",
                      style: TextStyle(
                        color: ColorsManager.textSecondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  SettingsListItem(
                    icon: Icons.person_outline,
                    title: "Personal Information",
                    onTap: () => Navigator.pushNamed(context, '/personalInfo'),
                  ),
                  SettingsListItem(
                    icon: Icons.payment_outlined,
                    title: "Payment Methods",
                    onTap: () => Navigator.pushNamed(context, '/paymentMethod'),
                  ),
                  SettingsListItem(
                    icon: Icons.settings_outlined,
                    title: "Settings",
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                  SettingsListItem(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: () {},
                  ),
                  SettingsListItem(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    onTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // 5. زرار تسجيل الخروج (Logout Button)
                  state is LogoutLoading
                      ? const CircularProgressIndicator(
                          color: ColorsManager.primary,
                        )
                      : TextButton.icon(
                          onPressed: () {
                            context.read<ProfileCubit>().logout();
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: ColorsManager.error,
                          ),
                          label: const Text(
                            "Logout",
                            style: TextStyle(
                              color: ColorsManager.error,
                              fontWeight: FontWeight.bold,
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
