import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:google_fonts/google_fonts.dart';
import 'package:haber/Providers/FinansProviders/1000TLProvider.dart';
import 'package:provider/provider.dart';

class BinTL extends StatefulWidget {
  const BinTL({
    Key key,
  }) : super(key: key);
  @override
  _BinTLState createState() => _BinTLState();
}

class _BinTLState extends State<BinTL> {
  @override
  void initState() {
    Provider.of<Provider1000TL>(context, listen: false).getData('daily');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    '1000 TL\'ye ne oldu?',
                    style: GoogleFonts.quicksand(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Consumer<Provider1000TL>(
                      builder: (context, value, child) =>
                          SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          //  mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: FilterChip(
                                  selectedColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  selected: value.currentselected1000tl == 1
                                      ? true
                                      : false,
                                  //padding: EdgeInsets.all(5),
                                  label: Text('Günlük'),
                                  onSelected: (select) {
                                    /* Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('daily',
                                            value.selectedhisse.symbol);*/
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .changecurrentselected1000tl(1);
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('daily');
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: FilterChip(
                                  selectedColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  selected: value.currentselected1000tl == 2
                                      ? true
                                      : false,
                                  //padding: EdgeInsets.all(5),
                                  label: Text('Haftalık'),
                                  onSelected: (select) {
                                    /* Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('weekly',
                                            value.selectedhisse.symbol);*/
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .changecurrentselected1000tl(2);
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('weekly');
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: FilterChip(
                                  selectedColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  selected: value.currentselected1000tl == 3
                                      ? true
                                      : false,
                                  //padding: EdgeInsets.all(5),
                                  label: Text('Aylık'),
                                  onSelected: (select) {
                                    /* Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('monthly',
                                            value.selectedhisse.symbol);*/
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .changecurrentselected1000tl(3);
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('monthly');
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: FilterChip(
                                  selectedColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  selected: value.currentselected1000tl == 4
                                      ? true
                                      : false,
                                  //padding: EdgeInsets.all(1),
                                  label: Text('Yıllık'),
                                  onSelected: (select) {
                                    /*  Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('yearly',
                                            value.selectedhisse.symbol);*/
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .changecurrentselected1000tl(4);
                                    Provider.of<Provider1000TL>(context,
                                            listen: false)
                                        .getData('yearly');
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        child: Consumer<Provider1000TL>(
                          builder: (context, value, child) => charts.BarChart(
                            [
                              charts.Series(
                                data: value.currencylist,
                                id: 'Clicks',
                                domainFn: (clickData, _) => clickData.name,
                                measureFn: (clickData, _) => clickData.val,
                                // colorFn: (clickData, _) => clickData.color,
                                labelAccessorFn: (clickData, _) =>
                                    clickData.val.toString(),
                              ),
                            ],
                            domainAxis:
                                charts.OrdinalAxisSpec(showAxisLine: true),
                            barRendererDecorator:
                                charts.BarLabelDecorator<String>(
                              insideLabelStyleSpec:
                                  new charts.TextStyleSpec(),
                            ),
                            animate: true,
                          ),
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
    );
  }
}
