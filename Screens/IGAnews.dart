import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/IGAnewsProvider.dart';
import 'package:haber/Providers/MainProvider.dart';
import 'package:haber/Screens/DetailScreen.dart';
import 'package:haber/Service/localdatabase.dart';
import 'package:haber/Models/current_rate.dart';
import 'package:haber/Models/post_model.dart';
import 'package:haber/Models/savedPost.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Service/utils.dart';
import 'Search.dart';

class IGAnews extends StatefulWidget {
  @override
  _IGAnewsState createState() => _IGAnewsState();
}

class _IGAnewsState extends State<IGAnews> {
  @override
  void initState() {
    Provider.of<IGAnewsProvider>(context, listen: false).getIGAnews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF131A20),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF131A20),
          title: Padding(
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
                        )),
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
                    )
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
                              List currentRate = Provider.of<MainProvider>(
                                      context,
                                      listen: false)
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          color: Colors.grey[50],
          child: RefreshIndicator(
            onRefresh: () {
              return Provider.of<IGAnewsProvider>(context, listen: false)
                  .refreshIGAnews();
            },
            child: FutureBuilder<List<Item>>(
              future: Provider.of<IGAnewsProvider>(context, listen: false)
                  .getIGAnews(),
              builder: (context, snapshot) {
                List<CurrentRate> currentRate =
                    Provider.of<MainProvider>(context, listen: false)
                        .currentRate;
                if (snapshot.hasData) {
                  return NotificationListener<ScrollNotification>(
                    // ignore: missing_return
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent) {
                        Provider.of<IGAnewsProvider>(context, listen: false)
                            .getMoreIGAnews();
                        print('a');
                      }
                    },
                    child: Consumer<IGAnewsProvider>(
                      builder: (context, value, child) {
                        return ValueListenableBuilder<Box<SavedPost>>(
                          valueListenable:
                              Hive.box<SavedPost>('posts').listenable(),
                          builder: (context, Box<SavedPost> box, child) =>
                              ListView.builder(
                          
                            shrinkWrap: true,
                            itemCount: value.iGAnews.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.grey[50],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: value.iGAnews[index].image
                                                      .url !=
                                                  null
                                              ? Stack(
                                                  children: [
                                                    SizedBox(
                                                      height: 200,
                                                      width: double.infinity,
                                                      child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Image.network(
                                                            value.iGAnews[index]
                                                                .image.url),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 7,
                                                      left: 7,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            3)),
                                                            color: Colors.red),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                          child: Text(
                                                            value.iGAnews[index]
                                                                        .diffrence >
                                                                    1
                                                                ? value.iGAnews[index]
                                                                            .diffrence <
                                                                        1440
                                                                    ? value.iGAnews[index].diffrence < 60
                                                                        ? '${DateTime.now().difference(value.iGAnews[index].dateTime).inMinutes.toString()} dakika önce'
                                                                        : '${DateTime.now().difference(value.iGAnews[index].dateTime).inHours.toString()} saat önce'
                                                                    : '${DateTime.now().difference(value.iGAnews[index].dateTime).inDays.toString()} gün önce'
                                                                : 'Şimdi',
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
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
                                                              BorderRadius
                                                                  .circular(30),
                                                          elevation: 0.1,
                                                          shadowColor:
                                                              Colors.black12,
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            onTap: () {
                                                              share(
                                                                  context,
                                                                  value
                                                                      .iGAnews[
                                                                          index]
                                                                      .link,
                                                                  value
                                                                      .iGAnews[
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 5,
                                                      color: Colors.red,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 6),
                                                        child: Container(
                                                          //width: double.infinity,
                                                          child: Text(
                                                            'İGA Haberleri',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .quicksand(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        18,
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
                                                        BorderRadius.circular(
                                                            10),
                                                    onTap: () {
                                                      box.values.any(
                                                              (element) =>
                                                                  element.id ==
                                                                  value
                                                                      .iGAnews[
                                                                          index]
                                                                      .id)
                                                          ? HiveController()
                                                              .deletePostWithID(
                                                                  value.iGAnews[
                                                                      index])
                                                          : HiveController()
                                                              .savePostWithItem(
                                                                  value.iGAnews[
                                                                      index]);
                                                    },
                                                    child: box.values.any(
                                                            (element) =>
                                                                element.id ==
                                                                value
                                                                    .iGAnews[
                                                                        index]
                                                                    .id)
                                                        ? Icon(Icons.bookmark)
                                                        : Icon(Icons
                                                            .bookmark_border),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 11, vertical: 7),
                                          child: Container(
                                            child: Text(
                                              value.iGAnews[index].title ?? ' ',
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
                                              value.iGAnews[index].summary ??
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
                                              print(value.iGAnews[index].id);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                    skip: value.skip,
                                                    index: index,
                                                    list: value.iGAnews,
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
        ),
      ),
    );
  }
}
