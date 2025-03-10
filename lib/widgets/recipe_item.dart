import 'package:flutter/material.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 133,
            height: 133,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/Rectangle 7.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Trứng chiên',
            style: TextStyle(
              color: Color(0xFF734C10),
              fontSize: 15,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 1.33,
              letterSpacing: -0.23,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/Avatar.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Nguyễn Đình Trọng',
                style: TextStyle(
                  color: Color(0xFF002D73),
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.18,
                  letterSpacing: 0.06,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
