import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vietnamcovidtracking/source/pages/home/view/home_page.dart';
import 'package:vietnamcovidtracking/source/pages/map/view/map_page.dart';
import 'package:vietnamcovidtracking/source/pages/news/view/news_page.dart';
import 'package:vietnamcovidtracking/source/pages/statistics/view/statistics_page.dart';
import 'package:vietnamcovidtracking/source/pages/vaccination/view/vaccination_page.dart';

class MenuTabItem {
  final int id;
  final String title;
  final String appBarTitle;
  final Widget widget;
  final IconData iconData;
  final String routeName;
  MenuTabItem(
      {required this.id,
      required this.appBarTitle,
      required this.title,
      required this.widget,
      required this.iconData,
      required this.routeName});

  static List<MenuTabItem> listMenuItem = <MenuTabItem>[
    MenuTabItem(
        id: 0,
        title: "Trang chủ",
        appBarTitle: "Trang chủ",
        iconData: LineIcons.home,
        widget: const HomePage(),
        routeName: HomePage.routeName),
    MenuTabItem(
        id: 1,
        title: "Thống kê",
        appBarTitle: "Thống kê ca nhiễm",
        iconData: LineIcons.barChartAlt,
        widget: const StatisticsPage(),
        routeName: StatisticsPage.routeName),
    MenuTabItem(
        id: 2,
        title: "Bản đồ",
        appBarTitle: "Bản đồ vùng dịch",
        iconData: LineIcons.map,
        widget: const MapPage(),
        routeName: VaccinationPage.routeName),
    MenuTabItem(
        id: 3,
        title: "Số liệu",
        appBarTitle: "Số liệu tiêm chủng",
        iconData: LineIcons.database,
        widget: const VaccinationPage(),
        routeName: VaccinationPage.routeName),
    MenuTabItem(
        id: 4,
        title: "Thông tin",
        appBarTitle: "Tin tức Covid-19",
        iconData: LineIcons.newspaperAlt,
        widget: const NewsPage(),
        routeName: NewsPage.routeName),
  ];
}
