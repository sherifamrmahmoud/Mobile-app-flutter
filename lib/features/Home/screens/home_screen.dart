import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../find_doctor/screens/find_doctor_screen.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/upcoming_appointment_card.dart';
import '../widgets/categories_section.dart';
import '../widgets/top_specialists_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHome(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: _buildAppBar(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1565C0)),
            );
          }
          if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is HomeLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GreetingSection(
                    userName: state.userName,
                    greeting: state.greetingMessage,
                  ),
                  const SizedBox(height: 16),
                  const _SearchBar(),
                  const SizedBox(height: 24),
                  UpcomingAppointmentCard(
                    appointment: state.upcomingAppointment,
                  ),
                  const SizedBox(height: 24),
                  const CategoriesSection(),
                  const SizedBox(height: 24),
                  TopSpecialistsSection(specialists: state.topSpecialists),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: _BottomNav(currentIndex: 0),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF00BFA6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.local_hospital,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'MEDI CALL',
            style: TextStyle(
              color: Color(0xFF1A1A2E),
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_outlined,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}

// ─── Shared Bottom Nav ───────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  const _BottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF1565C0),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          activeIcon: Icon(Icons.calendar_month),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        if (index == currentIndex) return;
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/appointment');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/ProfileScreen');
            break;
        }
      },
    );
  }
}

// ─── Greeting ────────────────────────────────────────────────────────────────

class _GreetingSection extends StatelessWidget {
  final String userName;
  final String greeting;
  const _GreetingSection({required this.userName, required this.greeting});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFFE0E0E0),
          child: ClipOval(
            child: Image.asset(
              'assets/image1.jpg',
              width: 44,
              height: 44,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.person, size: 24, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Search Bar ──────────────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/find');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: 'Search doctors or symptoms',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
