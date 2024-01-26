import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_budget/src/core/assets/icons.dart';
import 'package:my_budget/src/core/components/database/database.dart';
import 'package:my_budget/src/core/utils/extensions/int_extension.dart';
import 'package:my_budget/src/feature/initialization/widget/dependencies_scope.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  List<String> toggles = ['Incomes', 'Spending'];
  String _selected = 'Incomes';
  int k = 1;
  int amount = 0;
  String catTitle = 'Food';
  String catIcon = AppIcons.food;
  DateTime selectedDate = DateTime.now();
  TextEditingController amountController = TextEditingController(text: '');
  TextEditingController placeController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  @override
  void dispose() {
    amountController.dispose();
    placeController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? amountColor = amount > 0
        ? Colors.green
        : Theme.of(context).textTheme.titleLarge!.color;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).textTheme.titleLarge!.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Entry',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              height: 38,
              width: 320,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _toggleUnit('Incomes'),
                  _toggleUnit('Spending'),
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  amount != 0 ? amount.displayString() : '',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: amountColor,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Enter amount',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          if (value.isEmpty) {
                            amount = 0;
                          } else {
                            amount = int.parse(value) * k;
                          }
                          setState(() {});
                        },
                        textAlign: TextAlign.right,
                        controller: amountController,
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 8),
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Place',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: placeController,
                        textAlign: TextAlign.right,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 8),
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                GestureDetector(
                  onTap: () async {
                    var result = await _showActionSheet(context);
                    if (result != null) {
                      catTitle = result;
                      catIcon = _getCategoryIcon(catTitle);
                    }
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        catIcon,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        catTitle,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Date',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const Spacer(),
                      Container(
                        height: 24,
                        width: 24,
                        padding: const EdgeInsets.all(2),
                        color: Theme.of(context).textTheme.titleLarge!.color,
                        child: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).colorScheme.background,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Today',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Note',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: noteController,
                        textAlign: TextAlign.right,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 8),
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 40)),
                    onPressed: () async {
                      await DependenciesScope.of(context)
                          .entryDao
                          .insert(EntryTableCompanion(
                            amount: drift.Value(amount),
                            place: drift.Value(placeController.text),
                            categoryTitle: drift.Value(catTitle),
                            categoryIcon: drift.Value(catIcon),
                            date: drift.Value(selectedDate),
                            note: drift.Value(noteController.text),
                          ));
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Make an entry",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleUnit(String text) => Expanded(
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: _selected == text
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          onPressed: () {
            setState(() {
              k = k * (-1);
              _selected = text;
            });
          },
        ),
      );

  Future<String?> _showActionSheet(BuildContext context) async =>
      showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext ctx) => CupertinoActionSheet(
          title: Text(
            'Select category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: <CupertinoActionSheetAction>[
            _categoryItem('Food'),
            _categoryItem('Market'),
            _categoryItem('Travel'),
            _categoryItem('Finance'),
            _categoryItem('Entertaiment'),
            _categoryItem('Other'),
          ],
        ),
      );

  CupertinoActionSheetAction _categoryItem(String text) =>
      CupertinoActionSheetAction(
        onPressed: () {
          Navigator.pop(context, text);
        },
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
        ),
      );

  String _getCategoryIcon(String title) {
    switch (title) {
      case 'Food':
        return AppIcons.food;
      case 'Market':
        return AppIcons.market;
      case 'Travel':
        return AppIcons.travel;
      case 'Finance':
        return AppIcons.finance;
      case 'Entertaiment':
        return AppIcons.entertaiment;
      case 'Other':
        return AppIcons.other;
      default:
        return AppIcons.food;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
