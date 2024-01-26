import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_budget/src/core/utils/extensions/int_extension.dart';
import 'package:my_budget/src/feature/add_entry/model/entry.dart';

class EntryListTile extends StatelessWidget {
  final Entry entry;
  const EntryListTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    Color? amountColor = entry.amount > 0
        ? Colors.green
        : Theme.of(context).textTheme.titleLarge!.color;
    return ListTile(
      title: Text(
        entry.place,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
      ),
      subtitle: Text(
        entry.categoryTitle,
        style: Theme.of(context).textTheme.caption!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
      ),
      leading: SvgPicture.asset(
        entry.categoryIcon,
        height: 48,
        width: 48,
      ),
      trailing: Text(
        entry.amount.displayString(),
        style: TextStyle(
          color: amountColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
