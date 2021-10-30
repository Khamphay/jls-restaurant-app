import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/model/category_model.dart';
import 'package:restaurant_app/model/source.dart';
import 'package:restaurant_app/model/tables_model.dart';
import 'package:restaurant_app/page/loginpage.dart';

import 'package:restaurant_app/page/homepage.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  // String _title = "";
  int _axiesCount = 3;
  // bool _seleteColor = true;
  late Future<List<Category>> categories;
  late Future<Tables> tables;
  late int categoryId;

  @override
  void initState() {
    tables = Tables.fetchTables();
    categories = fetchCategory();
    categories.then((value) => categoryId = value[0].id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _shortSide = MediaQuery.of(context).size.shortestSide;
    final bool _useMoblielayout = _shortSide < 600;
    final Orientation _orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("ເລືອກໂຕະ"),
        leading: IconButton(
            icon: const Icon(Icons.navigate_before_rounded, size: 40),
            onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => LoginPage()))
                  },
              icon: const Icon(Icons.logout))
        ],
      ),
      // drawer: Drawer(child: myDrawer(context)),
      body: SafeArea(
        child: FutureBuilder<Tables>(
            future: tables,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (_useMoblielayout) {
                  _axiesCount = _orientation == Orientation.portrait ? 3 : 4;
                } else {
                  _axiesCount = _orientation == Orientation.portrait ? 4 : 6;
                }

                return GridView.count(
                  crossAxisCount: _axiesCount,
                  children:
                      List.generate(snapshot.data!.table!.length, (index) {
                    return Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 2,
                        shadowColor: Colors.white,
                        color: snapshot.data!.table![index].status == 'empty'
                            ? Colors.white
                            : Colors.blue,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {
                            String? restaurant = snapshot.data!.restaurantName;
                            table_Id = snapshot.data!.table![index].id;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MenuPage(
                                        restaurant: restaurant,
                                        tableId: table_Id)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(snapshot.data!.table![index].name),
                              Text(
                                  snapshot.data!.table![index].status == 'empty'
                                      ? 'ຫວ່າງ'
                                      : 'ບໍ່ຫວ່າງ'),
                            ],
                          ),
                        ));
                  }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
