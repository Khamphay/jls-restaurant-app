import 'package:flutter/material.dart';
import 'package:restaurant_app/model/ordermenu_model.dart';
import 'package:restaurant_app/model/source.dart';
import 'package:restaurant_app/model/summary.dart';
import 'package:restaurant_app/model/tables_model.dart';
import 'package:restaurant_app/style/textstyle.dart';

class CashPayment extends StatefulWidget {
  const CashPayment(
      {Key? key, required this.summary, required this.orderdetails})
      : super(key: key);
  final SummaryOrder summary;
  final List<OrderDetail> orderdetails;

  @override
  _CashPaymentState createState() => _CashPaymentState();
}

class _CashPaymentState extends State<CashPayment> {
  var txtController = TextEditingController();
  double receiveMoney = 0, moneyChange = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ຈ່າຍເງີນສົດ"),
          leading: IconButton(
              icon: const Icon(Icons.navigate_before_rounded, size: 40),
              onPressed: () => Navigator.pop(context)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("ຈຳນວນ Order ທັງໝົດ:"),
                                const Text("ລວມເງີນທັງໝົດ:"),
                                const Text("ເງີນທີ່ຈ່າຍແລ້ວ:"),
                                const Text("ຍອດທີ່ຍັງເຫຼືອ:"),
                                Text(
                                    "ສ່ວນຫຼຸດ ${widget.summary.percentDiscount}%:"),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${widget.summary.qty} ລາຍການ"),
                                Text("${widget.summary.totalPrice} ກີບ"),
                                Text("${widget.summary.paid} ກີບ"),
                                Text("${widget.summary.balance} ກີບ"),
                                Text("${widget.summary.moneyDiscount} ກີບ"),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ລວມເງີນທີ່ຕ້ອງຊຳລະ:",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text("${widget.summary.allMoneyPay} ກີບ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        // const Divider(),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                TextField(
                                  controller: txtController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 10),
                                      labelText: "ປ້ອນຈຳນວນເງີນທີ່ໄດ້ຮັບ",
                                      suffix: const Text("ກີບ")),
                                  onChanged: (text) => {
                                    if (txtController.text != "" &&
                                        double.parse(txtController.text) >
                                            widget.summary.allMoneyPay)
                                      {
                                        receiveMoney =
                                            double.parse(txtController.text),
                                        moneyChange = receiveMoney -
                                            widget.summary.allMoneyPay
                                      }
                                    else
                                      moneyChange = 0,
                                    setState(() {}),
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ເງີນທອນ:", style: head3B),
                                    const Spacer(),
                                    Text("$moneyChange ກີບ", style: head3B),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green.shade600),
                                  child: InkWell(
                                      splashColor: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Center(
                                          child: Text("ຢືນຢັນການຊຳລະ",
                                              style: head3)),
                                      onTap: () async {
                                        final table = Tables(
                                            id: table_Id,
                                            restaurantId: restaurant_Id,
                                            restaurantName: null,
                                            branchId: branch_Id,
                                            branchName: null,
                                            phone: null,
                                            status: "empty",
                                            table: null);
                                        final tables =
                                            await Tables.putTables(table);
                                        if (tables.data! > 0) {
                                          final order = Order(
                                              id: widget.summary.orderId,
                                              restaurantId: restaurant_Id,
                                              branchId: branch_Id,
                                              tableId: widget.summary.tableId,
                                              tableName: null,
                                              bankId: null,
                                              total: widget.summary.totalPrice,
                                              moneyCoupon:
                                                  widget.summary.moneyDiscount,
                                              moneyDiscount:
                                                  widget.summary.moneyDiscount,
                                              moneyUpfrontPay: 0,
                                              moneyReceived: receiveMoney,
                                              moneyChange: moneyChange,
                                              isStatus: "success",
                                              paymentType: "cash",
                                              referenceNumber: null);
                                          final put =
                                              await Order.putOrder(order);
                                          if (put.data != null &&
                                              put.data == 1) {
                                            for (final item
                                                in widget.orderdetails) {
                                              final orderDetail = OrderDetail(
                                                  id: item.id,
                                                  orderId:
                                                      widget.summary.orderId,
                                                  restaurantId: restaurant_Id,
                                                  branchId: branch_Id,
                                                  tableId:
                                                      widget.summary.tableId,
                                                  menuId: item.menuId,
                                                  menuName: null,
                                                  bankId: null,
                                                  price: item.price,
                                                  amount: item.amount,
                                                  total: item.total,
                                                  status: 'paid',
                                                  paymentType: "cash",
                                                  comment: null,
                                                  reason: null,
                                                  referenceNumber: null);

                                              await OrderDetail.putOrderDetail(
                                                  orderDetail);
                                            }
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Colors.deepPurple,
                                                    content: Text(
                                                        "ການຊຳລະເງີນສຳເລັດແລ້ວ",
                                                        style: snackbar_text),
                                                    action: SnackBarAction(
                                                      label: 'OK',
                                                      onPressed: () {},
                                                    )));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                  Colors.deepPurple,
                                              content: put.message != null
                                                  ? Text("${put.message}")
                                                  : Text("${put.error}"),
                                              action: SnackBarAction(
                                                  label: "OK",
                                                  onPressed: () {}),
                                            ));
                                          }
                                          setState(() {});
                                        }
                                      }),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
