import 'package:flutter/material.dart';

class CategoryLineItem extends StatelessWidget {
  final Color color;
  final double part;
  const CategoryLineItem({
    super.key,
    required this.color,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 16,
      width: part,
    );
  }
}
