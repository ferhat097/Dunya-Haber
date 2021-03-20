import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/FinanceProvider.dart';
import 'package:haber/Providers/FinansProviders/1000TLProvider.dart';
import 'package:haber/Providers/FinansProviders/BitsStatProvider.dart';
import 'package:haber/Providers/FinansProviders/BorsaProvider.dart';
import 'package:haber/Providers/MainProvider.dart';
import 'package:haber/Screens/Finans/Borsa.dart';
import 'package:haber/Screens/DetailScreen.dart';
import 'package:haber/Screens/Finans/1000TLneOldu.dart';
import 'package:haber/Screens/Finans/EnCokIslemGorenler.dart';
import 'package:haber/Service/localdatabase.dart';
import 'package:haber/Models/current_rate.dart';
import 'package:haber/Models/post_model.dart';
import 'package:haber/Models/savedPost.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../Service/utils.dart';
import '../Search.dart';

class Finance extends StatefulWidget {
  @override
  _FinanceState createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Provider1000TL(),
        ),
        ChangeNotifierProvider(
          create: (context) => BitsStatsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BorsaProvider(),
        ),
      ],
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF131A20),
            title: title(context),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: bottom(),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                key: PageStorageKey(1),
                child: Haber(),
              ),
              Container(
                key: PageStorageKey(2),
                child: Borsa(),
              ),
              Container(
                key: PageStorageKey(3),
                child: BinTL(),
              ),
              Container(
                key: PageStorageKey(4),
                child: EnCokIslemGorenler(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding title(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Provider.of<MainProvider>(context, listen: false)
                          .globalKey
                          .currentState
                          .open(direction: InnerDrawerDirection.start);
                    },
                    child: Image.asset('assets/dot.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  height: 45,
                  width: 100,
                  child: AspectRatio(
                    aspectRatio: 4 / 2,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),
                      // splashColor: Colors.transparent,
                      onTap: () {
                        List currentRate =
                            Provider.of<MainProvider>(context, listen: false)
                                .currentRate;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              currentRate: currentRate,
                            ),
                          ),
                        );
                      },
                      child: Image.asset('assets/search.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Provider.of<MainProvider>(context, listen: false)
                          .globalKey
                          .currentState
                          .open(direction: InnerDrawerDirection.end);
                    },
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset('assets/fav.png'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bottom() {
    return TabBar(
      indicatorColor: Colors.red,
      labelColor: Colors.red,
      unselectedLabelColor: Colors.black,
      isScrollable: true,
      tabs: [
        Tab(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text('Finans Haberleri'),
            ),
          ),
        ),
        Tab(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text('Borsa'),
            ),
          ),
        ),
        Tab(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text('1000 TL\'ye ne oldu?'),
            ),
          ),
        ),
        Tab(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[50],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Text('En çok işlem görenler'),
            ),
          ),
        ),
      ],
    );
  }
}

class Haber extends StatefulWidget {
  const Haber({
    Key key,
  }) : super(key: key);

  @override
  _HaberState createState() => _HaberState();
}

class _HaberState extends State<Haber> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.grey[50],
      child: RefreshIndicator(
        onRefresh: () {
          return Provider.of<FinanceProvider>(context, listen: false)
              .refreshFinanceNews();
        },
        child: FutureBuilder<List<Item>>(
          future: Provider.of<FinanceProvider>(context, listen: false)
              .getFinanceNews(),
          builder: (context, snapshot) {
            List<CurrentRate> currentRate =
                Provider.of<MainProvider>(context, listen: false).currentRate;
            if (snapshot.hasData) {
              return NotificationListener<ScrollNotification>(
                // ignore: missing_return
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent) {
                    Provider.of<FinanceProvider>(context, listen: false)
                        .getMoreFinanceNews();
                    print('a');
                  }
                },
                child: Consumer<FinanceProvider>(
                  builder: (context, value, child) {
                    return ValueListenableBuilder<Box<SavedPost>>(
                      valueListenable:
                          Hive.box<SavedPost>('posts').listenable(),
                      builder: (context, Box<SavedPost> box, child) =>
                          ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.financeNews.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.grey[50],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: value.financeNews[index].image
                                                  .url !=
                                              null
                                          ? Stack(
                                              children: [
                                                SizedBox(
                                                  height: 200,
                                                  width: double.infinity,
                                                  child: FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Image.network(value
                                                        .financeNews[index]
                                                        .image
                                                        .url),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 7,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    3)),
                                                        color: Colors.red),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4,
                                                      ),
                                                      child: Text(
                                                        value.financeNews[index]
                                                                    .diffrence >
                                                                1
                                                            ? value
                                                                        .financeNews[
                                                                            index]
                                                                        .diffrence <
                                                                    1440
                                                                ? value.financeNews[index]
                                                                            .diffrence <
                                                                        60
                                                                    ? '${DateTime.now().difference(value.financeNews[index].dateTime).inMinutes.toString()} dakika önce'
                                                                    : '${DateTime.now().difference(value.financeNews[index].dateTime).inHours.toString()} saat önce'
                                                                : '${DateTime.now().difference(value.financeNews[index].dateTime).inDays.toString()} gün önce'
                                                            : 'Şimdi',
                                                        style: GoogleFonts
                                                            .quicksand(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 7,
                                                  top: 7,
                                                  child: SizedBox(
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      elevation: 2,
                                                      shadowColor:
                                                          Colors.black12,
                                                      color: Colors.transparent,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        onTap: () {
                                                          share(
                                                              context,
                                                              value
                                                                  .financeNews[
                                                                      index]
                                                                  .link,
                                                              value
                                                                  .financeNews[
                                                                      index]
                                                                  .title);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child: Image.asset(
                                                                'assets/shareicon.png'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 5,
                                                  color: Colors.red,
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6),
                                                    child: Container(
                                                      //width: double.infinity,
                                                      child: Text(
                                                        'Finans',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .quicksand(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                onTap: () {
                                                  box.values.any((element) =>
                                                          element.id ==
                                                          value
                                                              .financeNews[
                                                                  index]
                                                              .id)
                                                      ? HiveController()
                                                          .deletePostWithID(
                                                              value.financeNews[
                                                                  index])
                                                      : HiveController()
                                                          .savePostWithItem(
                                                              value.financeNews[
                                                                  index]);
                                                },
                                                child: box.values.any(
                                                        (element) =>
                                                            element.id ==
                                                            value
                                                                .financeNews[
                                                                    index]
                                                                .id)
                                                    ? Icon(Icons.bookmark)
                                                    : Icon(
                                                        Icons.bookmark_border),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 7),
                                      child: Container(
                                        child: Text(
                                          value.financeNews[index].title ?? ' ',
                                          //maxLines: 2,
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 11, vertical: 7),
                                      child: Container(
                                        child: Text(
                                          value.financeNews[index].summary ??
                                              ' ',
                                          //maxLines: 2,
                                          style: GoogleFonts.quicksand(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 3),
                                      child: TextButton(
                                        onPressed: () {
                                          print(value.financeNews[index].id);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                skip: value.skipfinance,
                                                index: index,
                                                list: value.financeNews,
                                                currentRate: currentRate,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Habere Git",
                                          style: GoogleFonts.quicksand(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
