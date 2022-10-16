import 'package:customer_web/models/customer.dart';
import 'package:customer_web/pages/new_order_page.dart';
import 'package:customer_web/web/api_methods.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String _pathPng = 'assets/page.png';

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 108, 0, 0.25),
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.1),
        title: const Center(child: Text('Авторизация')),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            _pathPng,
            fit: BoxFit.cover,
            width: 1920,
          ),
          Center(
            child: Column(
              children: [
                const Expanded(flex: 4, child: SizedBox()),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(255, 108, 0, 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(255, 182, 53, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Пароль',
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(255, 108, 0, 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(255, 182, 53, 1),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 108, 0, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 100,
                    width: 450,
                    child: TextButton(
                      child: const Text(
                        'Войти в аккаунт',
                        style: TextStyle(
                          fontSize: 35,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      onPressed: () {
                        if (_email.value.text != '' &&
                            _password.value.text != '') {
                          ApiMethods.login(Customer(
                              id: '',
                              login: _email.value.text,
                              password: _password.value.text,
                              fullName: 'asd',
                              completedOrderIds: [],
                              futureOrderIds: [],
                              currentOrderIds: [])).then((value) {
                            if (value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const NewOrderPage(
                                            restorationId: 'main',
                                          )));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return const AlertDialog(
                                      title: Text(
                                          'Что-то пошло не так..\nПроверьте логин и пароль'),
                                    );
                                  });
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          TextEditingController regLogin =
                              TextEditingController();
                          TextEditingController regPass =
                              TextEditingController();
                          TextEditingController regPassRepeat =
                              TextEditingController();
                          return SimpleDialog(
                            contentPadding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Text('Регистрация'),
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextField(
                                    controller: regLogin,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      labelText: 'Email',
                                      labelStyle: const TextStyle(
                                        color: Color.fromRGBO(255, 108, 0, 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(255, 182, 53, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextField(
                                    controller: regPass,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      labelText: 'Пароль',
                                      labelStyle: const TextStyle(
                                        color: Color.fromRGBO(255, 108, 0, 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(255, 182, 53, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: TextField(
                                    controller: regPassRepeat,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      labelText: 'Повторите пароль',
                                      labelStyle: const TextStyle(
                                        color: Color.fromRGBO(255, 108, 0, 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(255, 182, 53, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 108, 0, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 100,
                                  width: 300,
                                  child: TextButton(
                                    child: const Text(
                                      'Зарегистрироваться',
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (regPass.value.text !=
                                          regPassRepeat.value.text) {
                                        showAboutDialog(
                                            context: context,
                                            applicationName:
                                                'Не соответствуют пароли');
                                        return;
                                      }
                                      register(regLogin.value.text,
                                          regPass.value.text);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Зарегистироваться',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> register(String login, String pass) async {
    final value = await ApiMethods.register(Customer(
        id: "",
        login: login,
        password: pass,
        fullName: 'Ivan Ivanovich Ivankin',
        completedOrderIds: [],
        futureOrderIds: [],
        currentOrderIds: []));
    if (value) {
      showDialog(
          context: context,
          builder: (_) {
            return const AlertDialog(
              title: Text('Регистрация прошла успешно\nВойдите в аккаунт'),
            );
          });
      return true;
    } else {
      showDialog(
          context: context,
          builder: (_) {
            return const AlertDialog(
              title: Text('Что-то пошло не так..\nПопробуйте позже'),
            );
          });
      return false;
    }
  }
}
