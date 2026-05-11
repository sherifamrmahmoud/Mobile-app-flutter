import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  static const _categories = [
    _CategoryData('General', Icons.medical_services_outlined, Color(0xFFE3F2FD)),
    _CategoryData('Dental', Icons.sentiment_satisfied_outlined, Color(0xFFFFF3E0)),
    _CategoryData('Heart', Icons.favorite_outline, Color(0xFFFFEBEE)),
    _CategoryData('Pediatrics', Icons.child_friendly_outlined, Color(0xFFE8F5E9)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _categories
              .map((cat) => _CategoryItem(data: cat))
              .toList(),
        ),
      ],
    );
  }
}

class _CategoryData {
  final String label;
  final IconData icon;
  final Color bgColor;
  const _CategoryData(this.label, this.icon, this.bgColor);
}

class _CategoryItem extends StatelessWidget {
  final _CategoryData data;
  const _CategoryItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: data.bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(data.icon, color: const Color(0xFF1565C0), size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            data.label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF1A1A2E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
