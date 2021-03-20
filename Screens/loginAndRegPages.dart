import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/MainProvider.dart';
import 'package:haber/Service/login_manager.dart';
import 'package:haber/Service/strings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Succes extends StatelessWidget {
  final PageController pageController;
  final BuildContext contextpr;
  const Succes({Key key, this.pageController, this.contextpr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close_sharp,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Image.asset('assets/dunya.png'))
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/container2.png'))),
            //height: 400,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Hesab\noluşturuldu',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 280,
                    child: Image.asset('assets/succes.png')),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sayın kullanıcımız, hesabınız\n başarıyla oluşturulmuştur.\n Uygulamayı kullanmaya\n devam edin',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                              color: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                                Provider.of<MainProvider>(contextpr,
                                        listen: false)
                                    .checklogin();
                              },
                              child: Text(
                                'Devam et',
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Zaten hesabınız var mı?'),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Giriş Yapın',
                                style: GoogleFonts.quicksand(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Şartlar ve Gizlilik politikası',
                            style: GoogleFonts.quicksand(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Register extends StatelessWidget {
  final PageController pageController;
  static TextEditingController name = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController pass1 = TextEditingController();
  static TextEditingController pass2 = TextEditingController();

  const Register({Key key, this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Image.asset('assets/dunya.png'))
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/container2.png'))),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 90,
                ),
                Text(
                  'Yeni Hesap',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '*Ad Soyad',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: name,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '*E-Mail',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: email,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '*Şifre',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: pass1,
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '*Şifre tekrar',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: pass2,
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                              color: Colors.red,
                              onPressed: () async {
                                if (pass1.text.trim() == pass2.text.trim() &&
                                    pass1.text.isNotEmpty &&
                                    pass2.text.isNotEmpty &&
                                    email.text.isNotEmpty &&
                                    name.text.isNotEmpty) {
                                  await ApiManager().register(
                                      email.text, pass1.text, name.text);
                                  bool loggedIn =
                                      await ApiManager().checkLoginStatus();
                                  if (loggedIn) {
                                    pageController.jumpToPage(2);
                                  }
                                } else {
                                  print('Missing components');
                                }
                              },
                              child: Text(
                                'Kaydet',
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Zaten hesabınız var mı?'),
                            SizedBox(
                              width: 1,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () {
                                  pageController.jumpToPage(0);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Text(
                                    'Giriş Yapın',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () async {
                              try {
                                bool yes = await canLaunch(Strings.link);
                                if (yes) {
                                  launch(Strings.link, forceWebView: true);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Text(
                                'Şartlar ve Gizlilik politikası',
                                style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Login extends StatelessWidget {
  final BuildContext contextpr;
  final PageController pageController;
  static TextEditingController email = TextEditingController();
  static TextEditingController pass = TextEditingController();

  const Login({Key key, this.pageController, this.contextpr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Image.asset('assets/dunya.png'))
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/container2.png'))),
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  'E-Posta Adresiniz',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: email,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Şifreniz',
                  style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: pass,
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          pageController.jumpToPage(3);
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            'Şifrenizi mi unuttunuz?',
                            style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                              color: Colors.red,
                              onPressed: () async {
                                if (email.text.isNotEmpty &&
                                    pass.text.isNotEmpty) {
                                  await ApiManager()
                                      .signIn(email.text, pass.text);
                                  bool loggedIn =
                                      await ApiManager().checkLoginStatus();
                                  if (loggedIn) {
                                    Navigator.pop(context);
                                    Provider.of<MainProvider>(contextpr,
                                            listen: false)
                                        .checklogin();
                                  }
                                } else {}
                              },
                              child: Text(
                                'Giriş',
                                style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Hesabınız yok mu?'),
                            SizedBox(
                              width: 1,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                onTap: () {
                                  pageController.jumpToPage(1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Text(
                                    'Abone Olun',
                                    style: GoogleFonts.quicksand(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () async {
                              try {
                                bool yes = await canLaunch(Strings.link);
                                if (yes) {
                                  launch(Strings.link, forceWebView: true);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Text(
                                'Şartlar ve Gizlilik politikası',
                                style: GoogleFonts.quicksand(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class RecoverPass extends StatelessWidget {
  final PageController pageController;
  static TextEditingController email = TextEditingController();

  const RecoverPass({Key key, this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  pageController.jumpToPage(0);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Image.asset('assets/dunya.png'))
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/container2.png'))),
            //height: 400,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'E-Posta adresiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: email,
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(children: [
                  Text(
                    'E-Posta adresinize şifre yenileme linki gönderilecekdir.',
                  ),
                ]),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FlatButton(
                              color: Colors.red,
                              onPressed: () async {
                                String a =await ApiManager().resetPass(email.text);
                                print(a);
                              },
                              child: Text(
                                'Gönder',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () async {
                              try {
                                bool yes = await canLaunch(Strings.link);
                                if (yes) {
                                  launch(Strings.link, forceWebView: true);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Text(
                                'Şartlar ve Gizlilik politikası',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
