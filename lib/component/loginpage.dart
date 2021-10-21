import 'package:flutter/material.dart';
import 'package:restaurant_app/style/textstyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;
  bool isCheck = false;
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("ເຂົ້າສູ່ລະບົບ"),
        //   elevation: 0,
        // ),
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Color.fromARGB(255, 128, 0, 255),
        Color.fromARGB(255, 179, 102, 255),
        Color.fromARGB(255, 204, 153, 255),
      ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const Icon(Icons.account_circle_outlined, size: 100),
                Text(
                  "ເຂົ້າສູ່ລະບົບ",
                  style: head1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 60, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          TextField(
                              controller: _userController,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                  labelText: "ຊື່ຜູ້ໃຊ້",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon:
                                      const Icon(Icons.account_circle_outlined))),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _passwordController,
                            obscureText: _showPassword,
                            decoration: InputDecoration(
                              labelText: "ລະຫັດຜ່ານ",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: const Icon(Icons.security),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye,
                                    color: _showPassword
                                        ? Colors.grey
                                        : Colors.blue),
                                onPressed: () {
                                  setState(
                                      () => _showPassword = !_showPassword);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                activeColor:
                                    const Color.fromARGB(255, 128, 0, 255),
                                value: this.isCheck,
                                onChanged: (isCheck) {
                                  setState(() {
                                    this.isCheck = !this.isCheck;
                                  });
                                },
                              ),
                              const Text("ຈື່ຂ້ອຍໄວ້")
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 128, 0, 255)),
                              child: InkWell(
                                onTap: () =>
                                    Navigator.pushNamed(context, "/homepage"),
                                child: Center(
                                  child: Text("ເຂົ້າສູ່ລະບົບ", style: head3),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(height: 50,),
                      const Center(
                      child:  Text("ພັດທະນາໂດຍ: ບໍລິສັດ JLS IT Solution"),
                      )
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
