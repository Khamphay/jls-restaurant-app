import 'package:flutter/material.dart';
import 'package:restaurant_app/db/database_helper.dart';
import 'package:restaurant_app/model/category.dart';
import 'package:restaurant_app/model/ordermenu.dart';
import 'package:restaurant_app/model/source.dart';
import 'menus.dart';
import 'package:transparent_image/transparent_image.dart';

class MenuItems extends StatefulWidget {
  const MenuItems(
      {Key? key /*, required this.categories, required this.categoryId*/})
      : super(key: key);
  // final Future<List<Category>> categories;
  // final int categoryId;

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

int _axiesCount = 2;

class _MenuItemsState extends State<MenuItems> {
  late Future<List<Menus>> menus;
  late Future<List<Category>> categories;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    categories = fetchCategory();
    getMenu();
  }

  Future getMenu() async {
    setState(() => loading = true);
    final int categoryId = await categories.then((value) => value[0].id);
    menus = fetchMenus(categoryId);
    setState(() => loading = false);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double _shortSide = MediaQuery.of(context).size.shortestSide;
    final bool _useMoblielayout = _shortSide < 600;
    final Orientation _orientation = MediaQuery.of(context).orientation;

    return Column(
      children: [
        SizedBox(
          height: 60,
          width: double.infinity,
          child: FutureBuilder<List<Category>>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: InkWell(
                        child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Center(
                                child: Text(snapshot.data![index].name))),
                        onTap: () {
                          setState(() {});
                          menus = fetchMenus(snapshot.data![index].id);
                        },
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text(""));
              }
            },
          ),
        ),
        const Divider(
          color: Color.fromARGB(255, 128, 0, 255),
        ),
        Expanded(
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : FutureBuilder<List<Menus>>(
                  future: menus,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        snapshot.hasData) {
                      if (_useMoblielayout) {
                        _axiesCount =
                            _orientation == Orientation.portrait ? 2 : 3;
                      } else {
                        _axiesCount =
                            _orientation == Orientation.portrait ? 3 : 4;
                      }

                      return GridView.count(
                        crossAxisCount: _axiesCount,
                        children: List.generate(snapshot.data!.length, (index) {
                          return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 2,
                              child: InkWell(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                            Icons.add_shopping_cart_rounded,
                                            color: Colors.deepPurpleAccent,
                                            size: 20),
                                        Text(0.toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Colors.deepPurpleAccent)),
                                        const Spacer(),
                                        IconButton(
                                            icon: const Icon(
                                                Icons.favorite_border_outlined),
                                            onPressed: () {})
                                      ],
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: FadeInImage.memoryNetwork(
                                          fit: BoxFit.fill,
                                          fadeInCurve: Curves.easeIn,
                                          placeholder: kTransparentImage,
                                          image: imageUrl +
                                              "/${snapshot.data![index].image}"),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            " ຊື່ເມນູ: ${snapshot.data![index].name}"),
                                        Text(
                                            " ລາຄາ: ${snapshot.data![index].price} ກີບ"),
                                      ],
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  final _qtyController =
                                      TextEditingController(text: "1");
                                  int _id = snapshot.data![index].id;
                                  String _menuName = snapshot.data![index].name;
                                  int _qty = 0;
                                  double _price =
                                      snapshot.data![index].price.toDouble();
                                  double _sum = 0;
                                  String _image = snapshot.data![index].image;

                                  await showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: const [
                                                Icon(Icons
                                                    .add_shopping_cart_rounded),
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: FadeInImage
                                                            .memoryNetwork(
                                                                fit:
                                                                    BoxFit.fill,
                                                                placeholder:
                                                                    kTransparentImage,
                                                                image: imageUrl +
                                                                    "/$_image"),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              " ຊື່ເມນູ: $_menuName"),
                                                          Text(
                                                              " ລາຄາ: $_price ກີບ"),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                if (_qty > 1) {
                                                                  _qty -= 1;
                                                                  _qtyController
                                                                          .text =
                                                                      _qty.toString();
                                                                  _sum = _qty *
                                                                      _price;
                                                                  setState(
                                                                      () {});
                                                                }
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .remove)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 15,
                                                                    right: 15),
                                                            child: SizedBox(
                                                                width: 80,
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller:
                                                                      _qtyController,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                          border:
                                                                              OutlineInputBorder()),
                                                                )),
                                                          ),
                                                          IconButton(
                                                              onPressed: () {
                                                                _qty = int.parse(
                                                                    _qtyController
                                                                        .text);
                                                                _qty += 1;
                                                                _qtyController
                                                                        .text =
                                                                    _qty.toString();
                                                                _sum = _qty *
                                                                    _price;
                                                                setState(() {});
                                                              },
                                                              icon: const Icon(
                                                                  Icons.add)),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                          "ລວມ: ${_sum > 0 ? _sum : _price} ກີບ")
                                                    ],
                                                  ),
                                                )),
                                            actions: [
                                              ButtonBar(
                                                  alignment: MainAxisAlignment
                                                      .spaceAround,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true),
                                                        child: const Text(
                                                            "ຍົກເລີກ")),
                                                    TextButton(
                                                        onPressed: () {
                                                          if (_qty <= 0) {
                                                            _qty = 1;
                                                            _sum = _price;
                                                          }
                                                          createOrder(
                                                              _id,
                                                              _menuName,
                                                              _price,
                                                              _qty,
                                                              _sum,
                                                              _image);
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        child: const Text(
                                                            "ຢຶນຢັນ"))
                                                  ])
                                            ],
                                          );
                                        });
                                      }).then((value) => setState(() {}));
                                },
                              ));
                        }),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
        )
      ],
    );
  }
}

void createOrder(id, menuName, price, qty, sum, image) async {
  final order = OrderMenu(
      id: id,
      menuName: menuName,
      price: price,
      qty: qty,
      totalPrice: sum,
      image: image);
  await DatabaseHelper.dbInstace.createOrder(order);
}

void updateOrder(id, menuName, price, qty, sum, image) async {
  final order = OrderMenu(
      id: id,
      menuName: menuName,
      price: price,
      qty: qty,
      totalPrice: sum,
      image: image);
  await DatabaseHelper.dbInstace.updateOrder(order);
}
