import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

share(BuildContext context, String url, String content) async {
  await Share.share(url, subject: content);
}

sendMail(name, email) async {
  Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=Değerli $name&body=Size Dünya Haber Mobil Uygulamasından ulaştım');

  var url = params.toString();
  try {
    await launch(url);
  } catch (e) {
    print(e);
  }
}

/*
    return Selector<HomeProvider, PageController>(
      selector: (context, home) => home.pageController,
      builder: (context, pageController, child) => Container(
        child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              hepsi(context),
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
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
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child:
                                              Image.asset('assets/haber1.png'),
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 7,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3)),
                                              color: Colors.red),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            child: Text(
                                              '35 D',
                                              style:  GoogleFonts.quicksand(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: 'GreycliffCF'),
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
                                            elevation: 2,
                                            shadowColor: Colors.black12,
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              onTap: () {
                                                share(context, 'son dakika',
                                                    'header');
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 17,
                                        width: 5,
                                        color: Colors.red,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 6),
                                        child: Container(
                                          width: 250,
                                          child: Text(
                                            'Küresel Ekonomi',
                                            maxLines: 1,
                                            style:  GoogleFonts.quicksand(
                                                color: Colors.red,
                                                fontFamily: 'GreycliffCF',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
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
                                    width: 200,
                                    child: Text(
                                      'Küresel Ekonomi Bu Yıl Yüzde 4,4 Küçülecek',
                                      maxLines: 2,
                                      style:  GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontFamily: 'GreycliffCF',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 11,
                                  ),
                                  child: Container(
                                    //width: 200,
                                    child: Text(
                                      'Uluslararası Para Fonu (IMF), küresel ekonominin bu yıl yüzde 4,4 oranında küçülmesinin beklendiğini bildirdi. ',
                                      maxLines: 4,
                                      style:  GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontFamily: 'GreycliffCF',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 3),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          index: index)));
                                        },
                                        child: Text(
                                          "Habere Git",
                                          style:  GoogleFonts.quicksand(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SingleChildScrollView(
                child: Container(
                  color: Colors.grey[50],
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 1, top: 1),
                            child: Card(
                              child: Container(
                                height: 165,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Container(
                                            width: 5,
                                            height: 15,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, left: 8),
                                          child: Container(
                                            height: 20,
                                            width: 350,
                                            //color: Colors.blue[100],
                                            child: Text(
                                              "EPDK 12 şirkette elektrik üretim lisansı verdi",
                                              style:  GoogleFonts.quicksand(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        //color: Colors.yellow[200],
                                        height: 50,
                                        width: 350,
                                        child: Text(
                                          "Enerji Piyasası Düzenleme Kurumu(EPDK) tarafından elektrik piyasasında 12 şirket üretim lisansı verildi. 5 şirketin lisansı sona erdirildi.",
                                          maxLines: 3,
                                          style:  GoogleFonts.quicksand(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 210,
                                      ),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Text("Okumaya Devam Et",
                                            style:  GoogleFonts.quicksand(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(height: 60, color: Colors.grey[50])
                    ],
                  ),
                ),
              ),
              Container(
                //height: 50,
                //width: 50,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        // height: 400,

                        color: Colors.grey[50],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child:
                                              Image.asset('assets/haber1.png'),
                                        ),
                                      ),
                                      Positioned(
                                        top: 7,
                                        left: 7,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3)),
                                              color: Colors.red),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            child: Text(
                                              '35 D',
                                              style:  GoogleFonts.quicksand(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: 'GreycliffCF'),
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
                                            elevation: 2,
                                            shadowColor: Colors.black12,
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              onTap: () {
                                                share(context, 'gundem',
                                                    'header');
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 17,
                                        width: 5,
                                        color: Colors.red,
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 6),
                                        child: Container(
                                          width: 250,
                                          child: Text(
                                            'Küresel Ekonomi',
                                            maxLines: 1,
                                            style:  GoogleFonts.quicksand(
                                                color: Colors.red,
                                                fontFamily: 'GreycliffCF',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
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
                                    width: 200,
                                    child: Text(
                                      'Küresel Ekonomi Bu Yıl Yüzde 4,4 Küçülecek',
                                      maxLines: 2,
                                      style:  GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontFamily: 'GreycliffCF',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 11,
                                  ),
                                  child: Container(
                                    //width: 200,
                                    child: Text(
                                      'Uluslararası Para Fonu (IMF), küresel ekonominin bu yıl yüzde 4,4 oranında küçülmesinin beklendiğini bildirdi. ',
                                      maxLines: 4,
                                      style:  GoogleFonts.quicksand(
                                          color: Colors.black,
                                          fontFamily: 'GreycliffCF',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 3),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailPage(
                                                          index: index)));
                                        },
                                        child: Text(
                                          "Habere Git",
                                          style:  GoogleFonts.quicksand(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                height: 50,
              )
            ]),
      ),
    );*/
