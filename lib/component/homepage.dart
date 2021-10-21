import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/component/orderpage.dart';
import 'package:restaurant_app/component/paymentlistpage.dart';
import 'package:restaurant_app/model/category.dart';
import 'package:restaurant_app/model/menuitems.dart';

class MenuPage extends StatefulWidget {
  const MenuPage(
      {Key? key,
      required this.tableId,
      required this.categories,
      required this.categoryId})
      : super(key: key);

  final int tableId;
  final Future<List<Category>> categories;
  final int categoryId;

  @override
  _MenuPageState createState() => _MenuPageState();
}

final _itemPage = <Widget>[
  // 'menuItem':MenuItems(
  //             categories: widget.categories, categoryId: widget.categoryId),
  const MenuItems(),
  const OrderPage(),
  const PaymentListPage()
];

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("ເລືອກເມນູອາຫານ"),
            elevation: 0,
          ),
          body: TabBarView(
            children: _itemPage,
          ),
          bottomNavigationBar: ConvexAppBar.badge(
            const <int, dynamic>{1: "2", 2: "5"},
            badgeMargin:
                const EdgeInsets.only(left: 25, top: 0, bottom: 30, right: 0),
            backgroundColor: const Color.fromARGB(255, 128, 0, 255),
            gradient: const LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 128, 0, 255),
              Color.fromARGB(255, 179, 102, 255),
              Color.fromARGB(255, 153, 51, 255),
            ]),
            style: TabStyle.reactCircle,
            items: <TabItem>[
              for (final tab in menuIcon.entries)
                TabItem(icon: tab.value, title: tab.key)
            ],
            onTap: (int index) async {
              //Todo: Any Code here
            },
          )),
    );
  }
}

const menuIcon = <String, IconData>{
  'Menu': Icons.fastfood,
  'Order': Icons.add_shopping_cart_rounded,
  'Pay': Icons.payment,
};


// Widget _orderPage(BuildContext context) {
//   return
// }
