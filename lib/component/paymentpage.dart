import 'package:flutter/material.dart';
import 'package:restaurant_app/db/database_helper.dart';
import 'package:restaurant_app/model/ordermenu.dart';
import 'package:restaurant_app/style/textstyle.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late List<OrderMenu> orderList;
  bool isLoading = false;
  int _discount = 0;
  int _qty = 0;
  double _sumPrice = 0;
  double _paied = 0;

  @override
  void initState() {
    refreshOrder();
    super.initState();
  }

  Future refreshOrder() async {
    setState(() => isLoading = true);

    orderList = await DatabaseHelper.dbInstace.readAllOrder();
    if (orderList.isNotEmpty) {
      orderList.forEach((element) {
        _qty += element.qty;
        _sumPrice += element.totalPrice;
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ຊຳລະເງີນ"),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 40,
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(width: 1),
                    color: Colors.deepPurple),
                child: InkWell(
                    child:
                        Center(child: Text("ໃຊ້ລະຫັດສ່ວນຫຼຸດ", style: head3)),
                    onTap: () {}),
              )),
          const Divider(),
          Expanded(
              flex: 4,
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
                            return Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("ຊື່ເມນູ: ${orderList[index].menuName}"),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "ຈຳນວນ: ${orderList[index].qty} x ${orderList[index].price}  ກີບ"),
                                      const Spacer(),
                                      Text(
                                          "ລວມ: ${orderList[index].totalPrice} ກີບ")
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        )),
          const Divider(),
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
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
                              Text("$_paied ກີບ"),
                              Text("${_sumPrice = (_sumPrice - _paied)} ກີບ"),
                              Text("${(_sumPrice * (_discount / 100))} ກີບ"),
                            ],
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("ລວມເງີນທັງໝົດທີ່ຕ້ອງຊຳລະ:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const Spacer(),
                          Text(
                              "${_sumPrice - (_sumPrice * (_discount / 100))} ກີບ",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.payments_outlined),
        onPressed: () {},
      ),
    );
  }
}