/* Widget hepsi(BuildContext context) {
    print('rebuilded');
    return
        Container(
      //! Publisher
      height: 150,
      color: Colors.grey[200],
      child: FutureBuilder<List<Item>>(
        future: Provider.of<MainProvider>(context, listen: false)
            .getPublisher(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                  height: 150,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  scrollDirection: Axis.horizontal,
                  aspectRatio: 16 / 2),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index, int nfd) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 2, bottom: 4, top: 4, right: 2),
                  child: Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: snapshot.data[index].image.url !=
                                    null
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data[index].image.url),
                                    backgroundColor: Colors.grey[200],
                                    radius: 35.0,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    radius: 35,
                                  ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 6),
                              child: Container(
                                width: 200,
                                child: Text(
                                  snapshot.data[index].name,
                                  maxLines: 1,
                                  style:  GoogleFonts.quicksand(
                                      color: Colors.red,
                                      fontFamily: 'GreycliffCF',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 2),
                              child: Container(
                                width: 200,
                                child: Text(
                                  snapshot.data[index].lastPost.title,
                                  maxLines: 1,
                                  style:  GoogleFonts.quicksand(
                                      color: Colors.black,
                                      fontFamily: 'GreycliffCF',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 6, top: 5, bottom: 5),
                              child: Container(
                                width: 200,
                                child: Text(
                                  snapshot.data[index].lastPost.title,
                                  maxLines: 3,
                                  style:  GoogleFonts.quicksand(
                                      letterSpacing: 0.5,
                                      color: Colors.black,
                                      fontFamily: 'GreycliffCF',
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 4),
                              child: Material(
                                child: InkWell(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)),
                                  hoverColor: Colors.grey,
                                  highlightColor: Colors.grey,
                                  splashColor: Colors.grey,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailPage(
                                                  index: index,
                                                )));
                                  }, // needed
                                  child: Ink(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(5)),
                                          color: Colors.grey[200]),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 7,
                                              vertical: 4),
                                          child: Text(
                                            'Okumaya Devam Et',
                                            style:  GoogleFonts.quicksand(
                                                fontSize: 13,
                                                fontWeight:
                                                    FontWeight.w500),
                                          ))),
                                ),
                              ),
                            )
                            /*TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                      backgroundColor:
                            Colors.grey[200]),
                                        child: Text(
                      "Okumaya Devam Et",
                      style:  GoogleFonts.quicksand(
                          color: Colors.black,
                          fontSize: 11,fontFamily: 'GreycliffCF'),
                                        ),
                                      )*/
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return LinearProgressIndicator(); //?end Publisher
          }
        },
      ),
    ),
        Container(
      //height: 50,
      //width: 50,
      child: RefreshIndicator(
        onRefresh: () {
          return Provider.of<HomeProvider>(context, listen: false)
              .refreshElectedNews();
        },
        child: FutureBuilder(
          future: Provider.of<HomeProvider>(context, listen: false)
              .getElectedNews(),
          builder: (context, snapshot) {
            return NotificationListener<ScrollNotification>(
              // ignore: missing_return
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent) {
                  Provider.of<HomeProvider>(context, listen: false)
                      .getMoreElectedNews();
                  print('a');
                }
              },
              child: Consumer<HomeProvider>(
                builder: (context, home, child) => ValueListenableBuilder(
                  valueListenable: Hive.box<SavedPost>('posts').listenable(),
                  builder: (context, value, child) => ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: 400,

                          color: Colors.grey[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: double.infinity,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.network(home
                                                .electedNews[index].image.url),
                                          ),
                                        ),
                                        Positioned(
                                          top: 7,
                                          left: 7,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                                color: Colors.red),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              child: Text(
                                                '35 D',
                                                style:  GoogleFonts.quicksand(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontFamily: 'GreycliffCF'),
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
                                              elevation: 2,
                                              shadowColor: Colors.black12,
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                onTap: () {
                                                  share(context, 'hepsi',
                                                      'header');
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 17,
                                          width: 5,
                                          color: Colors.red,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Container(
                                            width: 250,
                                            child: Text(
                                              home.electedNews[index].title,
                                              maxLines: 1,
                                              style:  GoogleFonts.quicksand(
                                                  color: Colors.red,
                                                  fontFamily: 'GreycliffCF',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
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
                                      width: 200,
                                      child: Text(
                                        home.electedNews[index].summary ??
                                            "no data",
                                        maxLines: 2,
                                        style:  GoogleFonts.quicksand(
                                            color: Colors.black,
                                            fontFamily: 'GreycliffCF',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 11,
                                    ),
                                    child: Container(
                                      //width: 200,
                                      child: Text(
                                        home.electedNews[index].summary ??
                                            "no data",
                                        maxLines: 4,
                                        style:  GoogleFonts.quicksand(
                                            color: Colors.black,
                                            fontFamily: 'GreycliffCF',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 3),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPage(
                                                            index: index)));
                                          },
                                          child: Text(
                                            "Habere Git",
                                            style:  GoogleFonts.quicksand(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            );
          },
        ),
      ),
    );
  }*/

/* SliverToBoxAdapter(
                            child: Container(
                          color: Colors.grey[50],
                          child: Consumer<HomeProvider>(
                            builder: (context, onecikanlar, child) {
                              if (onecikanlar.oneCikanlar.isNotEmpty) {
                                return NotificationListener<ScrollNotification>(
                                  onNotification: (notification) {
                                    if (notification is ScrollEndNotification &&
                                        notification.metrics.pixels ==
                                            notification
                                                .metrics.maxScrollExtent) {
                                      print('aonecikanlar');
                                    }
                                  },
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: onecikanlar.oneCikanlar.length,
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
                                                    child: Stack(
                                                      children: [
                                                        SizedBox(
                                                          height: 200,
                                                          width:
                                                              double.infinity,
                                                          child: FittedBox(
                                                            fit: BoxFit.fill,
                                                            child: Image.network(
                                                                onecikanlar
                                                                    .oneCikanlar[
                                                                        index]
                                                                    .image
                                                                    .url),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 7,
                                                          left: 7,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            3)),
                                                                color:
                                                                    Colors.red),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4,
                                                              ),
                                                              child: Text(
                                                                '35 D',
                                                                style:  GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        'GreycliffCF'),
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
                                                                      .circular(
                                                                          30),
                                                              elevation: 2,
                                                              shadowColor:
                                                                  Colors
                                                                      .black12,
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
                                                                      onecikanlar
                                                                          .oneCikanlar[
                                                                              index]
                                                                          .link,
                                                                      onecikanlar
                                                                          .oneCikanlar[
                                                                              index]
                                                                          .title);
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 30,
                                                                    width: 30,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/shareicon.png'),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: 17,
                                                          width: 5,
                                                          color: Colors.red,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      6),
                                                          child: Container(
                                                            width: 250,
                                                            child: Text(
                                                              onecikanlar
                                                                  .oneCikanlar[
                                                                      index]
                                                                  .title,
                                                              maxLines: 1,
                                                              style:  GoogleFonts.quicksand(
                                                                  color: Colors
                                                                      .red,
                                                                  fontFamily:
                                                                      'GreycliffCF',
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 11,
                                                            vertical: 7),
                                                    child: Container(
                                                      width: 200,
                                                      child: Text(
                                                        onecikanlar
                                                            .oneCikanlar[index]
                                                            .title,
                                                        maxLines: 2,
                                                        style:  GoogleFonts.quicksand(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'GreycliffCF',
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 11,
                                                    ),
                                                    child: Container(
                                                      //width: 200,
                                                      child: Text(
                                                        onecikanlar
                                                            .oneCikanlar[index]
                                                            .summary,
                                                        maxLines: 4,
                                                        style:  GoogleFonts.quicksand(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'GreycliffCF',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 3),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DetailPage(
                                                                        index:
                                                                            index)));
                                                      },
                                                      child: Text(
                                                        "Habere Git",
                                                        style:  GoogleFonts.quicksand(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              } else {
                                return Center(
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                            },
                          ),
                        ))*/
