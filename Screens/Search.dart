import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/SearchProvider.dart';
import 'package:haber/Service/localdatabase.dart';
import 'package:haber/Models/savedPost.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Service/utils.dart';
import 'DetailScreen.dart';

class Search extends StatefulWidget {
  final List currentRate;

  const Search({Key key, this.currentRate}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchProvider(),
      builder: (context, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            primary: true,
            titleSpacing: 0,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF131A20),
            title: PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: Container(
                  // height: 60,
                  color: Color(0xFF131A20),
                  child: Hero(
                    tag: 'rate',
                    child: CarouselSlider.builder(
                      itemCount: widget.currentRate.length,
                      options: CarouselOptions(
                        height: 50,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.3,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (context, index, index2) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              widget.currentRate[index].status
                                  ? Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.arrow_upward,
                                      color: Colors.green,
                                    ),
                              RichText(
                                text: TextSpan(
                                    text: widget.currentRate[index].name),
                                /*style:  GoogleFonts.quicksand(
                                 color: Colors.white, fontFamily: 'GreycliffCF'),*/
                              ),
                              RichText(
                                text: TextSpan(
                                    text: widget.currentRate[index].rate
                                        .toString()),
                                /* style:  GoogleFonts.quicksand(
                                 color: Colors.white, fontFamily: 'GreycliffCF'),*/
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )),
            ),
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: Selector<SearchProvider, TextEditingController>(
                selector: (context, search) => search.controller,
                builder: (context, controller, child) => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                  // width:double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                        onSubmitted: (value) {
                                          Provider.of<SearchProvider>(context,
                                                  listen: false)
                                              .search(value);
                                          Provider.of<SearchProvider>(context,
                                                  listen: false)
                                              .setquery(value);
                                        },
                                        autofocus: true,
                                        textInputAction: TextInputAction.search,
                                        textAlign: TextAlign.start,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400),
                                        decoration: InputDecoration.collapsed(
                                          // icon: Icon(Icons.search,color: Colors.white,),
                                          hintText: 'Ara',
                                          hintStyle: GoogleFonts.quicksand(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          border: InputBorder.none,
                                          // contentPadding: EdgeInsets.only(left: 5)
                                        )),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
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
                                      return Provider.of<SearchProvider>(
                                              context,
                                              listen: false)
                                          .search('g');
                                    },
                                    child: Image.asset('assets/search.png')))),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: Consumer<SearchProvider>(
            builder: (context, value, child) {
              return ValueListenableBuilder<Box<SavedPost>>(
                valueListenable: Hive.box<SavedPost>('posts').listenable(),
                builder: (context, Box<SavedPost> box, child) =>
                    NotificationListener(
                  // ignore: missing_return
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.pixels ==
                            notification.metrics.maxScrollExtent) {
                      Provider.of<SearchProvider>(context, listen: false)
                          .moreSearch(value.query);
                      print('a');
                    }
                  },
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: value.searchresult.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey[50],
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: value.searchresult[index].image.url !=
                                          null
                                      ? Stack(
                                          children: [
                                            SizedBox(
                                              height: 200,
                                              width: double.infinity,
                                              child: FittedBox(
                                                fit: BoxFit.fill,
                                                child: Hero(
                                                  tag: 'photo$index',
                                                  child: Image.network(value
                                                      .searchresult[index]
                                                      .image
                                                      .url),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 7,
                                              left: 7,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(3)),
                                                    color: Colors.red),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  child: Hero(
                                                    tag: 'date$index',
                                                    child: Text(
                                                      value.searchresult[index]
                                                                  .diffrence >
                                                              1
                                                          ? value
                                                                      .searchresult[
                                                                          index]
                                                                      .diffrence <
                                                                  1440
                                                              ? value.searchresult[index]
                                                                          .diffrence <
                                                                      60
                                                                  ? '${DateTime.now().difference(value.searchresult[index].dateTime).inMinutes.toString()} dakika önce'
                                                                  : '${DateTime.now().difference(value.searchresult[index].dateTime).inHours.toString()} saat önce'
                                                              : '${DateTime.now().difference(value.searchresult[index].dateTime).inDays.toString()} gün önce'
                                                          : 'Şimdi',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
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
                                                      BorderRadius.circular(30),
                                                  elevation: 0.1,
                                                  shadowColor: Colors.black12,
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    onTap: () {
                                                      share(
                                                          context,
                                                          value
                                                              .searchresult[
                                                                  index]
                                                              .link,
                                                          value
                                                              .searchresult[
                                                                  index]
                                                              .title);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 6),
                                                child: Container(
                                                  //width: double.infinity,
                                                  child: AutoSizeText.rich(
                                                    TextSpan(
                                                      text:
                                                          'Spor' /*value.searchresult[index].title*/,
                                                    ),
                                                    //maxLines: 2,
                                                    minFontSize: 18,
                                                    maxFontSize: 18,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        GoogleFonts.quicksand(
                                                            color: Colors.red,
                                                            fontSize: 16,
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
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () {
                                              box.values.any((element) =>
                                                      element.id ==
                                                      value.searchresult[index]
                                                          .id)
                                                  ? HiveController()
                                                      .deletePostWithID(value
                                                          .searchresult[index])
                                                  : HiveController()
                                                      .savePostWithItem(value
                                                          .searchresult[index]);
                                            },
                                            child: box.values.any((element) =>
                                                    element.id ==
                                                    value
                                                        .searchresult[index].id)
                                                ? Icon(Icons.bookmark)
                                                : Icon(Icons.bookmark_border),
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
                                      value.searchresult[index].title ?? ' ',
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
                                      value.searchresult[index].summary ?? ' ',
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
                                      print(value.searchresult[index].id);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                            type: 'Spor Haberleri',
                                            skip: value.skip,
                                            index: index,
                                            list: value.searchresult,
                                            currentRate: widget.currentRate,
                                            //newsid: value.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Habere Git",
                                      style: GoogleFonts.quicksand(
                                        decoration: TextDecoration.underline,
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
                ),
              );
            },
          )),
    );
  }
}
