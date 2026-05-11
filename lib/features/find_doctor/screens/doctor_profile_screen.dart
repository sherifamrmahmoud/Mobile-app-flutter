import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/doctor.dart';
import '../cubit/doctor_booking_cubit.dart';
import '../cubit/doctor_booking_state.dart';

class DoctorProfileScreen extends StatelessWidget {
  final Doctor doctor;

  const DoctorProfileScreen({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoctorBookingCubit(),
      child: BlocConsumer<DoctorBookingCubit, DoctorBookingState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }

          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Appointment confirmed with ${doctor.name}'),
              ),
            );

            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F6FA),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF1A1A2E),
                  size: 20,
                ),
              ),
              title: const Text(
                'Doctor Profile',
                style: TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      doctor.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: doctor.isLiked ? Colors.red : Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DoctorHeader(doctor: doctor),
                  const SizedBox(height: 28),
                  _StatsRow(doctor: doctor),
                  const SizedBox(height: 28),
                  const _SectionTitle(title: 'About Doctor'),
                  const SizedBox(height: 10),
                  Text(
                    doctor.bio,
                    style: const TextStyle(
                      color: Color(0xFF56657F),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const _SectionTitle(title: 'Select Date'),
                  const SizedBox(height: 12),
                  _DateSelector(state: state),
                  const SizedBox(height: 28),
                  const _SectionTitle(title: 'Morning Slots'),
                  const SizedBox(height: 12),
                  _SlotsGrid(slots: state.morningSlots),
                  const SizedBox(height: 24),
                  const _SectionTitle(title: 'Afternoon Slots'),
                  const SizedBox(height: 12),
                  _SlotsGrid(slots: state.afternoonSlots),
                ],
              ),
            ),
            bottomNavigationBar: _BottomBookingBar(
              doctor: doctor,
              state: state,
            ),
          );
        },
      ),
    );
  }
}

class _DoctorHeader extends StatelessWidget {
  final Doctor doctor;

  const _DoctorHeader({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 64,
                  backgroundColor: const Color(0xFFE0F2F1),
                  backgroundImage: AssetImage(doctor.imagePath),
                  onBackgroundImageError: (_, __) {},
                ),
              ),
              if (doctor.isOnline)
                Positioned(
                  right: 12,
                  bottom: 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            doctor.name,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${doctor.specialty} • ${doctor.clinicName}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1687F2),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Color(0xFF7B8794),
              ),
              const SizedBox(width: 4),
              Text(
                doctor.location,
                style: const TextStyle(
                  color: Color(0xFF7B8794),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final Doctor doctor;

  const _StatsRow({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.groups_outlined,
            value: doctor.patientsCount,
            label: 'PATIENTS',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.work_outline,
            value: '${doctor.yearsOfExperience} Yrs',
            label: 'EXPERIENCE',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.star_border,
            value: doctor.rating.toStringAsFixed(1),
            label: 'RATING',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5EAF1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF1687F2), size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7B8794),
              fontSize: 11,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF111827),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  final DoctorBookingState state;

  const _DateSelector({required this.state});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: state.availableDates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = state.availableDates[index];
          final isSelected = _isSameDate(date, state.selectedDate);

          return GestureDetector(
            onTap: () => context.read<DoctorBookingCubit>().selectDate(date),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 64,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1687F2) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF1687F2)
                      : const Color(0xFFE5EAF1),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weekday(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF111827),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static bool _isSameDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  static String _weekday(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}

class _SlotsGrid extends StatelessWidget {
  final List<String> slots;

  const _SlotsGrid({required this.slots});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorBookingCubit, DoctorBookingState>(
      builder: (context, state) {
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: slots.map((slot) {
            final isSelected = state.selectedTime == slot;
            final isDisabled = slot == '11:30 AM';

            return GestureDetector(
              onTap: isDisabled
                  ? null
                  : () => context.read<DoctorBookingCubit>().selectTime(slot),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: (MediaQuery.of(context).size.width - 56) / 3,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1687F2)
                      : isDisabled
                          ? const Color(0xFFF3F4F6)
                          : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1687F2)
                        : const Color(0xFFE5EAF1),
                  ),
                ),
                child: Text(
                  slot,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : isDisabled
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF334155),
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _BottomBookingBar extends StatelessWidget {
  final Doctor doctor;
  final DoctorBookingState state;

  const _BottomBookingBar({
    required this.doctor,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.15)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Consultation Fee',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\$${doctor.price}.00',
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: state.canConfirm
                    ? () => context
                        .read<DoctorBookingCubit>()
                        .confirmAppointment(doctor: doctor)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1687F2),
                  disabledBackgroundColor: const Color(0xFFBFDBFE),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: const Color(0xFF1687F2).withValues(alpha: 0.3),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Confirm Appointment',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}