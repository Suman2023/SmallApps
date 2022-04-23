import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/locator.dart';
import 'package:todo/providers/authentication_provider.dart';
import 'package:todo/services/api_service.dart';
import 'package:todo/views/home_screen.dart';
import 'package:todo/views/main_screen.dart';

class AuthenticationScreen extends ConsumerWidget {
  AuthenticationScreen({Key? key}) : super(key: key);
  final client = locator<ApiService>();
  Box accountBox = Hive.box('accounts');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final _usernameController = ref.watch(usernameStateProvider.state);

    final _confirmPasswordController =
        ref.watch(confirmPasswordStateProvider.state);

    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.center, children: [
        Container(
          height: height,
          width: width,
          child: Image.network(
            "https://images.unsplash.com/photo-1528716321680-815a8cdb8cbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
            fit: BoxFit.fill,
          ),
        ),
        authButtonWidgets(context, width),
      ]),
    );
  }

  Widget authButtonWidgets(BuildContext context, double width) {
    return Positioned(
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                await showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    context: context,
                    builder: (context) => Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: registerWidget(),
                        ));
              },
              child: Container(
                  width: width * .90,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  )),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(100)),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: signinWidget()));
              },
              child: Container(
                  width: width * .90,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                    child: Center(
                      child: Text(
                        "SignIn",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text("Creating an account"),
          Text("keeps track of your list  in the cloud"),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget signinWidget() {
    return Consumer(builder: (context, ref, child) {
      final _emailController = ref.watch(emailStateProvider.state);
      final _passwordController = ref.watch(passwordStateProvider.state);
      final _errorText = ref.watch(errorTextProvider.state);
      return Container(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(builder: (context, ref, child) {
                return TextFormField(
                  controller: _emailController.state,
                  // onChanged: (newVal) {
                  //   _emailController.state.text = newVal;
                  // },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      hintText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                );
              }),
              const SizedBox(
                height: 5,
              ),
              Consumer(builder: (context, ref, child) {
                return TextFormField(
                  controller: _passwordController.state,
                  // onChanged: (newVal) {
                  //   _passwordController.state.text = newVal;
                  // },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Password",
                      errorText: _errorText.state,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      suffixIcon: IconButton(
                          splashRadius: 0.1,
                          onPressed: () {},
                          icon: Icon(Icons.visibility))),
                  keyboardType: TextInputType.visiblePassword,
                );
              }),
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)))),
                  onPressed: () async {
                    Map<dynamic, dynamic>? response =
                        await locator<ApiService>().getToken(
                            username: _emailController.state.text,
                            password: _passwordController.state.text);
                    if (response == null) {
                      _errorText.state = "Invalid Credentials";
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                      await accountBox.put('email', response['email']);
                      await accountBox.put('username', response['username']);
                      await accountBox.put('token', response['token']);
                      _emailController.state.clear();
                      _passwordController.state.clear();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => MainScreen()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("SignIn"),
                  ))
            ],
          ),
        ),
      );
    });
  }

  Widget registerWidget() {
    return Container(
      // height: 500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  hintText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  hintText: "Username"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  errorText: null,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  suffixIcon: IconButton(
                      splashRadius: 0.1,
                      onPressed: () {},
                      icon: Icon(Icons.visibility))),
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Confirm Password",
                  errorText: null,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  suffixIcon: IconButton(
                      splashRadius: 0.1,
                      onPressed: () {},
                      icon: Icon(Icons.visibility))),
              keyboardType: TextInputType.visiblePassword,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)))),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("Register"),
                ))
          ],
        ),
      ),
    );
  }
}
