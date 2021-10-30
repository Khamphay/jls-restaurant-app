class SummaryOrder {
  int tableId;
  int orderId;
  int qty;
  double totalPrice;
  double paid;
  double balance;
  int percentDiscount;
  double moneyDiscount;
  double allMoneyPay;
  SummaryOrder({
    required this.tableId,
    required this.orderId,
    required this.qty,
    required this.totalPrice,
    required this.paid,
    required this.balance,
    required this.percentDiscount,
    required this.moneyDiscount,
    required this.allMoneyPay,
  });
  
}
