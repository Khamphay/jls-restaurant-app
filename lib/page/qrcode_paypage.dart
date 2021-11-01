import 'package:flutter/material.dart';
import 'package:restaurant_app/model/bank_model.dart';
import 'package:restaurant_app/model/ordermenu_model.dart';
import 'package:restaurant_app/model/source.dart';
import 'package:restaurant_app/model/summary.dart';
import 'package:restaurant_app/model/tables_model.dart';
import 'package:restaurant_app/style/textstyle.dart';
import 'package:transparent_image/transparent_image.dart';

class QRCodePayment extends StatelessWidget {
  const QRCodePayment(
      {Key? key,
      required this.bank,
      required this.summary,
      required this.orderdetails})
      : super(key: key);
  final Banks bank;
  final SummaryOrder summary;
  final List<OrderDetail> orderdetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ຈ່າຍຜ່ານທະນາຄານ ${bank.bank}"),
          leading: IconButton(
              icon: const Icon(Icons.navigate_before_rounded, size: 40),
              onPressed: () => Navigator.pop(context)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.fitHeight,
                    placeholder: kTransparentImage,
                    image: imageUrl + "/${bank.QRCode}",
                  ),
                ),
                const Divider(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ສະຫຼຸບລວມ", style: head3B),
                        const SizedBox(
                          height: 10,
                        ),
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
                                Text("ສ່ວນຫຼຸດ ${summary.percentDiscount}%:"),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${summary.qty} ລາຍການ"),
                                Text("${summary.totalPrice} ກີບ"),
                                Text("${summary.paid} ກີບ"),
                                Text("${summary.balance} ກີບ"),
                                Text("${summary.moneyDiscount} ກີບ"),
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
                            Text("${summary.allMoneyPay} ກີບ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    labelText: "ປ້ອນເລກບິນການຊຳລະ"),
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
                                            id: summary.orderId,
                                            restaurantId: restaurant_Id,
                                            branchId: branch_Id,
                                            tableId: summary.tableId,
                                            tableName: null,
                                            bankId: bank.id,
                                            total: summary.totalPrice,
                                            moneyCoupon: summary.moneyDiscount,
                                            moneyDiscount:
                                                summary.moneyDiscount,
                                            moneyUpfrontPay: 0,
                                            moneyReceived: 0,
                                            moneyChange: 0,
                                            isStatus: "success",
                                            paymentType: "bank",
                                            referenceNumber: null);
                                        final put = await Order.putOrder(order);
                                        if (put.data != null && put.data == 1) {
                                          for (final item in orderdetails) {
                                            final orderDetail = OrderDetail(
                                                id: item.id,
                                                orderId: summary.orderId,
                                                restaurantId: restaurant_Id,
                                                branchId: branch_Id,
                                                tableId: summary.tableId,
                                                menuId: item.menuId,
                                                menuName: null,
                                                bankId: bank.id,
                                                price: item.price,
                                                amount: item.amount,
                                                total: item.total,
                                                status: 'paid',
                                                paymentType: "bank",
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
                                                    label: 'OK',
                                                    onPressed: () {},
                                                  )));
                                        }
                                      }
                                    }),
                              ),
                            ],
                          ),
                        )
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
