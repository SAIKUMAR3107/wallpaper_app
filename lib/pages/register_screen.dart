import 'package:flutter/material.dart';
import 'package:gallery_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  var cnfPassword = TextEditingController();
  bool passwordVisibility = true;
  String hintText = "";
  bool hint = false;

  TextEditingController validateEmail(TextEditingController email) {
    setState(() {
      if (email.text.endsWith("@gmail.com")) {
        hint = true;
      } else if (email.text.isEmpty) {
        hint = false;
      } else {
        hint = false;
        hintText = "Must be ends with @gmail.com";
      }
    });
    return email;
  }

  TextEditingController validatePassword(TextEditingController password) {
    setState(() {
      if (password.text.length >= 6) {
        hint = true;
      } else if (password.text.isEmpty) {
        hint = false;
      } else {
        hint = false;
        hintText = "must contains 6 letters";
      }
    });
    return password;
  }

  void register() async {
    var auth = AuthServices();
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        cnfPassword.text.isNotEmpty) {
      if (password.text == cnfPassword.text) {
        try {
          var shared = await SharedPreferences.getInstance();
          shared.setBool("isLogin", true);
          auth.registerWithEmailAndPassword(email.text, password.text);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(e.toString()),
                  ));
        }
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Password & Confirm Password should be same"),
                ));
      }
    } else {
      setState(() {
        hint = false;
        hintText = "Field should not be empty";
      });
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Field should not be empty"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/laptop.jpg",
                  ),
                  fit: BoxFit.fill)),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Register",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: validateEmail(email),
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green))),
                ),
              ),
              hint
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        hintText,
                        style: TextStyle(color: Colors.red),
                      )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: validatePassword(password),
                  obscureText: passwordVisibility,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        color: Colors.green,
                        icon: Icon(passwordVisibility
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green))),
                ),
              ),
              hint
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        hintText,
                        style: TextStyle(color: Colors.red),
                      )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: validatePassword(cnfPassword),
                  obscureText: passwordVisibility,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                        color: Colors.green,
                        icon: Icon(passwordVisibility
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                      ),
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green))),
                ),
              ),
              hint
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        hintText,
                        style: TextStyle(color: Colors.red),
                      )),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.orange),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {
                        hintText = "Field should not be Empty";
                        register();
                      },
                      child: Text(
                        "R E G I S T E R",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?  ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
