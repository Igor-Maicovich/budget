import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_budget/src/core/utils/extensions/int_extension.dart';

class IncDecBlock extends StatelessWidget {
  final int amount;
  final VoidCallback onTap;
  const IncDecBlock({super.key, required this.amount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color? amountColor = amount > 0
        ? Colors.green
        : Theme.of(context).textTheme.titleLarge!.color;
    return Expanded(
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(12),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amount > 0 ? 'Incomes' : 'Spending',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Transform.rotate(
                    angle: amount > 0 ? 0 : pi / 2,
                    child: Icon(
                      Icons.arrow_outward,
                      color: amountColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                amount.displayString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: amountColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
