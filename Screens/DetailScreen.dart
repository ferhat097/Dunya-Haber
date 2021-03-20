import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/DetailProvider.dart';
import 'package:haber/Models/post_item.dart' as Post;
import 'package:haber/Models/savedPost.dart';
import 'package:haber/Service/utils.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:parallax_image/parallax_image.dart' as parallax;
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DetailPage extends StatefulWidget {
  final String newsid;
  final int skip;
  final String type;
  final int index;
  final List<dynamic> list;
  final List currentRate;
  const DetailPage(
      {Key key,
      this.skip,
      this.index,
      this.list,
      this.currentRate,
      this.type,
      this.newsid})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => DetailProvider(),
          builder: (context, child) {
            Provider.of<DetailProvider>(context, listen: false).setfirstpost(
                widget.list, widget.index, widget.newsid, widget.type);
            SchedulerBinding.instance.addPostFrameCallback(
              (_) {
                Provider.of<DetailProvider>(context, listen: false)
                    .lis(widget.index);
              },
            );
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Color(0xFF131A20),
                title: Container(
                  height: 40,
                  color: Color(0xFF131A20),
                  child: Hero(
                    tag: 'rate',
                    child: CarouselSlider.builder(
                      itemCount: widget.currentRate.length,
                      options: CarouselOptions(
                        height: 40,
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
                              ),
                              RichText(
                                text: TextSpan(
                                  text:
                                      widget.currentRate[index].rate.toString(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 45),
                  child: GestureDetector(
                    onPanUpdate: (pan) {
                      if (pan.delta.dy > 0) {
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 25,
                                child: Hero(
                                  tag: 'dot',
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_rounded,
                                          size: 25, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 4, left: 10),
                                child: Hero(
                                  tag: 'dunya',
                                  child: Container(
                                    height: 45,
                                    width: 100,
                                    child: AspectRatio(
                                      aspectRatio: 4 / 2,
                                      child: Image.asset('assets/logo.png'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {},
                                  child: Consumer<DetailProvider>(
                                    builder: (context, value, child) =>
                                        ValueListenableBuilder<Box<SavedPost>>(
                                      valueListenable:
                                          Hive.box<SavedPost>('posts')
                                              .listenable(),
                                      builder: (context, Box<SavedPost> box,
                                              child) =>
                                          FocusedMenuHolder(
                                        animateMenuItems: true,
                                        openWithTap: true,
                                        onPressed: () {},
                                        menuItems: <FocusedMenuItem>[
                                          // Add Each FocusedMenuItem  for Menu Options
                                          FocusedMenuItem(
                                            backgroundColor: Colors.amber,
                                            title: Text("Paylaş"),
                                            trailingIcon: Icon(Icons.share),
                                            onPressed: () {
                                              share(
                                                  context,
                                                  value
                                                      .post[value.indxcntr.index
                                                          .toInt()]
                                                      .data
                                                      .link,
                                                  value
                                                      .post[value.indxcntr.index
                                                          .toInt()]
                                                      .data
                                                      .title);
                                            },
                                          ),
                                          FocusedMenuItem(
                                              title:
                                                  Text("Yazı boyutunu büyüt"),
                                              trailingIcon:
                                                  Icon(Icons.add_circle),
                                              onPressed: () {
                                                /*
                                                  return Provider.of<
                                                              DetailProvider>(
                                                          context,
                                                          listen: false)
                                                      .increasefontsize(1);
                                               */
                                              }),
                                          FocusedMenuItem(
                                            title: Text("Yazı boyutunu küçült"),
                                            trailingIcon:
                                                Icon(Icons.remove_circle),
                                            onPressed: () {},
                                          ),
                                          FocusedMenuItem(
                                              title: Text("Kaydedildi"),
                                              onPressed: () {}),
                                        ],
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            child: Hero(
                                              tag: 'fav',
                                              child: SizedBox(
                                                  height: 35,
                                                  width: 35,
                                                  child: Image.asset(
                                                      'assets/dot.png')),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: Consumer<DetailProvider>(
                builder: (context, value, child) {
                  return NotificationListener<ScrollNotification>(
                    // ignore: missing_return
                    onNotification: (notification) {
                      if (notification.metrics.extentAfter < 500 &&
                          value.moree &&
                          widget.type != 'headline') {
                        Provider.of<DetailProvider>(context, listen: false)
                            .getmore();
                        print('yes');
                      }
                    },
                    child: TransformerPageView(
                      controller: value.indxcntr,
                      itemCount: widget.type == 'headline'
                          ? value.newsHead.length
                          : value.news.length,
                      transformer: PageTransformerBuilder(
                        builder: (child, info) {
                          return Stack(
                            fit: StackFit.loose,
                            children: [
                              Container(
                                height: widget.type == 'headline' ? 420 : 320,
                                width: double.infinity,
                                child: Material(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Hero(
                                        tag: 'photo${info.index}',
                                        child: parallax.ParallaxImage(
                                          key: PageStorageKey<int>(info.index),
                                          image: NetworkImage(
                                              widget.type == 'headline'
                                                  ? value.newsHead[info.index]
                                                      .image.url
                                                  : value.news[info.index].image
                                                      .url),
                                          extent: 200,
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
                                            child: Hero(
                                              tag: 'date${info.index}',
                                              child: Text(
                                                widget.type == 'headline'
                                                    ? '-'
                                                    : value.news[info.index]
                                                                .diffrence >
                                                            1
                                                        ? value.news[info.index]
                                                                    .diffrence <
                                                                1440
                                                            ? value.news[info.index]
                                                                        .diffrence <
                                                                    60
                                                                ? '${DateTime.now().difference(value.news[info.index].dateTime).inMinutes.toString()} dakika önce'
                                                                : '${DateTime.now().difference(value.news[info.index].dateTime).inHours.toString()} saat önce'
                                                            : '${DateTime.now().difference(value.news[info.index].dateTime).inDays.toString()} gün önce'
                                                        : 'Şimdi',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 12,
                                                  color: Colors.white,
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
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  SizedBox(
                                    height: 270,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                    ),
                                    width: double.infinity,
                                    child: Card(
                                      shape: RoundedRectangleBorder(),
                                      color: Colors.grey[100],
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                ParallaxContainer(
                                                  child: Container(
                                                    height: 30,
                                                    width: 5,
                                                    color: Colors.red,
                                                  ),
                                                  position: info.position,
                                                  translationFactor: 200,
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: ParallaxContainer(
                                                      child: AutoSizeText(
                                                        widget.type ==
                                                                'headline'
                                                            ? value
                                                                .newsHead[
                                                                    info.index]
                                                                .title
                                                            : value
                                                                .news[
                                                                    info.index]
                                                                .title,
                                                        style: GoogleFonts
                                                            .quicksand(
                                                                //fontSize: 30.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors.red),
                                                        minFontSize: 10,
                                                        maxLines: 1,
                                                        maxFontSize: 30,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      position: info.position,
                                                      translationFactor: 200.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ParallaxContainer(
                                            position: info.position,
                                            translationFactor: 100,
                                            child: Container(
                                              color: Colors.grey[50],
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  widget.type == 'headline'
                                                      ? value
                                                          .newsHead[info.index]
                                                          .summary
                                                      : value.news[info.index]
                                                          .summary,
                                                  style: GoogleFonts.quicksand(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          FutureBuilder<Post.Post>(
                                            future: Provider.of<DetailProvider>(
                                                    context,
                                                    listen: false)
                                                .getpost(widget.type ==
                                                        'headline'
                                                    ? value
                                                        .newsHead[info.index].id
                                                    : value
                                                        .news[info.index].id),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData)
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[50]),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Html(
                                                        data: snapshot.data.data
                                                            .contentHtml,
                                                        shrinkWrap: true,
                                                      )),
                                                );
                                              else
                                                return Column(
                                                  children: [
                                                    LinearProgressIndicator(
                                                      backgroundColor:
                                                          Colors.red,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Color(
                                                                  0xFF131A20)),
                                                    ),
                                                    SizedBox(
                                                      height: 200,
                                                      width: double.infinity,
                                                    ),
                                                  ],
                                                );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
