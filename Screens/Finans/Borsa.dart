import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Models/Hisseler.dart';
import 'package:haber/Providers/FinansProviders/BorsaProvider.dart';
import 'package:haber/Models/snapshots.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class Borsa extends StatefulWidget {
  const Borsa({
    Key key,
  }) : super(key: key);
  @override
  _BorsaState createState() => _BorsaState();
}

class _BorsaState extends State<Borsa> with AutomaticKeepAliveClientMixin {
  bool showLoading = false;
  MainState _mainState = MainState.NONE;
  SecondaryState _secondaryState = SecondaryState.NONE;
  @override
  void initState() {
    Provider.of<BorsaProvider>(context, listen: false)
        .getData('daily', 'SG14BIL');
    Provider.of<BorsaProvider>(context, listen: false).getHisse();
    Provider.of<BorsaProvider>(context, listen: false).getcodeinfo('SG14BIL');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<BorsaProvider>(
            builder: (context, value, child) {
              return SmartSelect<Hisse>.single(
                choiceGroupBuilder: (context, header, choices) {
                  return StickyHeader(
                    header: header,
                    content: choices,
                  );
                },
                placeholder: 'Hisse Secin',
                modalTitle: 'Hisse Ara',
                modalFilter: true,
                choiceStyle: S2ChoiceStyle(color: Colors.black),
                modalStyle: S2ModalStyle(
                    backgroundColor: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.antiAlias),
                choiceHeaderStyle:
                    S2ChoiceHeaderStyle(backgroundColor: Colors.grey[400]),
                modalFilterHint: 'ara',
                //groupEnabled: true,
                choiceType: S2ChoiceType.radios,
                choiceLayout: S2ChoiceLayout.list,
                title: 'Hisseler',
                choiceGrouped: true,
                modalType: S2ModalType.bottomSheet,
                value: value.selectedhisse,
                choiceItems: value.hisseler.map((e) {
                  return S2Choice(value: e, title: e.name, group: e.exchange);
                }).toList(),
                onChange: (state) => {
                  Provider.of<BorsaProvider>(context, listen: false)
                      .changeVal(state.value),
                  Provider.of<BorsaProvider>(context, listen: false)
                      .getData('daily', state.value.symbol),
                  Provider.of<BorsaProvider>(context, listen: false)
                      .getcodeinfo(state.value.code),
                  Provider.of<BorsaProvider>(context, listen: false)
                      .changeCurrentSelectedTime(1)
                },
              );
            },
          ),
          Selector<BorsaProvider, Snapshots>(
            selector: (context, borsa) => borsa.snapshots,
            builder: (context, value, child) {
              if (value != null) {
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value.data.items.scad.first.name ?? '-',
                          style: GoogleFonts.quicksand(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value.data.items.scad.first.time ?? '-',
                          style: GoogleFonts.quicksand(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Text('Yukleniyor');
              }
            },
          ),
          Stack(
            children: [
              SizedBox(
                height: 240,
                width: double.infinity,
                child: Consumer<BorsaProvider>(
                  builder: (context, data, child) {
                    if (data.dat != null) {
                      return Selector<BorsaProvider, dynamic>(
                        selector: (context, finance) => finance.isLine,
                        builder: (context, isLine, child) => ClipRRect(
                          child: KChartWidget(
                            data.dat,
                            volHidden: true,
                            maDayList: [5, 10, 20],
                            isLine: isLine,
                            mainState: _mainState,
                            secondaryState: _secondaryState,
                            fixedLength: 2,
                            timeFormat: TimeFormat.YEAR_MONTH_DAY_WITH_HOUR,
                            isChinese: false,
                            bgColor: [
                              Color(0xFF121128),
                              Color(0xFF121128),
                              Color(0xFF121128)
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 240,
                            width: double.infinity,
                            child: ClipRRect(
                              child: KChartWidget(
                                null,
                                volHidden: true,
                                maDayList: [5, 10, 20],
                                isLine: true,
                                mainState: _mainState,
                                secondaryState: _secondaryState,
                                fixedLength: 2,
                                timeFormat: TimeFormat.YEAR_MONTH_DAY_WITH_HOUR,
                                isChinese: false,
                                bgColor: [
                                  Color(0xFF121128),
                                  Color(0xFF121128),
                                  Color(0xFF121128)
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Text("Yukleniyor"),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Selector<BorsaProvider, bool>(
                  selector: (_, borsa) => borsa.isLine,
                  builder: (context, value, child) => Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Provider.of<BorsaProvider>(context, listen: false)
                                .changeChartType();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey[100],
                            ),
                            child: Icon(
                              value ? Icons.equalizer : Icons.insights_rounded,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              String symbol = Provider.of<BorsaProvider>(
                                      context,
                                      listen: false)
                                  .selectedhisse
                                  .symbol;
                              Provider.of<BorsaProvider>(context, listen: false)
                                  .getData('daily', symbol ?? "SG14BIL");
                              Provider.of<BorsaProvider>(context, listen: false)
                                  .changeCurrentSelectedTime(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey[100],
                              ),
                              child: Icon(
                                Icons.refresh_rounded,
                                size: 30,
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
          Consumer<BorsaProvider>(
            builder: (context, value, child) => Container(
              decoration: BoxDecoration(color: Colors.white),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  //  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        backgroundColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .dailyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        disabledColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .dailyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        selectedColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .dailyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red
                                : Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        selected: value.currentselectedtime == 1 ? true : false,
                        //padding: EdgeInsets.all(5),
                        label: Text('Günlük'),
                        onSelected: (select) {
                          Provider.of<BorsaProvider>(context, listen: false)
                              .getData('daily', value.selectedhisse.symbol);
                          Provider.of<BorsaProvider>(context, listen: false)
                              .changeCurrentSelectedTime(1);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        backgroundColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .weeklyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        disabledColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .weeklyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        selectedColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .weeklyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red
                                : Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        selected: value.currentselectedtime == 2 ? true : false,
                        //padding: EdgeInsets.all(5),
                        label: Text('Haftalık'),
                        onSelected: (select) {
                          Provider.of<BorsaProvider>(context, listen: false)
                              .getData('weekly', value.selectedhisse.symbol);
                          Provider.of<BorsaProvider>(context, listen: false)
                              .changeCurrentSelectedTime(2);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        backgroundColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        disabledColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        selectedColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red
                                : Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        selected: value.currentselectedtime == 3 ? true : false,
                        //padding: EdgeInsets.all(5),
                        label: Text('Aylık'),
                        onSelected: (select) {
                          Provider.of<BorsaProvider>(context, listen: false)
                              .getData('monthly', value.selectedhisse.symbol);
                          Provider.of<BorsaProvider>(context, listen: false)
                              .changeCurrentSelectedTime(3);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        backgroundColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        disabledColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        selectedColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red
                                : Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        selected: value.currentselectedtime == 4 ? true : false,
                        //padding: EdgeInsets.all(5),
                        label: Text('3 Aylık'),
                        onSelected: (select) {
                          Provider.of<BorsaProvider>(context, listen: false)
                              .getData('3months', value.selectedhisse.symbol);
                          Provider.of<BorsaProvider>(context, listen: false)
                              .changeCurrentSelectedTime(4);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        backgroundColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        disabledColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        selectedColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .monthlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red
                                : Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        selected: value.currentselectedtime == 5 ? true : false,
                        //padding: EdgeInsets.all(5),
                        label: Text('6 Aylık'),
                        onSelected: (select) {
                          Provider.of<BorsaProvider>(context, listen: false)
                              .getData('6months', value.selectedhisse.symbol);
                          Provider.of<BorsaProvider>(context, listen: false)
                              .changeCurrentSelectedTime(5);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        backgroundColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .yearlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        disabledColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .yearlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        selectedColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .yearlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red
                                : Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        selected: value.currentselectedtime == 6 ? true : false,
                        //padding: EdgeInsets.all(1),
                        label: Text('Yıllık'),
                        onSelected: (select) {
                          Provider.of<BorsaProvider>(context, listen: false)
                              .getData('yearly', value.selectedhisse.symbol);
                          Provider.of<BorsaProvider>(context, listen: false)
                              .changeCurrentSelectedTime(6);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: FilterChip(
                        backgroundColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .yearlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        disabledColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .yearlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red[100]
                                : Colors.green[100]
                            : Colors.blueGrey[100],
                        selectedColor: value.snapshots != null
                            ? value.snapshots.data.items.scad.first
                                        .yearlyChangePercentage.isNegative ??
                                    Colors.blueGrey[100]
                                ? Colors.red
                                : Colors.green
                            : Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        selected: value.currentselectedtime == 7 ? true : false,
                        //padding: EdgeInsets.all(1),
                        label: Text('5 Yıl'),
                        onSelected: (select) {
                          Provider.of<BorsaProvider>(context, listen: false)
                              .getData('5years', value.selectedhisse.symbol);
                          Provider.of<BorsaProvider>(context, listen: false)
                              .changeCurrentSelectedTime(7);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Selector<BorsaProvider, Snapshots>(
            selector: (context, borsa) => borsa.snapshots,
            builder: (context, value, child) {
              if (value != null) {
                return Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Deger',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        value.data.items.scad.first.value
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Gunluk Degisim%',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .dailyChangePercentage !=
                                              0
                                          ? value
                                                  .data
                                                  .items
                                                  .scad
                                                  .first
                                                  .dailyChangePercentage
                                                  .isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[200],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .dailyChangePercentage !=
                                                    0
                                                ? value
                                                        .data
                                                        .items
                                                        .scad
                                                        .first
                                                        .dailyChangePercentage
                                                        .isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .dailyChangePercentage
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Haftalik Degisim%',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .weeklyChangePercentage !=
                                              0
                                          ? value
                                                  .data
                                                  .items
                                                  .scad
                                                  .first
                                                  .weeklyChangePercentage
                                                  .isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .weeklyChangePercentage !=
                                                    0
                                                ? value
                                                        .data
                                                        .items
                                                        .scad
                                                        .first
                                                        .weeklyChangePercentage
                                                        .isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .weeklyChangePercentage
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Aylik Degisim%',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .monthlyChangePercentage !=
                                              0
                                          ? value
                                                  .data
                                                  .items
                                                  .scad
                                                  .first
                                                  .monthlyChangePercentage
                                                  .isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .monthlyChangePercentage !=
                                                    0
                                                ? value
                                                        .data
                                                        .items
                                                        .scad
                                                        .first
                                                        .monthlyChangePercentage
                                                        .isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .monthlyChangePercentage
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Yillik Degisim%',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .yearlyChangePercentage !=
                                              0
                                          ? value
                                                  .data
                                                  .items
                                                  .scad
                                                  .first
                                                  .yearlyChangePercentage
                                                  .isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .yearlyChangePercentage !=
                                                    0
                                                ? value
                                                        .data
                                                        .items
                                                        .scad
                                                        .first
                                                        .yearlyChangePercentage
                                                        .isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .yearlyChangePercentage
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Gunluk Degisim',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .dailyChange !=
                                              0
                                          ? value.data.items.scad.first
                                                  .dailyChange.isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .dailyChange !=
                                                    0
                                                ? value.data.items.scad.first
                                                        .dailyChange.isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .dailyChange
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Haftalik Degisim',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .weeklyChange !=
                                              0
                                          ? value.data.items.scad.first
                                                  .weeklyChange.isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .weeklyChange !=
                                                    0
                                                ? value.data.items.scad.first
                                                        .weeklyChange.isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .weeklyChange
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Aylik Degisim',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .monthlyChange !=
                                              0
                                          ? value.data.items.scad.first
                                                  .monthlyChange.isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .monthlyChange !=
                                                    0
                                                ? value
                                                        .data
                                                        .items
                                                        .scad
                                                        .first
                                                        .monthlyChange
                                                        .isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .monthlyChange
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Yillik Degisim',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: value.data.items.scad.first
                                                  .yearlyChange !=
                                              0
                                          ? value.data.items.scad.first
                                                  .yearlyChange.isNegative
                                              ? Colors.red
                                              : Colors.green
                                          : Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Icon(
                                            value.data.items.scad.first
                                                        .yearlyChange !=
                                                    0
                                                ? value.data.items.scad.first
                                                        .yearlyChange.isNegative
                                                    ? Icons
                                                        .trending_down_rounded
                                                    : Icons.trending_up_rounded
                                                : Icons
                                                    .trending_neutral_rounded,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            value.data.items.scad.first
                                                    .yearlyChange
                                                    .toString() ??
                                                '-',
                                            style: GoogleFonts.quicksand(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Gunluk En Yuksek',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        value.data.items.scad.first.dailyHighest
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Haftalik En Yuksek',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        value.data.items.scad.first
                                                .weeklyHighest
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Aylik En Yuksek',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        value.data.items.scad.first
                                                .monthlyHighest
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
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
                    Card(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Gunluk En Dusuk',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        value.data.items.scad.first.dailyLowest
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Haftalik En Dusuk',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        value.data.items.scad.first.weeklyLowest
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Aylik En Dusuk',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        value.data.items.scad.first
                                                .monthlyLowest
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
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
                    Card(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
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
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        value.data.items.scad.first.ask
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Bid',
                                    style: GoogleFonts.quicksand(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[300],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: Text(
                                        value.data.items.scad.first.bid
                                                .toString() ??
                                            '-',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
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
                  ],
                );
              } else {
                return Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Yukleniyor',
                        style: GoogleFonts.quicksand(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          Row(
            children: [
              FlatButton(
                  onPressed: () {
                    Provider.of<BorsaProvider>(context, listen: false)
                        .changeChartType();
                  },
                  child: Text('Change Chart Type')),
              FlatButton(
                onPressed: () {
                  Provider.of<BorsaProvider>(context, listen: false)
                      .changeChartType();
                },
                child: Text('Canlı İzle'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
