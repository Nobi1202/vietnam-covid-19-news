import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vietnamcovidtracking/source/config/size_app.dart';
import 'package:vietnamcovidtracking/source/config/theme_app.dart';
import 'package:vietnamcovidtracking/source/models/view_chart_data.dart';
import 'package:vietnamcovidtracking/source/pages/statistics/bloc/statistics_bloc.dart';
import 'package:vietnamcovidtracking/source/widget/loading_widget.dart';

enum CovidNumberType { infections, beingtreated, gotcured, dead }

class StatisticsPage extends StatefulWidget {
  static const String routeName = "/statisticsPage";
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late GlobalKey _statisticsglobalKey;

  @override
  void initState() {
    _statisticsglobalKey = GlobalKey();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsBloc()..add(const LoadEvent()),
      child: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<StatisticsBloc>(context);

          Widget _statistics() {
            Widget __statisticItem(
                {required Color backgroundColor,
                required String title,
                required int value,
                int? plusvalue}) {
              // Color _backgroundColor = ThemePrimary.green;
              double _currentRadius = 8;

              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0.4)
                      ], begin: Alignment.bottomCenter, end: Alignment.topLeft),
                      boxShadow: ThemePrimary.boxShadow,
                      borderRadius: BorderRadius.circular(_currentRadius)),
                  padding: const EdgeInsets.all(SizeApp.normalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        NumberFormat.decimalPattern().format(value),
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          plusvalue != null
                              ? const Icon(Icons.arrow_upward,
                                  size: 14.0, color: Colors.white)
                              : const SizedBox(),
                          Text(
                            plusvalue == null
                                ? ""
                                : NumberFormat.decimalPattern()
                                    .format(plusvalue),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }

            int _treatedValue = 0;
            if (bloc.summPatient != null) {
              _treatedValue = (bloc.summPatient?.data.confirmed ?? 0) -
                  (bloc.summPatient?.data.recovered ?? 0) -
                  (bloc.summPatient?.data.death ?? 0);
            }
            String _lastTimeUpdate = bloc.summPatient != null
                ? DateFormat("dd/MM/yyyy")
                    .format(bloc.summPatient!.data.createdDate)
                : "";
            return Container(
              padding: const EdgeInsets.only(
                  left: SizeApp.normalPadding,
                  right: SizeApp.normalPadding,
                  bottom: SizeApp.normalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tổng số ca nhiễm trong nước",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white)),
                  // if (summPatient != null)
                  Container(
                      margin: const EdgeInsets.only(top: SizeApp.normalPadding),
                      child: Row(children: [
                        __statisticItem(
                            title: "Số ca nhiễm",
                            backgroundColor: ThemePrimary.red,
                            value: bloc.summPatient?.data.confirmed ?? 0,
                            plusvalue:
                                bloc.summPatient?.data.plusConfirmed ?? 0),
                        const SizedBox(width: SizeApp.paddingTxt),
                        __statisticItem(
                            title: "Đang điều trị",
                            backgroundColor: ThemePrimary.blue,
                            value: _treatedValue),
                      ])),
                  // if (summPatient != null)s
                  Container(
                      margin: const EdgeInsets.only(top: SizeApp.paddingTxt),
                      child: Row(children: [
                        __statisticItem(
                            title: "Đã khỏi bệnh",
                            backgroundColor: ThemePrimary.green,
                            value: bloc.summPatient?.data.recovered ?? 0,
                            plusvalue:
                                bloc.summPatient?.data.plusRecovered ?? 0),
                        const SizedBox(width: SizeApp.paddingTxt),
                        __statisticItem(
                            title: "Tử vong",
                            backgroundColor: ThemePrimary.orange,
                            value: bloc.summPatient?.data.death ?? 0,
                            plusvalue: bloc.summPatient?.data.plusDeath ?? 0),
                      ])),
                  // if (summPatient != null)
                  Container(
                      padding: const EdgeInsets.all(SizeApp.paddingTxt),
                      child: Center(
                          child: Text(
                        "* Dữ liệu cập nhật ngày $_lastTimeUpdate",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      ))),
                ],
              ),
            );
          }

          Widget _chart() {
            SfCartesianChart _buildDefaultAreaChart() {
              List<ChartSeries<ChartData, dynamic>> _getDefaultAreaSeries() {
                return <ChartSeries<ChartData, dynamic>>[
                  SplineAreaSeries<ChartData, dynamic>(
                    onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
                      return CustomSplineAreaSeriesRenderer(series);
                    },
                    gradient: LinearGradient(colors: [
                      ThemePrimary.red,
                      ThemePrimary.red.withOpacity(0.2)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    dataSource: bloc.lstChartData ?? [],
                    opacity: 0.7,
                    borderColor: ThemePrimary.red,
                    borderDrawMode: BorderDrawMode.top,
                    name: 'Ca nhiễm',
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.y,
                  ),
                  SplineAreaSeries<ChartData, dynamic>(
                    onCreateRenderer: (ChartSeries<ChartData, dynamic> series) {
                      return CustomSplineAreaSeriesRenderer(series);
                    },
                    gradient: LinearGradient(colors: [
                      ThemePrimary.orange,
                      ThemePrimary.orange.withOpacity(0.2)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    // borderWidth: 2,
                    opacity: 0.7,
                    borderColor: ThemePrimary.orange,
                    borderDrawMode: BorderDrawMode.top,
                    dataSource: bloc.lstChartData ?? [],
                    name: 'Tử vong',
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) =>
                        sales.secondSeriesYValue,
                  )
                ];
              }

              return SfCartesianChart(
                legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                    legendItemBuilder: (String name, dynamic series,
                        dynamic point, int index) {
                      return SizedBox(
                          height: 24,
                          // padding: const EdgeInsets.only(bottom: 8.0),
                          // width: 100,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                index != 0
                                    ? Icon(Icons.circle,
                                        size: 16.0, color: ThemePrimary.orange)
                                    : Icon(Icons.circle,
                                        size: 14.0, color: ThemePrimary.red),
                                const SizedBox(width: 4.0),
                                Text(series.name,
                                    style:
                                        Theme.of(context).textTheme.subtitle2!),
                                const SizedBox(width: 4.0),
                              ]));
                    },
                    orientation: LegendItemOrientation.horizontal,
                    alignment: ChartAlignment.near,
                    position: LegendPosition.top),
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  labelPlacement: LabelPlacement.onTicks,
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}',
                ),
                series: _getDefaultAreaSeries(),
                tooltipBehavior: TooltipBehavior(enable: true),
              );
            }

            return Expanded(
              // maxHeight: MediaQuery.of(context).size.height,
              child: Container(
                padding: const EdgeInsets.only(top: SizeApp.normalPadding),
                decoration: BoxDecoration(
                    color: ThemePrimary.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    Text("Biểu đồ số ca nhiễm và tử vong",
                        style:
                            Theme.of(context).textTheme.headline2!.copyWith()),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<StatisticsBloc>(
                                _statisticsglobalKey.currentContext!)
                            .add(ChangeProvinceEvent(
                                lastProvince: bloc.provinceSelected!,
                                context: context));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(bloc.provinceSelected?.title ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ThemePrimary.primaryColor,
                                    )),
                            Icon(
                              Icons.arrow_drop_down,
                              color: ThemePrimary.primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: bloc.state is OnLoadingChartState
                              ? const LoadingWidget()
                              : _buildDefaultAreaChart()),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            key: _statisticsglobalKey,
            backgroundColor: ThemePrimary.primaryColor,
            body: state is LoadingState
                ? const LoadingWidget()
                : RefreshIndicator(
                    onRefresh: () async => bloc.add(const RefeshEvent()),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        // Size screen - appbar - bottom bar - status - padding x2
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight -
                            kToolbarHeight -
                            MediaQuery.of(context).padding.top -
                            SizeApp.normalPadding * 2,
                        child: Column(
                          children: <Widget>[
                            _statistics(),
                            _chart(),
                            // Placeholder()
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
