import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:haber/Providers/FinansProviders/BitsStatDetailProvider.dart';
import 'package:haber/Providers/FinansProviders/BitsStatProvider.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:provider/provider.dart';
import 'package:haber/Models/bist_model.dart';
import 'package:google_fonts/google_fonts.dart';

class EnCokIslemGorenler extends StatefulWidget {
  @override
  _EnCokIslemGorenlerState createState() => _EnCokIslemGorenlerState();
}

class _EnCokIslemGorenlerState extends State<EnCokIslemGorenler>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: FutureBuilder<List<Item>>(
        future: Provider.of<BitsStatsProvider>(context, listen: false)
            .getBitsStats(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Consumer<BitsStatsProvider>(
              builder: (context, bist, child) => ListView.builder(
                itemCount: bist.bitsStats.length,
                itemBuilder: (context, index) {
                  return OpenContainer(
                    transitionType: ContainerTransitionType.fade,
                    transitionDuration: Duration(seconds: 1),
                    closedShape: RoundedRectangleBorder(),
                    closedColor: Colors.blueGrey[50],
                    closedBuilder: (context, action) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  bist.bitsStats[index].name,
                                  style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Text(
                                      DateTime.now()
                                                  .difference(bist
                                                      .bitsStats[index]
                                                      .updatedAt)
                                                  .inMinutes >
                                              1
                                          ? DateTime.now()
                                                      .difference(bist
                                                          .bitsStats[index]
                                                          .updatedAt)
                                                      .inMinutes <
                                                  1440
                                              ? DateTime.now()
                                                          .difference(bist
                                                              .bitsStats[index]
                                                              .updatedAt)
                                                          .inMinutes <
                                                      60
                                                  ? '${DateTime.now().difference(bist.bitsStats[index].updatedAt).inMinutes.toString()} dakika önce'
                                                  : '${DateTime.now().difference(bist.bitsStats[index].updatedAt).inHours.toString()} saat önce'
                                              : '${DateTime.now().difference(bist.bitsStats[index].updatedAt).inDays.toString()} gün önce'
                                          : 'Şimdi',
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      color: bist.bitsStats[index].dailyChange
                                              .isNegative
                                          ? Colors.red[50]
                                          : Colors.green[50],
                                      child: InkWell(
                                        child: Icon(Icons.arrow_right),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    openBuilder: (context, action) {
                      return SafeArea(
                        child: ChangeNotifierProvider(
                          create: (context) => BitsStatDetailProvider(),
                          builder: (context, child) {
                            return Scaffold(
                              appBar: PreferredSize(
                                preferredSize: Size(double.infinity, 60),
                                child: Material(
                                  color: Colors.blue[50],
                                  elevation: 2,
                                  child: Container(
                                    //color: Colors.blueAccent[100],
                                    child: Row(
                                      children: [
                                        IconButton(
                                            icon:
                                                Icon(Icons.arrow_back_rounded),
                                            onPressed: action),
                                        Flexible(
                                            child: Text(
                                                bist.bitsStats[index].name,
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              body: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Card(
                                      child: Selector<BitsStatDetailProvider,
                                          bool>(
                                        selector: (context, bits) =>
                                            bits.finansqraf,
                                        builder: (context, value2, child) =>
                                            Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Foreks Qrafigi',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Visibility(
                                                          visible: value2,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Provider.of<BitsStatDetailProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .changeqraftype();
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .yearlyChangePercentage
                                                                            .isNegative
                                                                        ? Colors.red[
                                                                            50]
                                                                        : Colors
                                                                            .blueGrey[50],
                                                                  ),
                                                                  child: Selector<
                                                                      BitsStatDetailProvider,
                                                                      bool>(
                                                                    selector: (context,
                                                                            bits) =>
                                                                        bits.isLine,
                                                                    builder: (context,
                                                                            value,
                                                                            child) =>
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        value2
                                                                            ? 'CandlStick qrafik'
                                                                            : 'Line qrafik',
                                                                        style: GoogleFonts.quicksand(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: value2
                                                              ? Icon(Icons
                                                                  .arrow_drop_down)
                                                              : Icon(Icons
                                                                  .arrow_right),
                                                          onPressed: () {
                                                            Provider.of<BitsStatDetailProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changefinansqraf();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: value2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      child: SizedBox(
                                                        height: 200,
                                                        width: double.infinity,
                                                        child: FutureBuilder<
                                                            Object>(
                                                          future: Provider.of<
                                                                      BitsStatDetailProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getData(
                                                                  bist
                                                                      .bitsStats[
                                                                          index]
                                                                      .foreksCode,
                                                                  'daily'),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return Consumer<
                                                                  BitsStatDetailProvider>(
                                                                builder: (context,
                                                                        value2,
                                                                        child) =>
                                                                    ClipRRect(
                                                                  child:
                                                                      KChartWidget(
                                                                    value2.dat,
                                                                    volHidden:
                                                                        true,
                                                                    maDayList: [
                                                                      5,
                                                                      10,
                                                                      20
                                                                    ],
                                                                    isLine: value2
                                                                        .isLine,
                                                                    mainState:
                                                                        MainState
                                                                            .MA,
                                                                    secondaryState:
                                                                        SecondaryState
                                                                            .NONE,
                                                                    fixedLength:
                                                                        2,
                                                                    timeFormat:
                                                                        TimeFormat
                                                                            .YEAR_MONTH_DAY,
                                                                    isChinese:
                                                                        false,
                                                                    bgColor: [
                                                                      Color(
                                                                          0xFF121128),
                                                                      Color(
                                                                          0xFF121128),
                                                                      Color(
                                                                          0xFF121128)
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return Center(
                                                                child: SizedBox(
                                                                  height: 200,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Stack(
                                                                    children: [
                                                                      ClipRRect(
                                                                        child:
                                                                            KChartWidget(
                                                                          null,
                                                                          volHidden:
                                                                              true,
                                                                          maDayList: [
                                                                            5,
                                                                            10,
                                                                            20
                                                                          ],
                                                                          isLine:
                                                                              true,
                                                                          mainState:
                                                                              MainState.MA,
                                                                          secondaryState:
                                                                              SecondaryState.NONE,
                                                                          fixedLength:
                                                                              2,
                                                                          timeFormat:
                                                                              TimeFormat.YEAR_MONTH_DAY,
                                                                          isChinese:
                                                                              false,
                                                                          bgColor: [
                                                                            Color(0xFF121128),
                                                                            Color(0xFF121128),
                                                                            Color(0xFF121128)
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              //alignment: Alignment.center,
                                                                              decoration: BoxDecoration(color: Colors.blueGrey[100], borderRadius: BorderRadius.circular(5)),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  'Yükleniyor...',
                                                                                  style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Provider.of<BitsStatDetailProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .changedata(
                                                                            bist.bitsStats[index].foreksCode,
                                                                            'daily');
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: bist
                                                                              .bitsStats[
                                                                                  index]
                                                                              .dailyChangePercentage
                                                                              .isNegative
                                                                          ? Colors.red[
                                                                              50]
                                                                          : Colors
                                                                              .green[50],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'Gunluk',
                                                                        style: GoogleFonts.quicksand(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Provider.of<BitsStatDetailProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .changedata(
                                                                            bist.bitsStats[index].foreksCode,
                                                                            'weekly');
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: bist
                                                                              .bitsStats[
                                                                                  index]
                                                                              .weeklyChangePercentage
                                                                              .isNegative
                                                                          ? Colors.red[
                                                                              50]
                                                                          : Colors
                                                                              .green[50],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'Haftalik',
                                                                        style: GoogleFonts.quicksand(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Provider.of<BitsStatDetailProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .changedata(
                                                                            bist.bitsStats[index].foreksCode,
                                                                            'monthly');
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: bist
                                                                              .bitsStats[
                                                                                  index]
                                                                              .monthlyChangePercentage
                                                                              .isNegative
                                                                          ? Colors.red[
                                                                              50]
                                                                          : Colors
                                                                              .green[50],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'Aylik',
                                                                        style: GoogleFonts.quicksand(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Provider.of<BitsStatDetailProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .changedata(
                                                                            bist.bitsStats[index].foreksCode,
                                                                            'yearly');
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: bist
                                                                              .bitsStats[
                                                                                  index]
                                                                              .yearlyChangePercentage
                                                                              .isNegative
                                                                          ? Colors.red[
                                                                              50]
                                                                          : Colors
                                                                              .green[50],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        'Yillik',
                                                                        style: GoogleFonts.quicksand(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Ask',
                                              style: GoogleFonts.quicksand(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              bist.bitsStats[index].ask
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  color: bist.bitsStats[index]
                                                          .ask.isNegative
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Bid',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(
                                              bist.bitsStats[index].bid
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  color: bist.bitsStats[index]
                                                          .bid.isNegative
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Capital',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(
                                              bist.bitsStats[index].capital
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  color: bist.bitsStats[index]
                                                          .capital.isNegative
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Net Capital',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(
                                              bist.bitsStats[index].netCapital
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  color: bist.bitsStats[index]
                                                          .netCapital.isNegative
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Net Profit',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(
                                              bist.bitsStats[index].netProfit
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  color: bist.bitsStats[index]
                                                          .netProfit.isNegative
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Net Profit',
                                                style: GoogleFonts.quicksand(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(
                                              bist.bitsStats[index].netProfit
                                                  .toString(),
                                              style: GoogleFonts.quicksand(
                                                  color: bist.bitsStats[index]
                                                          .netProfit.isNegative
                                                      ? Colors.red
                                                      : Colors.green,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Consumer<BitsStatDetailProvider>(
                                        builder: (context, value2, child) =>
                                            Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Günlük İstatistikler',
                                                        style: GoogleFonts
                                                            .quicksand(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: bist
                                                                        .bitsStats[
                                                                            index]
                                                                        .dailyChangePercentage
                                                                        .isNegative
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '${bist.bitsStats[index].dailyChangePercentage.toString()}%',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons
                                                              .arrow_drop_down),
                                                          onPressed: () {
                                                            Provider.of<BitsStatDetailProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeSize();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: value2.size,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Gunluk Miktar',
                                                                  style: GoogleFonts.quicksand(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .dailyAmount
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .dailyAmount
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Gunluk Hacim',
                                                                  style: GoogleFonts.quicksand(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .dailyVolume
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .dailyVolume
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Gunluk Degisim',
                                                                  style: GoogleFonts.quicksand(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .dailyChange
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .dailyChange
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Gunluk En Yuksek',
                                                                  style: GoogleFonts.quicksand(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .dailyHighest
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .dailyHighest
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Gunluk En Dusuk',
                                                                  style: GoogleFonts.quicksand(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .dailyLowest
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .dailyLowest
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
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
                                    ),
                                    Card(
                                      child: Consumer<BitsStatDetailProvider>(
                                        builder: (context, value2, child) =>
                                            Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        'Haftalik İstatistikler',
                                                        style: GoogleFonts
                                                            .quicksand(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: bist
                                                                        .bitsStats[
                                                                            index]
                                                                        .weeklyChangePercentage
                                                                        .isNegative
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '${bist.bitsStats[index].weeklyChangePercentage.toString()}%',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons
                                                              .arrow_drop_down),
                                                          onPressed: () {
                                                            Provider.of<BitsStatDetailProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeweekly();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: value2.weekly,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Haftalik Degisim',
                                                                  style: GoogleFonts.quicksand(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .weeklyChange
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .weeklyChange
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Haftalik En Yuksek',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .weeklyHighest
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .weeklyHighest
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Haftalik En Dusuk',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .weeklyLowest
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .weeklyLowest
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
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
                                    ),
                                    Card(
                                      child: Consumer<BitsStatDetailProvider>(
                                        builder: (context, value2, child) =>
                                            Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Aylik İstatistikler',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: bist
                                                                        .bitsStats[
                                                                            index]
                                                                        .monthlyChangePercentage
                                                                        .isNegative
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '${bist.bitsStats[index].monthlyChangePercentage.toString()}%',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons
                                                              .arrow_drop_down),
                                                          onPressed: () {
                                                            Provider.of<BitsStatDetailProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changemonthly();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: value2.monthly,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Aylik Degisim',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .monthlyChange
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .monthlyChange
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Aylik En Yuksek',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .monthlyHighest
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .monthlyHighest
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Aylik En Dusuk',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .monthlyLowest
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .monthlyLowest
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
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
                                    ),
                                    Card(
                                      child: Consumer<BitsStatDetailProvider>(
                                        builder: (context, value2, child) =>
                                            Container(
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Yillik İstatistikler',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                color: bist
                                                                        .bitsStats[
                                                                            index]
                                                                        .yearlyChangePercentage
                                                                        .isNegative
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .green),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                '${bist.bitsStats[index].yearlyChangePercentage.toString()}%',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                          icon: Icon(Icons
                                                              .arrow_drop_down),
                                                          onPressed: () {
                                                            Provider.of<BitsStatDetailProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changeyearly();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: value2.yearly,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Yillik Degisim',
                                                                style: GoogleFonts.quicksand(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                bist
                                                                    .bitsStats[
                                                                        index]
                                                                    .yearlyChange
                                                                    .toString(),
                                                                style: GoogleFonts.quicksand(
                                                                    color: bist
                                                                            .bitsStats[
                                                                                index]
                                                                            .yearlyChange
                                                                            .isNegative
                                                                        ? Colors
                                                                            .red
                                                                        : Colors
                                                                            .green,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
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
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
