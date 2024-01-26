import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:my_budget/src/core/assets/colors.dart';
import 'package:my_budget/src/core/utils/extensions/date_extension.dart';
import 'package:my_budget/src/feature/add_entry/model/entry.dart';
import 'package:my_budget/src/feature/history/widget/category_line_item.dart';
import 'package:my_budget/src/feature/history/widget/entry_list_tile.dart';
import 'package:my_budget/src/feature/history/widget/inc_dec_block.dart';
import 'package:my_budget/src/feature/initialization/widget/dependencies_scope.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  ScrollController controller = ScrollController();
  List<Entry> entries = [];
  late Future<List<Entry>> initEntries;
  int sumFood = 0;
  int sumMarket = 0;
  int sumTravel = 0;
  int sumFinance = 0;
  int sumIntertaiment = 0;
  int sumOther = 0;
  int expenses = 0;
  int expensesABS = 0;
  int allIncomes = 0;
  int allSpendings = 0;

  @override
  void initState() {
    initEntries = DependenciesScope.of(context).entryDao.getAllEntries();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            'History',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
        ),
        body: FutureBuilder<List<Entry>>(
          future: DependenciesScope.of(context).entryDao.getAllEntries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'Not Records',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              );
            }
            entries = snapshot.data!;
            calculate();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Expences in December',
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Details  >',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ))
                        ],
                      ),
                      Text(
                        '$expenses\$',
                        style: TextStyle(
                          color: expenses > 0 ? Colors.green : Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildGraph(context),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IncDecBlock(amount: allIncomes, onTap: () {}),
                      SizedBox(width: 16),
                      IncDecBlock(amount: allSpendings, onTap: () {}),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: GroupedListView<Entry, DateTime?>(
                        controller: controller,
                        sort: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: 14,
                          top: 20,
                          right: 14,
                          bottom: MediaQuery.of(context).padding.bottom,
                        ),
                        elements: entries,
                        groupComparator: (DateTime? f, DateTime? s) {
                          if (f == null) return -1;
                          if (s == null) return 1;
                          if (DateUtils.isSameDay(f, s)) return 0;
                          return f.compareTo(s) * -1;
                        },
                        groupBy: (item) {
                          var date = item.dateTime;
                          return DateTime(date.year, date.month, date.day);
                        },
                        groupSeparatorBuilder: (date) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                date!.dayString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                        itemBuilder: (context, item) =>
                            EntryListTile(entry: item)),
                  ),
                ),
              ],
            );
          },
        ),
      );

  void calculate() {
    sumFood = 0;
    sumMarket = 0;
    sumTravel = 0;
    sumFinance = 0;
    sumIntertaiment = 0;
    sumOther = 0;
    expenses = 0;
    expensesABS = 0;
    allIncomes = 0;
    allSpendings = 0;
    if (entries.isEmpty) return;
    for (var entry in entries) {
      expenses += entry.amount;
      expensesABS += entry.amount.abs();
      if (entry.amount > 0) {
        allIncomes += entry.amount;
      } else {
        allSpendings += entry.amount;
      }
      switch (entry.categoryTitle) {
        case 'Food':
          sumFood += entry.amount;
          break;
        case 'Market':
          sumMarket += entry.amount;
          break;
        case 'Travel':
          sumTravel += entry.amount;
          break;
        case 'Finance':
          sumFinance += entry.amount;
          break;
        case 'Entertaiment':
          sumIntertaiment += entry.amount;
          break;
        case 'Other':
          sumOther += entry.amount;
          break;
        default:
      }
    }
  }

  Widget _buildGraph(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 64;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CategoryLineItem(
          color: AppColors.iconFood,
          part: sumFood.abs() * width / expensesABS,
        ),
        CategoryLineItem(
          color: AppColors.iconMarket,
          part: sumMarket.abs() * width / expensesABS,
        ),
        CategoryLineItem(
          color: AppColors.iconTravel,
          part: sumTravel.abs() * width / expensesABS,
        ),
        CategoryLineItem(
          color: AppColors.iconFinance,
          part: sumFinance.abs() * width / expensesABS,
        ),
        CategoryLineItem(
          color: AppColors.iconEntertaiment,
          part: sumIntertaiment.abs() * width / expensesABS,
        ),
        CategoryLineItem(
          color: AppColors.iconOther,
          part: sumOther.abs() * width / expensesABS,
        ),
      ],
    );
  }
}
