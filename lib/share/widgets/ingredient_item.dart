import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  final int item;
  const IngredientItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
    margin: const EdgeInsets.only(right: 9),
    decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.30,
                color: Colors.black.withValues(alpha: 77),
            ),
            borderRadius: BorderRadius.circular(8),
        ),
    ),
    child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
            Text(
                'Danh mục $item',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF615358),
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.18,
                    letterSpacing: 0.06,
                ),
            ),
        ],
    ),
);
  }
}