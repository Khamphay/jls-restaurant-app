import 'package:flutter/material.dart';
import 'package:restaurant_app/model/bank.dart';
import 'package:restaurant_app/model/source.dart';
import 'package:restaurant_app/model/summary.dart';
import 'package:restaurant_app/style/textstyle.dart';
import 'package:transparent_image/transparent_image.dart';

class QRCodePayment extends StatelessWidget {
  const QRCodePayment({Key? key, required this.bank, required this.summary})
      : super(key: key);
  final Banks bank;
  final SummaryOrder summary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ຈ່າຍຜ່ານທະນາຄານ ${bank.bank}")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.fitHeight,
                    placeholder: kTransparentImage,
                    image: imageUrl + "/${bank.QRCode}",
                  ),
                ),
                const Divider(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ສະຫຼຸບລວມ", style: head3B),
                        const SizedBox(
                          height: 10,
                        ),
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
                                Text("ສ່ວນຫຼຸດ ${summary.percentDiscount}%:"),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${summary.qty} ລາຍການ"),
                                Text("${summary.totalPrice} ກີບ"),
                                Text("${summary.paid} ກີບ"),
                                Text("${summary.balance} ກີບ"),
                                Text("${summary.moneyDiscount} ກີບ"),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("ລວມເງີນທີ່ຕ້ອງຊຳລະ:",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const Spacer(),
                            Text("${summary.allMoneyPay} ກີບ",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              TextField(
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    labelText: "ປ້ອນເລກບິນການຊຳລະ"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green.shade600),
                                child: InkWell(
                                    splashColor: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Center(
                                        child: Text("ຢືນຢັນການຊຳລະ",
                                            style: head3)),
                                    onTap: () => {}),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
