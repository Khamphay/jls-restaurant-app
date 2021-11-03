import 'package:flutter/material.dart';
import 'package:restaurant_app/component/payment.dart';
import 'package:restaurant_app/model/ordermenu_model.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/style/textstyle.dart';

class PaymentListPage extends StatelessWidget {
  const PaymentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: FutureBuilder<List<Order>>(
          future: Order.fetchOrderList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  String status = "";
                  Color statusColor = Colors.black;
                  double notPay = 0;

                  if (snapshot.data![index].isStatus == "pending") {
                    status = "ຍັງບໍ່ໄດ້ຈ່າຍ";
                    statusColor = Colors.amber.shade800;
                  } else if (snapshot.data![index].isStatus == "cancel") {
                    status = "ຍົກເລີກແລ້ວ";
                    statusColor = Colors.red;
                  } else {
                    status = "ຈ່າຍແລ້ວ";
                    statusColor = Colors.green.shade900;
                  }

                  if (snapshot.data![index].total >
                      snapshot.data![index].moneyUpfrontPay) {
                    notPay = snapshot.data![index].total -
                        snapshot.data![index].moneyUpfrontPay;
                  } else {
                    notPay = snapshot.data![index].moneyUpfrontPay -
                        snapshot.data![index].total;
                  }
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Card(
                          margin: const EdgeInsets.all(0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "ເບີໂຕະທີ: ${snapshot.data![index].tableName}",
                                        style: head3B),
                                    const Spacer(),
                                    Text(status,
                                        style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            color: statusColor))
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10, right: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text("ຈຳນວນ Order ທັງໝົດ:"),
                                              Text("ລວມເງີນທັງໝົດ:"),
                                              Text("ເງີນທີຈ່າຍແລ້ວ:"),
                                              Text("ຍອດທີ່ເລືອກ:"),
                                            ]),
                                        const Spacer(),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${snapshot.data![index].amount} ລາຍການ"),
                                              Text(
                                                  "${snapshot.data![index].total} ກີບ"),
                                              Text(
                                                  "${snapshot.data![index].moneyUpfrontPay} ກີບ"),
                                              Text("$notPay ກີບ"),
                                            ]),
                                      ],
                                    )),
                                ButtonBar(
                                    alignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed:
                                              snapshot.data![index].isStatus ==
                                                      "pending"
                                                  ? () async {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PaymentPage(
                                                                      showAppBar:
                                                                          true,
                                                                      order: snapshot
                                                                              .data![
                                                                          index])));
                                                    }
                                                  : null,
                                          child: const Text("ຊຳລະເງີນ"))
                                    ])
                              ],
                            ),
                          )));
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
