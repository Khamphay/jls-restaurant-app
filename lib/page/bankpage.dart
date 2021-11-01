import 'package:flutter/material.dart';
import 'package:restaurant_app/model/bank_model.dart';
import 'package:restaurant_app/model/ordermenu_model.dart';
import 'package:restaurant_app/model/source.dart';
import 'package:restaurant_app/model/summary.dart';
import 'package:restaurant_app/page/qrcode_paypage.dart';
import 'package:transparent_image/transparent_image.dart';

class BankPager extends StatefulWidget {
  const BankPager({Key? key, required this.summary, required this.orderdetails})
      : super(key: key);
  final SummaryOrder summary;
  final List<OrderDetail> orderdetails;

  @override
  State<BankPager> createState() => _BankPagerState();
}

class _BankPagerState extends State<BankPager> {
  int _axiesCount = 2;

  @override
  Widget build(BuildContext context) {
    final double _shortSide = MediaQuery.of(context).size.shortestSide;
    final bool _useMoblielayout = _shortSide < 600;
    final Orientation _orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text("ເລືອກທະນາຄານ"),
        leading: IconButton(
            icon: const Icon(Icons.navigate_before_rounded, size: 40),
            onPressed: () => Navigator.pop(context)),
      ),
      body: FutureBuilder<List<Banks>>(
        future: fetchBanks(restaurant_Id, branch_Id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (_useMoblielayout) {
              _axiesCount = _orientation == Orientation.portrait ? 3 : 4;
            } else {
              _axiesCount = _orientation == Orientation.portrait ? 4 : 5;
            }

            return GridView.count(
              crossAxisCount: _axiesCount,
              children: List.generate(
                  snapshot.data!.length,
                  (index) => Container(
                        // color: Colors.amber,
                        margin: const EdgeInsets.all(8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: FadeInImage.memoryNetwork(
                                      fit: BoxFit.fill,
                                      placeholder: kTransparentImage,
                                      image: imageUrl +
                                          "/${snapshot.data![index].QRCode}",
                                    ),
                                  )),
                              Text(snapshot.data![index].bank)
                            ],
                          ),
                          onTap: () async {
                            final bank = Banks(
                                snapshot.data![index].id,
                                snapshot.data![index].bank,
                                snapshot.data![index].QRCode);
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => QRCodePayment(
                                        bank: bank,
                                        summary: widget.summary,
                                        orderdetails: widget.orderdetails)));
                          },
                        ),
                      )),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
