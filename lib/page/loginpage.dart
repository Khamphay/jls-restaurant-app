import 'package:flutter/material.dart';
import 'package:restaurant_app/model/login_model.dart';
import 'package:restaurant_app/model/source.dart';
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
  String emptyUsername = "";
  String emptyPassword = "";

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
            padding: const EdgeInsets.only(top: 60, bottom: 20),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 40, top: 40, right: 40, bottom: 5),
                  child: Column(
                    children: [
                      Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                            controller: _userController,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                labelText: "ຊື່ຜູ້ໃຊ້",
                                errorText: emptyUsername.isNotEmpty
                                    ? emptyUsername
                                    : null,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon:
                                    const Icon(Icons.account_circle_outlined)),
                            onChanged: (text) => _userController.text.isNotEmpty
                                ? setState(() => emptyUsername = "")
                                : null),
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
                                errorText: emptyPassword.isNotEmpty
                                    ? emptyPassword
                                    : null,
                                prefixIcon: const Icon(Icons.security),
                                suffixIcon: IconButton(
                                    icon: _showPassword
                                        ? const Icon(Icons.visibility_rounded,
                                            color: Colors.grey)
                                        : const Icon(
                                            Icons.visibility_off_rounded,
                                            color: Colors.blue),
                                    onPressed: () {
                                      setState(
                                          () => _showPassword = !_showPassword);
                                    })),
                            onChanged: (text) =>
                                _passwordController.text.isNotEmpty
                                    ? setState(() => emptyPassword = "")
                                    : null),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  activeColor:
                                      const Color.fromARGB(255, 128, 0, 255),
                                  value: isCheck,
                                  onChanged: (isCheck) {
                                    setState(() {
                                      this.isCheck = !this.isCheck;
                                    });
                                  }),
                              const Text("ຈື່ຂ້ອຍໄວ້")
                            ]),
                        const SizedBox(
                          height: 40,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.maxFinite, 40)),
                          child: Text(
                            "ເຂົ້າສູ່ລະບົບ",
                            style: head3,
                          ),
                          onPressed: () async {
                             const CircularProgressIndicator();
                            emptyUsername = _userController.text.isEmpty
                                ? "ກະລຸນາປ້ອນຊື່ຜູ້ໃຊ້"
                                : emptyUsername = "";
                            emptyPassword = _passwordController.text.isEmpty
                                ? "ກະລຸນາປ້ອນລະຫັດຜ່ານ"
                                : "";
                            if (_userController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              final login = Login(
                                  username: _userController.text,
                                  password: _passwordController.text);
                              final user = await fetchUser(login);

                              if (user != null) {
                                token = "Bearer ${user.token}";
                                // restaurantId = user.restaurantId;
                                // restaurantName = user.restaurantName;
                                // branchId = user.branchId;
                                // branchName = user.branchName;
                                _userController.text = "";
                                _passwordController.text = "";
                                await Navigator.pushNamed(context, "/homepage");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.deepPurple,
                                        content: Text(
                                            "ຊື່ຜູ້ໃຊ້ ຫຼື ລະຫັດຜ່ານບໍ່ຖຶກຕ້ອງ",
                                            style: snackbar_text),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        )));
                              }
                            }
                            setState(() {});
                          },
                        )
                      ]),
                      const SizedBox(
                        height: 50,
                      ),
                      const Center(
                        child: Text("ພັດທະນາໂດຍ: ບໍລິສັດ JLS IT Solution"),
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
