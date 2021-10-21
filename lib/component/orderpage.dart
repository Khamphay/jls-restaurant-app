import 'package:flutter/material.dart';
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
                onTap: () {},
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
                onTap: () {},
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
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete_forever,
                                            color: Colors.red),
                                        onPressed: () {
                                          showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        "ຍົກເລີກ Order"),
                                                    content: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: const [
                                                        Icon(Icons
                                                            .help_outline_rounded),
                                                        Text(
                                                            "ຕ້ອງການຍົກເລີກ Order ບໍ?")
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () async {
                                                            final resault =
                                                                await DatabaseHelper
                                                                    .dbInstace
                                                                    .delete(orderList[
                                                                            index]
                                                                        .id);
                                                            if (resault > 0) {
                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                            } else {
                                                              Navigator.pop(
                                                                  context,
                                                                  false);
                                                            }
                                                          },
                                                          child: const Text(
                                                              "ແມ່ນ")),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, false);
                                                          },
                                                          child: const Text(
                                                              "ບໍ່ແມ່ນ"))
                                                    ],
                                                  )).then((value) => {
                                                if (value == true)
                                                  {
                                                    removeItem(index),
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            content: const Text(
                                                                "ຍົກເລິກສຳເລັດແລ້ວ"),
                                                            action:
                                                                SnackBarAction(
                                                              label: 'OK',
                                                              onPressed: () {},
                                                            )))
                                                  }
                                              });
                                        },
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

  void removeItem(int index) {
    orderList.removeAt(index);
    setState(() {});
  }
}

void delete(id) async {}
