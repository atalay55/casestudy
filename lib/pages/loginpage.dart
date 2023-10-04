import 'package:casestudy/core/riverpod/riverpod.dart';
import 'package:casestudy/core/sharedpreferences/sharedprefence.dart';
import 'package:casestudy/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // cihaz bilgileri alınarak daha responsive kodlama yapılabilir
    // zaman sınırı olduğu için bu konuda pek uğraşamadm
    var page = MediaQuery.of(context).size;
    var pageHeight = page.height;
    var pageWidth = page.width;

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(title: Text("LoginPage"), backgroundColor: Colors.black87),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: Text(
                  "Case Study",
                  style: GoogleFonts.sanchez(fontSize: 25),
                ),
              ),
              // isteğe bağlı olarak uygulama resmi eklenebilir

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
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black87),
                                  borderRadius: BorderRadius.circular(8.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black38),
                                  borderRadius: BorderRadius.circular(8.0)),
                              fillColor: Colors.white,
                              label: Text(
                                "E-mail",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.black87),
                              ),
                            ),
                            validator: (value) {
                              return LoginValidator().checkUserName(value!);
                            }),
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
                                borderSide:
                                    BorderSide(width: 2, color: Colors.black38),
                                borderRadius: BorderRadius.circular(8.0)),
                            label: Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black87),
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
                                    backgroundColor: Colors.white60),
                                child: Text(
                                  "login",
                                  style: TextStyle(color: Colors.black87),
                                ),
                                onPressed: () async {
                                  // validatonlardan gelen değerler kontrol ediliyor
                                  bool isTrue =
                                      _formKey.currentState!.validate();

                                  if (isTrue) {
                                    // validationlarda sorun yoksa httpcontroller sınıfına istek atılarak
                                    // email ve pass kontrolu yapılır ve true değeri donerse kullanıcını daha onceden giriş yaptığı bilgisi tutulur ve anasayfaya yönlendirilir

                                    await HttpController()
                                        .LoginUser(_emailCont.text,
                                            _passCont.text, context)
                                        .then((value) async {
                                      if (value) {
                                        await SharedPref().enteredBefore(true);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      }
                                    });
                                  }
                                  setState(() {});
                                }),
                          ))
                    ],
                  )),
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
                              backgroundColor: Colors.white60,
                            ),
                            onPressed: () {
                              setState(() {
                                // kayıt olusturma sayfası eklenebilir
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
                    child: TextButton(
                      child: Text(
                        "forgot password ",
                        style: TextStyle(color: Colors.black54),
                      ),
                      onPressed: () {},
                    ),
                    onTap: () {
                      // sayfa parolayı unuttum sayfası eklenebilir
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
