import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/MainProvider.dart';
import 'package:haber/Providers/PublisherProvider.dart';
import 'package:haber/Models/authors_model.dart';
import 'package:haber/Service/utils.dart';
import 'package:provider/provider.dart';

class Publisher extends StatefulWidget {
  @override
  _PublisherState createState() => _PublisherState();
}

class _PublisherState extends State<Publisher> {
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
                            onTap: () {
                              
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
              return Provider.of<PublisherProvider>(context, listen: false)
                  .refreshPublisher();
            },
            child: FutureBuilder<List<Item>>(
              future: Provider.of<PublisherProvider>(context, listen: false)
                  .getPublisher(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NotificationListener<ScrollNotification>(
                    // ignore: missing_return
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent) {
                        Provider.of<PublisherProvider>(context, listen: false)
                            .getMorePublisher();
                        print('a');
                      }
                    },
                    child: Consumer<PublisherProvider>(
                      builder: (context, publisher, child) => ListView.builder(
                        itemCount: publisher.publisher.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 4, top: 4, right: 4),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: publisher.publisher[index]
                                                          .image.url !=
                                                      null
                                                  ? CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(publisher
                                                              .publisher[index]
                                                              .image
                                                              .url),
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      radius: 35.0,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[200],
                                                      radius: 35,
                                                    ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                  ),
                                                  child: Container(
                                                    width: 200,
                                                    child: Text(
                                                      publisher.publisher[index]
                                                          .name,
                                                      maxLines: 1,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              color: Colors.red,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 6,
                                                      right: 6,
                                                      top: 2),
                                                  child: Container(
                                                    width: 200,
                                                    child: Text(
                                                      publisher.publisher[index]
                                                          .lastPost.title,
                                                      maxLines: 1,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 6,
                                                      top: 5,
                                                      bottom: 5),
                                                  child: Container(
                                                    width: 200,
                                                    child: Text(
                                                      publisher.publisher[index]
                                                          .lastPost.title,
                                                      maxLines: 3,
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              letterSpacing:
                                                                  0.5,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            onTap: () {
                                              sendMail(
                                                  publisher
                                                      .publisher[index].name,
                                                  publisher
                                                      .publisher[index].email);
                                            },
                                            child: Icon(
                                              Icons.mail,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
