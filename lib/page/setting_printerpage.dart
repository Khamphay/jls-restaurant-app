import 'package:flutter/material.dart';
import 'package:restaurant_app/style/textstyle.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({Key? key}) : super(key: key);

  @override
  _PrinterPageState createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  var ipController = TextEditingController();
  var portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ຕັ້ງຄ່າ Printer")),
      body: Container(
        // padding: const EdgeInsets.only(top: 10),
        color: const Color.fromARGB(255, 240, 240, 240),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 10, right: 8, bottom: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ເຄື່ອງພິມໃບບິນອາຫານ", style: head3B),
                      const Divider(),
                      const Text("Printer IP Address"),
                      TextField(
                        controller: ipController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                          hintText: "192.168.0.1",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Port Number"),
                      TextField(
                        controller: portController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                          hintText: "3306",
                        ),
                      ),
                      const SizedBox(height: 10),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: const Text("ບັນທຶກ"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 10, right: 8, bottom: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ເຄື່ອງພິມໃບບິນເຄື່ອງດື່ມ", style: head3B),
                      const Divider(),
                      const Text("Printer IP Address"),
                      TextField(
                        controller: ipController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                          hintText: "192.168.0.1",
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Port Number"),
                      TextField(
                        controller: portController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                          hintText: "3306",
                        ),
                      ),
                      const SizedBox(height: 10),
                      ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {}, child: const Text("ບັນທຶກ"))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
