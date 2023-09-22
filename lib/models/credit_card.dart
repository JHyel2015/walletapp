class CreditCard {
  final int id;
  final String name;
  final int accountId;
  final int closingDay;
  final int expirationDay;
  final String color;

  CreditCard({
    required this.name,
    required this.id,
    required this.accountId,
    required this.closingDay,
    required this.expirationDay,
    required this.color,
  });
}
