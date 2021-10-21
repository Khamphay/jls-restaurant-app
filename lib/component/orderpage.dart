import 'package:flutter/material.dart';
import 'package:restaurant_app/component/paymentpage.dart';
import 'package:restaurant_app/db/database_helper.dart';
import 'package:restaurant_app/model/ordermenu.dart';
import 'package:restaurant_app/model/source.dart';
import 'package:restaurant_app/style/textstyle.dart';
import 'package:transparent_image/transparent_image.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final listKey = GlobalKey<AnimatedListState>();
  late List<OrderMenu> orderList;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshOrder();
  }

  Future refreshOrder() async {
    setState(() => isLoading = true);

    orderList = await DatabaseHelper.dbInstace.readAllOrder();

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    // DatabaseHelper.dbInstace.closeDB();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.green),
                color: Colors.green,
              ),
              child: InkWell(
                hoverColor: Colors.yellow,
                focusColor: Colors.yellow,
                highlightColor: Colors.yellow,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.payments),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("ຊຳລະເງີນ", style: head3)
                  ],
                )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PaymentPage()));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.deepPurple),
                color: Colors.red,
              ),
              child: InkWell(
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.delete),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("ຍົກເລີກທັງໝົດ", style: head3)
                  ],
                )),
                onTap: () => cancelAllOrderDialog(),
              ),
            ),
          ],
        ),
        const Divider(),
        Expanded(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : orderList.isEmpty
                  ? const Text(
                      'ບໍ່ມີ Order',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : ListView.builder(
                      key: listKey,
                      padding: const EdgeInsets.all(20),
                      itemCount: orderList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.fill,
                                      placeholder: kTransparentImage,
                                      image: imageUrl +
                                          "/${orderList[index].image}"),
                                ),
                                const Spacer(flex: 1),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "ຊື່ເມນູ: ${orderList[index].menuName}"),
                                    Text("ລາຄາ: ${orderList[index].price}"),
                                    Text("ຈຳນວນ: ${orderList[index].qty}"),
                                    Text("ລວມ: ${orderList[index].totalPrice}")
                                  ],
                                ),
                                const Spacer(flex: 4),
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.green),
                                        onPressed: () {
                                          editOrderDialog(
                                                  orderList[index].id,
                                                  orderList[index].menuName,
                                                  orderList[index].price,
                                                  orderList[index].qty,
                                                  orderList[index].image)
                                              .then((value) => {
                                                    if (value) refreshOrder(),
                                                    setState(() => {})
                                              });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_forever,
                                            color: Colors.red),
                                        onPressed: () async =>
                                            await cancelOrderDialog(index),
                                      )
                                    ])
                              ],
                            ),
                          ),
                        );
                      }),
        ),
      ],
    );
  }

  Future editOrderDialog(
      int id, String name, double price, int qty, String image) {
    int _qty = qty;
    double _sum = _qty <= 1 ? price : (_qty * price);
    var _qtyController = TextEditingController(text: qty.toString());
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.add_shopping_cart_rounded),
                  Text("ສັ່ງອາຫານ"),
                ],
              ),
              content: SizedBox(
                  height: 310,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: FadeInImage.memoryNetwork(
                              fit: BoxFit.fill,
                              placeholder: kTransparentImage,
                              image: imageUrl + "/$image"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(" ຊື່ເມນູ: $name"),
                            Text(" ລາຄາ: $price ກີບ"),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (_qty > 1) {
                                    _qty -= 1;
                                    _qtyController.text = _qty.toString();
                                    _sum = _qty * price;
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(Icons.remove)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _qtyController,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder()),
                                  )),
                            ),
                            IconButton(
                                onPressed: () {
                                  _qty = int.parse(_qtyController.text);
                                  _qty += 1;
                                  _qtyController.text = _qty.toString();
                                  _sum = _qty * price;
                                  setState(() {});
                                },
                                icon: const Icon(Icons.add)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("ລວມ: ${_sum > 0 ? _sum : price} ກີບ")
                      ],
                    ),
                  )),
              actions: [
                ButtonBar(alignment: MainAxisAlignment.spaceAround, children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("ຍົກເລີກ")),
                  TextButton(
                      onPressed: () async {
                        if (_qty <= 0) {
                          _qty = 1;
                          _sum = price;
                        }
                        await updateOrder(id, name, price, _qty, _sum, image)
                            .then((value) => value == 1
                                ? Navigator.of(context).pop(true)
                                : Navigator.of(context).pop(false));
                      },
                      child: const Text("ຢຶນຢັນ"))
                ])
              ],
            );
          });
        });
  }

  Future cancelOrderDialog(int index) {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "ຍົກເລີກ Order",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.help_outline_rounded, size: 40),
                  Text("ຕ້ອງການຍົກເລີກ Order: ${orderList[index].menuName} ບໍ?")
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      await deleteOrder(orderList[index].id) > 0
                          ? Navigator.pop(context, true)
                          : Navigator.pop(context, false);
                    },
                    child: const Text("ແມ່ນ")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("ບໍ່ແມ່ນ"))
              ],
            )).then((value) => {
          if (value == true)
            {
              orderList.removeAt(index),
              setState(() {}),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.grey,
                  content: const Text("ຍົກເລິກສຳເລັດແລ້ວ"),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  )))
            }
        });
  }

  Future cancelAllOrderDialog() {
    return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text(
                "ຍົກເລີກ Order",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.help_outline_rounded, size: 40),
                  Text("ຕ້ອງການຍົກເລີກທັງໝົດ Order ບໍ?")
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      await deleteAllOrder() > 0
                          ? Navigator.pop(context, true)
                          : Navigator.pop(context, false);
                    },
                    child: const Text("ແມ່ນ")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("ບໍ່ແມ່ນ"))
              ],
            )).then((value) => {
          if (value == true)
            {
              orderList.removeRange(0, orderList.length),
              setState(() {}),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.grey,
                  content: const Text("ຍົກເລິກສຳເລັດແລ້ວ"),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  )))
            }
        });
  }

  Future updateOrder(id, menuName, price, qty, sum, image) async {
    final order = OrderMenu(
        id: id,
        menuName: menuName,
        price: price,
        qty: qty,
        totalPrice: sum,
        image: image);
    return await DatabaseHelper.dbInstace.updateOrder(order);
  }

  Future deleteOrder(id) async {
    return await DatabaseHelper.dbInstace.delete(id);
  }

  Future deleteAllOrder() async {
    return await DatabaseHelper.dbInstace.deleteAll();
  }
}
