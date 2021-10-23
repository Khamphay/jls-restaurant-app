import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:restaurant_app/db/database_helper.dart';
import 'package:restaurant_app/model/coupon.dart';
import 'package:restaurant_app/model/ordermenu.dart';
import 'package:restaurant_app/model/summary.dart';
import 'package:restaurant_app/page/bankpage.dart';
import 'package:restaurant_app/page/cash_paypage.dart';
import 'package:restaurant_app/style/textstyle.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key, required this.showAppBar}) : super(key: key);
  final bool showAppBar;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late List<OrderMenu> orderList;
  bool isLoading = false;
  int _discount = 0;
  int _qty = 0;
  double _sumPrice = 0;
  double _paid = 0;
  String _warning = "";
  late SummaryOrder summary;
  var couponController = TextEditingController();

  @override
  void initState() {
    refreshOrder();
    super.initState();
  }

  Future refreshOrder() async {
    setState(() => isLoading = true);

    orderList = await DatabaseHelper.dbInstace.readAllOrder();
    if (orderList.isNotEmpty) {
      for (var element in orderList) {
        _qty += element.qty;
        _sumPrice += element.totalPrice;
      }
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final double _shortSide = MediaQuery.of(context).size.shortestSide;
    final Orientation _orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: widget.showAppBar ? AppBar(title: const Text("ຊຳລະເງີນ")) : null,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: _orientation == Orientation.portrait
                            ? _shortSide / 2
                            : _shortSide / 1,
                        height: 70,
                        child: TextFormField(
                          controller: couponController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              labelText: "ໃສ່ລະຫັດສ່ວນຫຼຸດ",
                              errorText: (_warning != "") ? _warning : null),
                        )),
                    // const SizedBox(width:10),
                    Container(
                      height: 48,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(width: 1),
                          color: Colors.deepPurple),
                      child: InkWell(
                          child: Center(child: Text("ກວດສອບ", style: head3)),
                          onTap: () async {
                            if (couponController.text == "") return;
                            final coupon =
                                await fetchCoupons(couponController.text);
                            if (coupon == null) {
                              _warning = "ບໍ່ມີຄູ່ປອງນີ້";
                            } else if (coupon.isUse == true) {
                              _warning = "ຄູ່ປອງນີ້ຖືໃຊ້ແລ້ວ";
                            } else if (coupon.dateExit
                                .isBefore(DateTime.now())) {
                              _warning = "ຄູ່ປອງນີ້ໝົດອາຍູແລ້ວ";
                            } else {
                              _discount = coupon.percentDiscount;
                              _warning="";
                            }
                            setState(() {});
                          }),
                    ),
                  ],
                )),
            const Divider(),
            Text("ລາຍການ Order ທັງໝົດ", style: head3B),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : orderList.isEmpty
                      ? const Center(
                          child: Text("ບໍ່ມີຂໍ້ມູນ"),
                        )
                      : ListView.builder(
                          itemCount: orderList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  // leading: CircleAvatar(
                                  //   backgroundColor: const Color.fromARGB(
                                  //       255, 232, 232, 232),
                                  //   child: Text("${index + 1}",
                                  //       style: const TextStyle(
                                  //           fontWeight: FontWeight.bold)),
                                  // ),
                                  title: Text(orderList[index].menuName),
                                  subtitle: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "ຈຳນວນ: ${orderList[index].qty} x ${orderList[index].price}  ກີບ",
                                          style: subtitle),
                                      const Spacer(),
                                      Text(
                                          "ລວມ: ${orderList[index].totalPrice} ກີບ",
                                          style: subtitle),
                                    ],
                                  ),
                                ),
                                //Todo: If read to the last item of 'orderList' is render one 'Sumary Widget'
                                if (index == orderList.length - 1)
                                  _showSummary()
                              ],
                            );
                          },
                        ),
            ),
            // Expanded()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: SpeedDial(
        // useRotationAnimation: true,
        tooltip: "ຊຳລະເງີນ",
        switchLabelPosition: true,
        direction: SpeedDialDirection.up,
        icon: Icons.payment_rounded,
        activeIcon: Icons.cancel_outlined,
        // activeBackgroundColor: Colors.red.shade800,
        children: [
          SpeedDialChild(
              backgroundColor: Colors.blueAccent.shade100,
              labelBackgroundColor: Colors.blueAccent.shade100,
              label: "ຈ່າຍຜ່ານ QR Code",
              child: const Icon(Icons.qr_code_2_rounded),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BankPager(summary: summary)))),
          SpeedDialChild(
              backgroundColor: Colors.green.shade100,
              labelBackgroundColor: Colors.green.shade100,
              label: "ຈ່າຍເງີນສົດ",
              child: const Icon(Icons.payments_outlined),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CashPayment(summary: summary))))
        ],
      ),
    );
  }

  Widget _showSummary() {
    double _balance = _sumPrice = (_sumPrice - _paid);
    double _moneyDiscount = (_sumPrice * (_discount / 100));
    double _mustPay = _balance - _moneyDiscount;
    summary = SummaryOrder(
        _qty, _sumPrice, _paid, _balance, _discount, _moneyDiscount, _mustPay);
    return Card(
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
                    Text("ສ່ວນຫຼຸດ $_discount%:"),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("$_qty ລາຍການ"),
                    Text("$_sumPrice ກີບ"),
                    Text("$_paid ກີບ"),
                    Text("$_balance ກີບ"),
                    Text("$_moneyDiscount ກີບ"),
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
                Text("$_mustPay ກີບ",
                    style: const TextStyle(fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    );
  }
}
