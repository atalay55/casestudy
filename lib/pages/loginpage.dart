import 'package:casestudy/core/riverpod/riverpod.dart';
import 'package:casestudy/core/sharedpreferences/sharedprefence.dart';
import 'package:casestudy/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/controller/httpcontroller.dart';
import '../core/validation/loginvalidation.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailCont = TextEditingController();
  var _passCont = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {

    var page = MediaQuery.of(context).size;
    var pageHeight = page.height;
    var pageWidth = page.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             /* SizedBox(
                  width: pageWidth / 3,
                  height: pageHeight / 4,
                  child: Image.asset("Images/anka.png")),*/
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: pageHeight / 40,
                            left: pageWidth / 10,
                            right: pageWidth / 10),
                        child: TextFormField(
                            controller: _emailCont,

                            decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                    borderRadius: BorderRadius.circular(8.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 2, color: Colors.red),
                                    borderRadius: BorderRadius.circular(8.0)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 2, color: Colors.black87),
                                    borderRadius: BorderRadius.circular(8.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.blueGrey),
                                    borderRadius: BorderRadius.circular(8.0)),
                                fillColor: Colors.white,
                                labelText: "Email"
                            ),
                            validator: (value) {
                              return LoginValidator().checkUserName(value!);
                            }
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: pageHeight / 30,
                            left: pageWidth / 10,
                            right: pageWidth / 10),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passCont,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(8.0)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 2, color: Colors.red),
                                borderRadius: BorderRadius.circular(8.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 2, color: Colors.black87),
                                borderRadius: BorderRadius.circular(8.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(8.0)),
                            label: Text(
                              "Password",
                              style: TextStyle(fontSize: 15.0),
                            ),
                            fillColor: Colors.white,
                          ),
                          validator: (value) {

                            return LoginValidator().checkPass(value!);
                          },
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(
                              left: pageWidth / 12,
                              right: pageWidth / 12,
                              bottom: pageWidth / 20),
                          child: SizedBox(
                            height: pageHeight / 16,
                            width: pageWidth,
                            child: ElevatedButton(
                                style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.green),
                                child: Text("login"),
                                onPressed: ()async {
                                  bool isTrue=_formKey.currentState!.validate();
                                  SharedPref().getenteredBefore().then((value) => print(value));
                                  if(isTrue){
                                    await HttpController().LoginUser(_emailCont.text,_passCont.text,context).then((value) async {if(value){
                                      await SharedPref().enteredBefore(true);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                                    }});

                                  }
                                  setState(() {




                                  });
                                }),
                          ))
                    ],
                  )),
                 /* Consumer(builder: (context, ref, child) {
                    final token = ref.watch(RiverpodController().tokenProvider);
                    return Text(token!);
                  }),*/
              Padding(
                padding: EdgeInsets.only(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: pageWidth / 12,
                          right: pageWidth / 20,
                          bottom: pageWidth / 10),
                      child: SizedBox(
                        height: pageHeight / 16,
                        width: pageWidth / 2.6,
                        child: ElevatedButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Colors.white,
                                side: BorderSide(width: 2, color: Colors.red)),
                            onPressed: () {
                              setState(() {
                               // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegisterPage()), (route) => false);
                              });
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(color: Colors.red),
                            )),
                      ),
                    ),

                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Text("forgot password "),
                    onTap: () {

                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassPage()));

                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}



