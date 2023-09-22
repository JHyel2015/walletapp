class ExpenseItem {
  final String name;
  final String amount;
  final DateTime dateTime;
  bool status = true;
  final int categoryId;
  final int type;
  final int bankId;
  bool recurrent = false;
  bool repeated = false;
  bool ignored = false;

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.status,
    required this.categoryId,
    required this.type,
    required this.bankId,
    required this.recurrent,
    required this.repeated,
    required this.ignored,
  });
}
