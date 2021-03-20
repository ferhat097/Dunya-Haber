import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/FinanceProvider.dart';
import 'package:haber/Providers/HomeProvider.dart';
import 'package:haber/Providers/MainProvider.dart';
import 'package:haber/Screens/EDunya.dart';
import 'package:haber/Screens/EMercek.dart';
import 'package:haber/Screens/Education.dart';
import 'package:haber/Screens/Ekonomi.dart';
import 'package:haber/Screens/Finans/Finance.dart';
import 'package:haber/Screens/IGAnews.dart';
import 'package:haber/Screens/Kobiden.dart';
import 'package:haber/Screens/KulturSanat.dart';
import 'package:haber/Screens/OzelDosyalar.dart';
import 'package:haber/Screens/Publisher.dart';
import 'package:haber/Screens/Saglik.dart';
import 'package:haber/Screens/SirketHaberleri.dart';
import 'package:haber/Screens/Sport.dart';
import 'package:haber/Service/localdatabase.dart';
import 'package:haber/Models/savedPost.dart';
import 'package:haber/Service/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/AllNewsProvider.dart';
import 'Providers/EducationProvider.dart';
import 'Providers/EkonomiProvider.dart';
import 'Providers/EmercekProvider.dart';
import 'Providers/GundemProvider.dart';
import 'Providers/HeadLineProvider.dart';
import 'Providers/IGAnewsProvider.dart';
import 'Providers/KulturSanatProvider.dart';
import 'Providers/OzelDosyalarProvider.dart';
import 'Providers/PiyasalarProvider.dart';
import 'Providers/PublisherProvider.dart';
import 'Providers/RamazanProvider.dart';
import 'Providers/SaglikProvider.dart';
import 'Providers/SehirlerProvider.dart';
import 'Providers/SirktetHaberleriProvider.dart';
import 'Providers/SportProvider.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Providers/YasamProvider.dart';
import 'Screens/Home2.dart';
import 'Screens/Ramazan.dart';
import 'Screens/Sehirler.dart';
import 'Screens/Yasam.dart';
import 'Screens/loginpage.dart';
import 'Models/current_rate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(SavedPostAdapter());
  await Hive.openBox<SavedPost>('posts');
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF131A20),
        statusBarColor: Color(0xFF131A20),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: Colors.greenAccent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<EkonomiProvider>(
            create: (context) => EkonomiProvider(),
          ),
          ChangeNotifierProvider<EmercekProvider>(
            create: (context) => EmercekProvider(),
          ),
          ChangeNotifierProvider<SehirlerProvider>(
            create: (context) => SehirlerProvider(),
          ),
          ChangeNotifierProvider<SirketProvider>(
            create: (context) => SirketProvider(),
          ),
          ChangeNotifierProvider<OzelProvider>(
            create: (context) => OzelProvider(),
          ),
          ChangeNotifierProvider<RamazanProvider>(
            create: (context) => RamazanProvider(),
          ),
          ChangeNotifierProvider<KulturSanatProvider>(
            create: (context) => KulturSanatProvider(),
          ),
          ChangeNotifierProvider<SaglikProvider>(
            create: (context) => SaglikProvider(),
          ),
          ChangeNotifierProvider<YasamProvider>(
            create: (context) => YasamProvider(),
          ),
          ChangeNotifierProvider<IGAnewsProvider>(
            create: (context) => IGAnewsProvider(),
          ),
          ChangeNotifierProvider<PiyasalarProvider>(
            create: (context) => PiyasalarProvider(),
          ),
          ChangeNotifierProvider<AllNewsProvider>(
            create: (context) => AllNewsProvider(),
          ),
          ChangeNotifierProvider<HeadLineProvider>(
            create: (context) => HeadLineProvider(),
          ),
          ChangeNotifierProvider<GundemProvider>(
            create: (context) => GundemProvider(),
          ),
          ChangeNotifierProvider<PublisherProvider>(
            create: (context) => PublisherProvider(),
          ),
          ChangeNotifierProvider<EducationProvider>(
            create: (context) => EducationProvider(),
          ),
          ChangeNotifierProvider<FinanceProvider>(
            create: (context) => FinanceProvider(),
          ),
          ChangeNotifierProvider<SportProvider>(
            create: (context) => SportProvider(),
          ),
          ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider(),
          ),
          ChangeNotifierProvider<MainProvider>(
            create: (context) => MainProvider(),
          )
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    Provider.of<MainProvider>(context, listen: false).checklogin();
    super.initState();
  }

  final List<Widget> screens = [
    Finance(),
    Publisher(),
    Home2(),
    Sport(),
    Education(),
    EDunya(),
    EMercek(),
    SirketHaberleri(),
    Kobiden(),
    Ramazan(),
    Ekonomi(),
    Yasam(),
    Saglik(),
    KulturSanat(),
    Sehirler(),
    IGAnews(),
    OzelDosyalar()
  ];

  Widget innerDrawerLeft() {
    return Selector<MainProvider, bool>(
      selector: (context, main) => main.loggedin,
      builder: (context, loggedin, child) {
        Map<dynamic, dynamic> data =
            Provider.of<MainProvider>(context, listen: false).data ??
                Provider.of<MainProvider>(context, listen: false).test;
        print(loggedin);
        return Container(
          height: 200,
          width: 200,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 4, right: 70, top: 30),
                      child: Container(
                        height: 45,
                        width: 150,
                        child: AspectRatio(
                            aspectRatio: 4 / 2,
                            child: Image.asset('assets/logomoon.png')),
                      ),
                    ),
                    Visibility(
                      visible: loggedin,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: "Hos Geldin",
                                  style: GoogleFonts.quicksand(fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: data['name'],
                                  style: GoogleFonts.quicksand(fontSize: 25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 20),
                            child: Container(
                              color: Colors.transparent,
                              height: 30,
                              width: 200,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .bottomnavigate(2);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .globalKey
                                        .currentState
                                        .close();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Anasayfa",
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 20),
                            child: Container(
                              color: Colors.transparent,
                              height: 30,
                              width: 200,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .bottomnavigate(5);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .globalKey
                                        .currentState
                                        .close();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "E-Dünya",
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Image.asset('assets/Line.png')),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 20),
                            child: Container(
                              color: Colors.transparent,
                              height: 30,
                              width: 200,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .bottomnavigate(6);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .globalKey
                                        .currentState
                                        .close();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "E-Mercek",
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 20),
                            child: Container(
                              color: Colors.transparent,
                              height: 30,
                              width: 200,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .bottomnavigate(1);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .globalKey
                                        .currentState
                                        .close();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Yazarlar",
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 20),
                            child: Container(
                              color: Colors.transparent,
                              height: 30,
                              width: 200,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .bottomnavigate(7);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .globalKey
                                        .currentState
                                        .close();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Şirket Haberleri",
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 20),
                            child: Container(
                              color: Colors.transparent,
                              height: 30,
                              width: 200,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .bottomnavigate(8);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .globalKey
                                        .currentState
                                        .close();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Kobiden",
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 20, top: 20),
                            child: Container(
                              color: Colors.transparent,
                              height: 30,
                              width: 200,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .bottomnavigate(0);
                                    Provider.of<MainProvider>(context,
                                            listen: false)
                                        .globalKey
                                        .currentState
                                        .close();
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Finans",
                                      style:
                                          GoogleFonts.quicksand(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(9);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Ramazan",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(10);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Ekonomi",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(11);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Yaşam",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(12);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Sağlık",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(13);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Kültür-Sanat",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(14);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Şehirler",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(15);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "İGA Haberleri",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/Line.png'),
                          ),
                          Visibility(
                            visible: loggedin,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 20, top: 20),
                              child: Container(
                                color: Colors.transparent,
                                height: 30,
                                width: 200,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .bottomnavigate(16);
                                      Provider.of<MainProvider>(context,
                                              listen: false)
                                          .globalKey
                                          .currentState
                                          .close();
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Özel Dosyalar",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: true,
                child: GestureDetector(
                  onTap: () {
                    loggedin
                        ? Provider.of<MainProvider>(context, listen: false)
                            .logout()
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context11) =>
                                  LoginPage(context1: context),
                            ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Material(
                      child: ListTile(
                        title: loggedin ? Text("Cikis Yap") : Text('Giris Yap'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget innerDrawerRight() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[900],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FutureBuilder(
            future: Hive.openBox<SavedPost>('posts'),
            builder: (context, snapshot) =>
                ValueListenableBuilder<Box<SavedPost>>(
              valueListenable: Hive.box<SavedPost>('posts').listenable(),
              builder: (context, Box<SavedPost> value, child) {
                if (value.isNotEmpty) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: value.values.length,
                    itemBuilder: (context, index) {
                      return FocusedMenuHolder(
                        animateMenuItems: true,
                        onPressed: () {},
                        menuItems: [
                          FocusedMenuItem(
                              title: Text("Oku"),
                              trailingIcon: Icon(Icons.read_more),
                              backgroundColor: Colors.blue[300],
                              onPressed: () {}),
                          FocusedMenuItem(
                              backgroundColor: Colors.amber,
                              title: Text("Paylaş"),
                              trailingIcon: Icon(Icons.share),
                              onPressed: () {
                                share(context, 'url', 'header');
                              }),
                          FocusedMenuItem(
                            title: Text("Sil"),
                            trailingIcon: Icon(Icons.delete),
                            backgroundColor: Colors.red[200],
                            onPressed: () {
                              HiveController().deletePost(
                                value.keyAt(index),
                              );
                            },
                          ),
                        ],
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Container(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  child: CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) {
                                      return Image(image: imageProvider);
                                    },
                                    imageUrl: value.getAt(index).imageUrl,
                                    placeholder: (context, string) {
                                      return Container(
                                        color: Colors.grey[100],
                                      );
                                    },
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Container(
                                  // height: 60,
                                  width: double.infinity,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[50]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 3,
                                                color: Colors.red,
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2),
                                                  child: Text(
                                                    value.getAt(index).title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              value.getAt(index).summary,
                                              maxLines: 4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueGrey[50]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Kaydedilen Haber Yok",
                            style: GoogleFonts.quicksand(
                                fontSize: 16, color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget mainScaffold(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF131A20),
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Color(0xFF131A20),
        titleSpacing: 0,
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            color: Color(0xFF131A20),
            child: FutureBuilder<List<CurrentRate>>(
              future: Provider.of<MainProvider>(context, listen: false)
                  .getCurrentRate(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 50,
                    color: Color(0xFF131A20),
                    child: Hero(
                      tag: 'rate',
                      child: CarouselSlider.builder(
                        itemCount: snapshot.data.length,
                        options: CarouselOptions(
                          height: 50,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.3,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        itemBuilder: (context, index, index2) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                snapshot.data[index].status == null
                                    ? Icon(Icons.arrow_forward,
                                        color: Colors.blueGrey[200])
                                    : snapshot.data[index].status
                                        ? Icon(
                                            Icons.arrow_upward,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.arrow_downward,
                                            color: Colors.red,
                                          ),
                                Flexible(
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: snapshot.data[index].name,
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: snapshot.data[index].rate.toString(),
                                    style: GoogleFonts.quicksand(
                                        color: Colors.white),
                                  ),
                                  /* style:  GoogleFonts.quicksand(
                               color: Colors.white, fontFamily: 'GreycliffCF'),*/
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return LinearProgressIndicator();
                }
              },
            ),
          ),
          preferredSize: Size(double.infinity, 60),
        ),
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      drawerScrimColor: Colors.transparent,
      body: Container(
        color: Color(0xFF131A20),
        child: Selector<MainProvider, int>(
          selector: (context, main) => main.page,
          builder: (context, page, child) => Container(
              color: Color(0xFF131A20),
              child: IndexedStack(index: page, children: screens)),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: Container(
          width: size.width,
          color: Colors.transparent,
          height: 60,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              CustomPaint(
                size: Size(size.width, 80),
                painter: DunyaBottomStyle(),
              ),
              Center(
                heightFactor: 0.6,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFFE02020),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 3, bottom: 3),
                    child: SizedBox(
                      height: 42,
                      width: 42,
                      child: Image.asset("assets/Bitmap.png"),
                    ),
                  ),
                  elevation: 0.1,
                  onPressed: () {
                    Provider.of<MainProvider>(context, listen: false)
                        .bottomnavigate(2);
                  },
                ),
              ),
              Selector<MainProvider, int>(
                selector: (context, main) => main.page,
                builder: (context, page, child) => Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Opacity(
                            opacity: page == 0 ? 1 : 0.5,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70),
                              ),
                              highlightColor: Colors.grey[50],
                              hoverColor: Colors.white,
                              autofocus: false,
                              onPressed: () {
                                Provider.of<MainProvider>(context,
                                        listen: false)
                                    .bottomnavigate(0);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 50,
                                width: 50,
                                child: Column(
                                  // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'assets/refund.png',
                                      ),
                                    ),
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          "Finans",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 13),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Opacity(
                          opacity: page == 1 ? 1 : 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 0),
                            child: SizedBox(
                              height: 80,
                              width: 90,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                highlightColor: Colors.grey[50],
                                hoverColor: Colors.white,
                                autofocus: false,
                                onPressed: () {
                                  Provider.of<MainProvider>(context,
                                          listen: false)
                                      .bottomnavigate(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  height: 50,
                                  width: 60,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          'assets/pen.png',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          "Yazarlar",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 13),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.15,
                      ),
                      Flexible(
                        child: Opacity(
                          opacity: page == 3 ? 1 : 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                highlightColor: Colors.grey[50],
                                hoverColor: Colors.white,
                                autofocus: false,
                                onPressed: () {
                                  Provider.of<MainProvider>(context,
                                          listen: false)
                                      .bottomnavigate(3);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  height: 50,
                                  width: 50,
                                  child: Column(
                                    // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Image.asset(
                                          'assets/football.png',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          "Spor",
                                          style: GoogleFonts.quicksand(
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Opacity(
                          opacity: page == 4 ? 1 : 0.5,
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70),
                              ),
                              highlightColor: Colors.grey[50],
                              hoverColor: Colors.white,
                              autofocus: false,
                              onPressed: () {
                                Provider.of<MainProvider>(context,
                                        listen: false)
                                    .bottomnavigate(4);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 50,
                                width: 50,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'assets/graduation.png',
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        "Eğitim",
                                        style:
                                            GoogleFonts.quicksand(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Selector<MainProvider, GlobalKey<InnerDrawerState>>(
        selector: (context, main) => main.globalKey,
        builder: (context, globalKey, child) {
          return InnerDrawer(
            rightAnimationType: InnerDrawerAnimation.static,
            swipe: false,
            backgroundDecoration: BoxDecoration(color: Colors.black),
            borderRadius: 20,
            offset: IDOffset.horizontal(0.3),
            scale: IDOffset.horizontal(0.9),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 5),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: -40,
                offset: Offset.fromDirection(3, 60),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: -70,
                offset: Offset.fromDirection(3, 110),
              ),
            ],
            onTapClose: true,
            leftChild: innerDrawerLeft(),
            rightChild: innerDrawerRight(),
            key: globalKey,
            scaffold: mainScaffold(context),
          );
        },
      ),
    );
  }
}

class DunyaBottomStyle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(
      size.width * 0.34,
      0,
    );
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.42, 25);
    path.quadraticBezierTo(size.width * 0.45, 48, size.width * 0.50, 48);
    path.quadraticBezierTo(size.width * 0.55, 48, size.width * 0.58, 25);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
