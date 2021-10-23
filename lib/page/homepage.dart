import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/component/ordermenus.dart';
import 'package:restaurant_app/component/paymentlist.dart';
import 'package:restaurant_app/component/payment.dart';
import 'package:restaurant_app/component/menulist.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key, required this.restaurant, required this.tableId})
      : super(key: key);
  final String restaurant;
  final int tableId;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // String _titlebar = "ເລືອກເມນູອາຫານ";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _itemPage.length,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.restaurant),
            elevation: 0,
          ),
          body: TabBarView(
            children: _itemPage,
          ),
          bottomNavigationBar: ConvexAppBar.badge(
            const <int, dynamic>{1: "2", 2: "!", 3: "4"},
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
              // _titlebar = titleBar[index];
              // setState(() {});
            },
          )),
    );
  }
}

final _itemPage = <Widget>[
  const MenuItems(),
  const OrderPage(),
  PaymentPage(showAppBar: false),
  const PaymentListPage()
];

const menuIcon = <String, IconData>{
  'Menu': Icons.fastfood,
  'Order': Icons.add_shopping_cart_rounded,
  'Payment': Icons.payments_outlined,
  'History': Icons.history_outlined,
};

const titleBar = <String>[
  "ເລືອກເມນູອາຫານ",
  "ລາຍການ Order",
  "ຊຳລະເງີນ",
  "ປະຫວັດການຊຳລະ"
];

// Widget _orderPage(BuildContext context) {
//   return
// }
