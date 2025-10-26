class Payment {
  String id;
  String title;
  double amount;
  String category;
  DateTime nextDate;
  String period;
  bool isFavorite;

  Payment({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.nextDate,
    required this.period,
    this.isFavorite = false,
  });

  DateTime get updatedNextDate {
    switch (period) {
      case 'Еженедельно':
        return nextDate.add(const Duration(days: 7));
      case 'Ежегодно':
        return DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
      default:
        return DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
    }
  }
}
