import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/find_doctor_cubit.dart';
import '../cubit/find_doctor_state.dart';
import '../widgets/doctor_card.dart';
import '../widgets/filter_chips.dart';

class FindDoctorScreen extends StatelessWidget {
  const FindDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FindDoctorCubit()..loadDoctors(),
      child: const _FindDoctorView(),
    );
  }
}

class _FindDoctorView extends StatelessWidget {
  const _FindDoctorView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xFF1A1A2E), size: 20),
        ),
        title: const Text(
          'Find a Doctor',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Color(0xFF1A1A2E)),
          ),
        ],
      ),
      body: BlocBuilder<FindDoctorCubit, FindDoctorState>(
        builder: (context, state) {
          if (state is FindDoctorLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF1565C0)),
            );
          }
          if (state is FindDoctorError) {
            return Center(
              child: Text(state.message,
                  style: const TextStyle(color: Colors.red)),
            );
          }
          if (state is FindDoctorLoaded) {
            return Column(
              children: [
                // ── Sticky Search + Filters ──
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          onChanged: (val) =>
                              context.read<FindDoctorCubit>().search(val),
                          decoration: InputDecoration(
                            hintText: 'Search by name or specialty',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                            prefixIcon: const Icon(Icons.search,
                                color: Colors.grey, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF5F6FA),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FilterChipsRow(
                        selectedFilter: state.selectedFilter,
                        onFilterSelected: (f) =>
                            context.read<FindDoctorCubit>().applyFilter(f),
                      ),
                    ],
                  ),
                ),

                // ── Doctor List ──
                Expanded(
                  child: state.filteredDoctors.isEmpty
                      ? const Center(
                          child: Text(
                            'No doctors found',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        )
                      : ListView.separated(
                          padding:
                              const EdgeInsets.fromLTRB(16, 16, 16, 16),
                          itemCount: state.filteredDoctors.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) => DoctorCard(
                            doctor: state.filteredDoctors[index],
                            onLikeTap: () => context
                                .read<FindDoctorCubit>()
                                .toggleLike(index),
                            onBookTap: () {
                              // TODO: Navigate to booking screen
                            },
                          ),
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF1565C0),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Explore',
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
        onTap: (_) {},
      ),
    );
  }
}
