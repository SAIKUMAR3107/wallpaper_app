import 'package:flutter/material.dart';
import 'package:gallery_app/pages/home_screen.dart';
import 'package:gallery_app/pages/register_screen.dart';
import 'package:gallery_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email = TextEditingController();
  var password = TextEditingController();
  bool passwordVisibility = true;
  String hintText = "";
  bool hint = false;


  TextEditingController validateEmail(TextEditingController email) {
    setState(() {
      if(email.text.endsWith("@gmail.com")){
        hint = true;
      }
      else if(email.text.isEmpty){
        hint = false;

      }
      else{
        hint = false;
        hintText = "Must be ends with @gmail.com";
      }
    });
    return email;
  }

  TextEditingController validatePassword(TextEditingController password) {
    setState(() {
      if(password.text.length>=6){
        hint = true;
      }
      else if(password.text.isEmpty){
        hint = false;

      }
      else{
        hint = false;
        hintText = "must contains 6 letters";
      }
    });
    return password;
  }

  void login() async{
    var authService = AuthServices();
    try{
      print(email.text);
      await authService.loginWithEmailPassword(email.text.toString(), password.text.toString());
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    }
    catch (e){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())));
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: validateEmail(email),
                  decoration: InputDecoration(
                      labelText: "email",
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green))),
                ),
              ),
              hint ? Container() : Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(hintText,style: TextStyle(color: Colors.red),)),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: validatePassword(password),
                  obscureText: passwordVisibility,
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
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.orange)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.green))),
                ),
              ),
              hint ? Container() : Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(hintText,style: TextStyle(color: Colors.red),)),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        hintText = "Field should not be Empty";
                        login();
                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                      },
                      child: Text("Login")),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?  ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text("Register now"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
