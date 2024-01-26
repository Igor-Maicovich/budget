class Entry {
  final int amount;
  final String place;
  final String categoryIcon;
  final String categoryTitle;
  final DateTime dateTime;
  final String note;

  Entry({
    required this.place,
    required this.categoryIcon,
    required this.categoryTitle,
    required this.dateTime,
    required this.note,
    required this.amount,
  });
}
