import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget myDrawer(BuildContext context) {
  return ListView(
    children: [
      DrawerHeader(
        padding: const EdgeInsets.all(0),
        child: Container(
          color: Colors.blue,
          child: Center(
              child: Column(
            children: [
              CircleAvatar(
                  child: FlutterLogo(
                size: 50,
              ))
            ],
          )),
        ),
      ),
      ListTile(
        leading: Icon(Icons.account_circle_rounded),
        title: Text("ຈັດການບັນຊີ"),
        onTap: () => {},
      ),
      ListTile(
        leading: Icon(Icons.wb_cloudy),
        title: Text("Sync Data"),
        onTap: () => {},
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("ການຕັ້ງຄ່າ"),
        onTap: () => {},
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text("ກ່ຽວກັບ"),
        onTap: () => {},
      ),
    ],
  );
}
